//
//  SRXOrderDetailsModel.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderDetailsModel.h"

@implementation SRXOrderDUser_info

@end

@implementation SRXOrderDGoods_infoItem

@end

@implementation SRXOrderDOrder_info

@end

@implementation SRXOrderDPay_info

@end

@implementation SRXOrderDetailsModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goods_info":@"SRXOrderDGoods_infoItem"};
}
@end

@implementation SRXOrderDReturn_info

@end

@implementation SRXOrderAfterSaleDetails

@end
