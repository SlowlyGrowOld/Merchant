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
@property (nonatomic, copy) NSString *order_id;

@property (nonatomic, assign) BOOL is_distribute;
@end

NS_ASSUME_NONNULL_END
