//
//  SRXMsgShopAudioTableCell.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/11/1.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXMsgChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXMsgShopAudioTableCell : UITableViewCell
@property (nonatomic,strong) SRXMsgChatModel *model;
@property (nonatomic,copy) dispatch_block_t playBlock;
//播放语音动画
- (void)playVoiceAnimation;
//停止语音动画
- (void)stopVoiceAnimation;
@end

NS_ASSUME_NONNULL_END
