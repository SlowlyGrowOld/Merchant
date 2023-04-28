//
//  SRXOrderDeliveryModel.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderDeliveryModel.h"

@implementation SRXOrderDeliveryModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goods":@"SRXOrderGoodsItem"};
}

@end

@implementation SRXDeliveryDetailsTracesItem

@end

@implementation SRXDeliveryDetailsTraces
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"traces":@"SRXDeliveryDetailsTracesItem"};
}
@end
