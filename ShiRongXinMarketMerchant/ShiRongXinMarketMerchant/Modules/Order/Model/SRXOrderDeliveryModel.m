//
//  SRXOrderDeliveryModel.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderDeliveryModel.h"

@implementation SRXExpressListModel
        
@end

@implementation SRXOrderDeliveryModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goods":@"SRXOrderGoodsItem"};
}

@end

@implementation SRXDeliveryDetailsTracesItem

@end

@implementation SRXDeliveryDetailsTraces

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"_signed" : @"signed"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"_signed":@"SRXDeliveryDetailsTracesItem",@"in_delivery":@"SRXDeliveryDetailsTracesItem",@"in_transit":@"SRXDeliveryDetailsTracesItem",@"contract":@"SRXDeliveryDetailsTracesItem"};
}
@end

@implementation SRXDeliveryDetailsData

@end
