//
//  SRXIncomeInfo.h
//  ShiRongXinMarketMerchant
//
//  Created by wyb on 2023/5/15.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXIncomeInfo : NSObject
@property (nonatomic , copy) NSString              * integral_num;
@property (nonatomic , copy) NSString              * wechat_pay;
@property (nonatomic , copy) NSString              * ali_pay;
@property (nonatomic , copy) NSString              * balance_pay;
@property (nonatomic , copy) NSString              * coupon_pay;
@property (nonatomic , copy) NSString              * shipping_pay;
@end

NS_ASSUME_NONNULL_END
