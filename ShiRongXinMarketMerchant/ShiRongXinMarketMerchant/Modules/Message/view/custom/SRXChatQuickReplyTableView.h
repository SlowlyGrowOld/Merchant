//
//  SRXChatQuickReplyTableView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/16.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXMessageSetModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SRXChatQuickReplyBlock)(SRXMsgReplysItem *item);

@interface SRXChatQuickReplyTableView : UITableView
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) SRXChatQuickReplyBlock selectBlock;
@end

NS_ASSUME_NONNULL_END
