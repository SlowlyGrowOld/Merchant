//
//  SRXOrderGoodsShippedVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderGoodsShippedVC : RootViewController
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *order_id;

@property (nonatomic, assign) BOOL is_distribute;//多件商品部分商品已发货  只显示分包裹发货

@property (nonatomic, assign) BOOL is_single;//一件商品隐藏 分包裹发货
@end

NS_ASSUME_NONNULL_END
