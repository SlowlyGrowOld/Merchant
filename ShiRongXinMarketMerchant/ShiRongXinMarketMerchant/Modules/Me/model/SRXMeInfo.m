//
//  SRXMeInfo.m
//  ShiRongXinMarketMerchant
//
//  Created by wyb on 2023/5/15.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMeInfo.h"

@implementation SRXMeShopUserInfo

@end

@implementation SRXMeShopItem

@end

@implementation SRXMeInfo
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"shop_arr":@"SRXMeShopItem"};
}
@end
