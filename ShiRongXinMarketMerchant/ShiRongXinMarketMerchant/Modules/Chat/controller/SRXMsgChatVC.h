//
//  SRXMsgChatVC.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/20.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "RootViewController.h"
#import "SRXMsgChatModel.h"
#import "SRXMessageListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXMsgChatVC : RootViewController
@property (nonatomic, strong) SRXMessageListModel *item;
/**要咨询的商品信息-简*/
@property (nonatomic, copy) SRXMsgGoodsInfoItem *goodInfo;
/**要咨询的订单信息*/
@property (nonatomic, strong) SRXMsgOrderInfo *orderInfo;

@property (nonatomic, copy) NSString *shop_id;
@end

NS_ASSUME_NONNULL_END
