//
//  SRXShopInfoModel.h
//  ShiRongXinMarketMerchant
//
//  Created by wyb on 2023/5/15.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXShop_info :NSObject
@property (nonatomic , copy) NSString              * shop_user_avatar;
@property (nonatomic , copy) NSString              * shop_user_nickname;
@property (nonatomic , copy) NSString              * shop_img;

@end


@interface SRXShopOrderInfo :NSObject
@property (nonatomic , assign) NSInteger              all_order_num;
@property (nonatomic , assign) NSInteger              yesterday_order_num;

@end

@interface SRXShopInfoModel : NSObject
@property (nonatomic , strong) SRXShop_info              * shop_info;
@property (nonatomic , strong) SRXShopOrderInfo              * order_num_info;
@end

NS_ASSUME_NONNULL_END
