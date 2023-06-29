//
//  SRXOrderLogisticsDetailsVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/25.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderLogisticsDetailsVC : RootTableViewController
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *express_sn;
/**默认1。1=普通订单，2=售后订单*/
@property (nonatomic, copy) NSString *order_type;
/**售后订单id*/
@property (nonatomic, copy) NSString *order_return_id;
@end

NS_ASSUME_NONNULL_END
