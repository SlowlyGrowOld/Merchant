//
//  SRXMsgUserAudioTableCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/11/1.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgUserAudioTableCell.h"
#import "SHActivityIndicatorView.h"

//录音最大时长
#define kSHMaxRecordTime 15

@interface SRXMsgUserAudioTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *user_image;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UIImageView *voiceImg;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet SHActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *voiceBgViewConsW;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation SRXMsgUserAudioTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _voiceImg.animationDuration = 1;
    _voiceImg.animationRepeatCount = 0;
    //动画
    self.voiceImg.image = [UIImage imageNamed:@"chat_receive_voice4"];
    self.voiceImg.animationImages = @[
        [UIImage imageNamed:@"chat_send_voice1"],
        [UIImage imageNamed:@"chat_send_voice2"],
        [UIImage imageNamed:@"chat_send_voice3"],
        [UIImage imageNamed:@"chat_send_voice4"]
    ];
    MJWeakSelf;
    [self.bgView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        if (weakSelf.playBlock) {
            weakSelf.playBlock();
        }
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
    [_user_image sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _user_name.text = model.nickname;
    //语音时长
    self.num.text = [NSString stringWithFormat:@"%@\"", model.duration];
    self.voiceImg.image = self.voiceImg.animationImages.lastObject;
    
    if (model.isPlaying) {
        [self.voiceImg startAnimating];
    }else{
        [self.voiceImg stopAnimating];
    }
    self.voiceBgViewConsW.constant = (160-60)/kSHMaxRecordTime*[model.duration integerValue]+60;
    self.activityView.hidden = YES;
    // 设置发送状态样式
    self.activityView.messageState = model.messageState;
}

#pragma mark - 语音动画
#pragma mark 语音播放开始动画
- (void)playVoiceAnimation
{
    if (self.voiceImg.isAnimating) {
        [self.voiceImg stopAnimating];
    }
 
    [self.voiceImg startAnimating];
}

#pragma mark 语音播放停止动画
- (void)stopVoiceAnimation
{
    [self.voiceImg stopAnimating];
}
@end
