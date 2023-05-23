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
- (NSString *)type_cn {
    /**退款类型 0=仅退款,1=退货退款,2=换货,3=仅退商品费,4=仅退运费*/
    switch (self.type) {
        case 0:
            return @"仅退款";
            break;
        case 1:
            return @"退货退款";
            break;
        case 2:
            return @"换货";
            break;
        case 3:
            return @"仅退商品费";
            break;
        case 4:
            return @"仅退运费";
            break;
        default:
            return @"";
            break;
    }
}
@end
