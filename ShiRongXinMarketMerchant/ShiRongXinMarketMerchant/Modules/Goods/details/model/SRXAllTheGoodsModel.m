//
//  SRXAllTheGoodsModel.m
//  ShiRongXinMarketMallProject
//
//  Created by Alucardulad on 1/21/20.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXAllTheGoodsModel.h"

@implementation SRXThreeLevelModel

@end

@implementation SRXShopModel 
+(NSDictionary *)mj_objectClassInArray {
    return @{
        @"goods_categories":@"SRXThreeLevelModel",
        @"shop_goods":@"SRXAllTheGoodsModel"
    };
}
@end

@implementation GroupRecord_info

@end

@implementation AllTheGoodsComment

@end

@implementation Panic_buying_infoItem

@end

@implementation GoodsMpShareInfo

@end

@implementation SRXAllTheGoodsModel
+(NSDictionary *)mj_objectClassInArray {
    return @{
        @"spec":@"SRXSpecModel",
        @"spec_goods_price":@"SRXSpecGoodsPriceModel",
        @"panic_buying_info":@"Panic_buying_infoItem"
    };
}
@end
