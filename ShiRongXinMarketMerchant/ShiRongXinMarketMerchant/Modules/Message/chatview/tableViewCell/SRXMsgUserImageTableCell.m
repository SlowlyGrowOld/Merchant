//
//  SRXMsgUserImageTableCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/26.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgUserImageTableCell.h"
#import "YBImageBrowser.h"
#import "SHActivityIndicatorView.h"

@interface SRXMsgUserImageTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *user_image;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConsW;
@property (weak, nonatomic) IBOutlet UILabel *hintLb;
@property (weak, nonatomic) IBOutlet SHActivityIndicatorView *activityView;
@property (nonatomic, strong) YBImageBrowser *browser;
@end

@implementation SRXMsgUserImageTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    MJWeakSelf;
    [_image jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [weakSelf lookImage];
    }];
    [_activityView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationMsgSendFail object:nil userInfo:@{@"info":self.model}];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXMsgChatModel *)model {
    _model = model;
    self.hintLb.hidden = YES;
    [_user_image sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _user_name.text = model.nickname;
    [_image sd_setImageWithURL:[NSURL URLWithString:model.params] placeholderImage:model.image completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) {
            self.hintLb.hidden = model.image?YES:NO;
        }
    }];
    self.activityView.hidden = YES;
    // 设置发送状态样式
    self.activityView.messageState = model.messageState;
}

- (void)lookImage {
    YBIBImageData *data = [YBIBImageData new];
    data.imageURL = [NSURL URLWithString:self.model.params];
    data.projectiveView = _image;
    
    self.browser = [YBImageBrowser new];
    _browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    _browser.dataSourceArray = @[data];
    _browser.currentPage = 0;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
    [_browser show];
}

@end
