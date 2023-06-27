//
//  SRXMsgChatSetAlertVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/19.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"
#import "SRXMessageListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXMsgChatSetAlertVC : RootPresentViewController
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, strong) SRXMessageListModel *item;
@property (nonatomic, copy) dispatch_block_t refreshBlock;
@end

NS_ASSUME_NONNULL_END
