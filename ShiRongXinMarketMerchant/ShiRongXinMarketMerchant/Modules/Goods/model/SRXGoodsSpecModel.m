//
//  SRXGoodsSpecModel.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/26.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsSpecModel.h"

@implementation SRXGoodsSpecFormBatch

@end

@implementation SRXGoodsSpecItemsItem

@end

@implementation SRXGoodsSpecAttrItem
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"spec_items":@"SRXGoodsSpecItemsItem"};
}
@end

@implementation SRXGoodsSpecForm

@end

@implementation SRXGoodsSpecListItem

@end

@implementation SRXGoodsSpecListData
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"spec_list":@"SRXGoodsSpecListItem",@"spec_attr":@"SRXGoodsSpecAttrItem"};
}

@end

@implementation SRXGoodsSpecModel

@end
