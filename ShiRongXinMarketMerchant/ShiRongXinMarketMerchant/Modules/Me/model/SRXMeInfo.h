//
//  SRXMeInfo.h
//  ShiRongXinMarketMerchant
//
//  Created by wyb on 2023/5/15.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXMeShopUserInfo :NSObject
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , copy) NSString              * mobile;

@end


@interface SRXMeShopItem :NSObject
@property (nonatomic , copy) NSString              * shop_img;
@property (nonatomic , copy) NSString              * shop_name;

@end

@interface SRXMeInfo : NSObject
@property (nonatomic , strong) SRXMeShopUserInfo              * shop_user_info;
@property (nonatomic , strong) NSArray <SRXMeShopItem *>              * shop_arr;
@end

NS_ASSUME_NONNULL_END
