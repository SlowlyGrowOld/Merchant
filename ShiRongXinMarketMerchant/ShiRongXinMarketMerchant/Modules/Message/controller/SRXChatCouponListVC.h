//
//  SRXChatCouponListVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/14.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "JHBaseTableViewController.h"
#import "SRXMsgChatModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SRXChatCouponBlock)(SRXMsgChatCoupnItem *model);
@interface SRXChatCouponListVC : JHBaseTableViewController
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) SRXChatCouponBlock selectBlock;
@end

NS_ASSUME_NONNULL_END
