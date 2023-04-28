//
//  SRXOrderListModel.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderListModel.h"

@implementation SRXOrderGoodsItem

@end

@implementation SRXOrderListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"order_goods":@"SRXOrderGoodsItem"};
}

@end

@implementation SRXOrderAfterSaleListModel

@end
