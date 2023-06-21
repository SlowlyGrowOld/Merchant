//
//  SRXSpecGoodsPriceModel.h
//  ShiRongXinMarketMallProject
//
//  Created by Alucardulad on 2/12/20.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXSpecGoodsPriceModel : SRXBaseModel
@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *key_name;
@property (strong, nonatomic) NSString *market_price;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *spec_img;
@property (strong, nonatomic) NSString *spec_key;
@property (strong, nonatomic) NSString *store_count;
@property (strong, nonatomic) NSString *package_price;
@property (assign, nonatomic) CGFloat   after_coupon_price;
@property (assign, nonatomic) CGFloat   member_price;

/// 拼团区分的数据;
@property (nonatomic , copy) NSString              * head_price;
@property (nonatomic , assign) NSInteger              head_exchange_integral;
@property (nonatomic , copy) NSString              * group_price;
@property (nonatomic , assign) NSInteger              exchange_integral;
/// 价格
@property (nonatomic, copy) NSString *single_price;

@end

NS_ASSUME_NONNULL_END
