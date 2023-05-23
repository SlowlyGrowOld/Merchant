//
//  SRXShopDataItem.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/25.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXShopDataItem : SRXBaseModel
@property (nonatomic , copy) NSString              * shop_id;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * shop_img;
@property (nonatomic , assign) NSInteger              fans_num;
@property (nonatomic , assign) NSInteger              on_sale_num;
@property (nonatomic , assign) NSInteger              wait_pay_num;
@property (nonatomic , assign) NSInteger              wait_delivery_num;
@property (nonatomic , assign) NSInteger              after_sale_num;
@property (nonatomic , assign) NSInteger              is_login;

@end

NS_ASSUME_NONNULL_END
