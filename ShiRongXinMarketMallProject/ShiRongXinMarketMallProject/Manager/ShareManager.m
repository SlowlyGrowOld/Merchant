//
//  ShareManager.m
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import "ShareManager.h"
#import <WXApi.h>
#import "NSData+JKData.h"

@implementation WXMiniProgramModel

@end

@implementation ShareManager

SINGLETON_FOR_CLASS(ShareManager);

-(void)showShareView{
   
}

- (void)shareMiniProgramWithModel:(WXMiniProgramModel *)model {
    
    WXMiniProgramObject *object = [WXMiniProgramObject object];
    object.webpageUrl = @"http://www.go-easy.cn/";
    object.userName = @"gh_2a6fc80267f3";
    object.path = model.path;
    UIImage *image = [UIImage imageWithData:model.hdImageData];
    model.hdImageData = [self jk_zipNSDataWithImage:[image jk_imageScaleToSureSize:CGSizeMake(230, 182)]];
    object.hdImageData = model.hdImageData;
    object.miniProgramType = WXMiniProgramTypeRelease;

    WXMediaMessage *message = [WXMediaMessage message];
    message.title = model.title;
    message.description = model.desc;
    [message setThumbImage:[UIImage imageNamed:@"default_avatar"]];
    message.mediaObject = object;

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req completion:^(BOOL success) {
        if (success) {
           
        }else {
            [SVProgressHUD showErrorWithStatus:@"分享失败"];
        }
    }];
}

- (NSData *)jk_zipNSDataWithImage:(UIImage *)sourceImage{
    CGFloat scale = 1.0;
    //进行图像的画面质量压缩
    NSData *data = UIImageJPEGRepresentation(sourceImage, scale);
    while (data.length>128*1024) {
        scale = scale-0.01;
        data = UIImageJPEGRepresentation(sourceImage, scale);
    }
    return data;
}
@end
