//
//  ShareAlert.m
//  JobInterestProject
//
//  Created by 奇林刘 on 2019/10/30.
//  Copyright © 2019 icare. All rights reserved.
//
typedef enum : NSUInteger {
    ShareTypeInviteUrl,
    ShareTypeJob,
    ShareTypeImage
} ShareType;

#import "ShareAlert.h"
#import <WXApi.h>

@interface ShareAlert ()
@property (weak, nonatomic) IBOutlet UIView *wrapper;
@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *shareUrl;
@property (assign, nonatomic) ShareType type;

@end

@implementation ShareAlert

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSelf];
}

#pragma mark - Action
- (IBAction)toFriendAction:(id)sender {
    if (self.type == ShareTypeInviteUrl) {
        [self shareInviteUrlWithScene:WXSceneSession];
    }
    if (self.type == ShareTypeImage) {
        [self shareImageWithScene:WXSceneSession];
    }
    if (self.type == ShareTypeJob) {
        [self shareUrlWithScene:WXSceneSession];
    }
}

- (IBAction)toMomentAction:(id)sender {
    if (self.type == ShareTypeInviteUrl) {
        [self shareInviteUrlWithScene:WXSceneTimeline];
    }
    if (self.type == ShareTypeImage) {
        [self shareImageWithScene:WXSceneTimeline];
    }
    if (self.type == ShareTypeJob) {
        [self shareUrlWithScene:WXSceneTimeline];
    }
}

- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}

#pragma mark - Method
+ (ShareAlert *)show {
    ShareAlert *v = [[NSBundle mainBundle] loadNibNamed:@"ShareAlert" owner:self options:nil].firstObject;
    v.type = ShareTypeInviteUrl;
    v.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    return v;
}

+ (ShareAlert *)showWithShareUrl:(NSString *)shareUrl {
    ShareAlert *v = [[NSBundle mainBundle] loadNibNamed:@"ShareAlert" owner:self options:nil].firstObject;
    v.shareUrl = shareUrl;
    v.type = ShareTypeJob;
    v.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    return v;
}

+ (ShareAlert *)showWithImage:(UIImage *)image {
    ShareAlert *v = [[NSBundle mainBundle] loadNibNamed:@"ShareAlert" owner:self options:nil].firstObject;
    v.image = image;
    v.type = ShareTypeImage;
    v.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    return v;
}

- (void)shareInviteUrlWithScene:(int)scene {
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = @"huaban.com";
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"够容易商城";
    message.description = @"便宜";
    [message setThumbImage:[UIImage imageNamed:@"return_annual"]];
    message.mediaObject = webpageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req completion:^(BOOL success) {
        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
    }];
}

- (void)shareUrlWithScene:(int)scene {
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = self.shareUrl;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"够容易商城";
    message.description = @"便宜";
    [message setThumbImage:[UIImage imageNamed:@"return_annual"]];
    message.mediaObject = webpageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req completion:^(BOOL success) {
        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
    }];
}

- (void)shareImageWithScene:(int)scene {
    NSData *imageData = UIImageJPEGRepresentation(self.image, 0.7);
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;
    
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res5"
                                                         ofType:@"jpg"];
    message.thumbData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req completion:^(BOOL success) {
        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
    }];
}

#pragma mark - Init
- (void)initSelf {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
    [self addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapNoAction = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
    }];
    [self.wrapper addGestureRecognizer:tapNoAction];
    [self.wrapper settingRadius:8 corner:UIRectCornerTopLeft | UIRectCornerTopRight];
}

@end
