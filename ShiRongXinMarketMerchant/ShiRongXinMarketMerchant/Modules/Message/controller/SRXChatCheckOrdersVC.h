//
//  SRXMsgCheckOrdersVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "JHBaseTableViewController.h"
#import "SRXMsgChatModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^SRXMsgCheckOrdersBlock)(SRXMsgOrderInfo *model);

@interface SRXChatCheckOrdersVC : JHBaseTableViewController
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) SRXMsgCheckOrdersBlock selectBlock;
@end

NS_ASSUME_NONNULL_END
