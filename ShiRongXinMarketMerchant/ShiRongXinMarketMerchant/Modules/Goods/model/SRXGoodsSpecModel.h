//
//  SRXGoodsSpecModel.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/26.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//批量操作时判断
@interface SRXGoodsSpecFormBatch :NSObject
@property (nonatomic , assign) BOOL              is_market_price;
@property (nonatomic , assign) BOOL              is_price;
@property (nonatomic , assign) BOOL              is_package_price;
@property (nonatomic , assign) BOOL              is_store_count;
@property (nonatomic , assign) BOOL              is_weight;
@property (nonatomic , assign) BOOL              is_spec_img;
@property (nonatomic , assign) BOOL              is_score;
@property (nonatomic , assign) BOOL              is_profit;
/**批量操作的值*/
@property (nonatomic , copy) NSString              *value;

@end

@interface SRXGoodsSpecItemsItem :NSObject
@property (nonatomic , copy) NSString              * item_id;
@property (nonatomic , copy) NSString              * spec_value;

@property (nonatomic , assign) BOOL              is_select;
@end


@interface SRXGoodsSpecAttrItem :NSObject
@property (nonatomic , copy) NSString              * group_id;
@property (nonatomic , copy) NSString              * group_name;
@property (nonatomic , strong) NSArray <SRXGoodsSpecItemsItem *>              * spec_items;
@end


@interface SRXGoodsSpecForm :NSObject
@property (nonatomic , copy) NSString              * goods_sn;
@property (nonatomic , copy) NSString              * market_price;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * package_price;
@property (nonatomic , copy) NSString              * store_count;
@property (nonatomic , copy) NSString              * weight;
@property (nonatomic , copy) NSString              * spec_img;
@property (nonatomic , copy) NSString              * score;
@property (nonatomic , copy) NSString              * score_limit;
@property (nonatomic , copy) NSString              * profit;

@end


@interface SRXGoodsSpecListItem :NSObject
@property (nonatomic , assign) NSInteger              goods_spec_id;
@property (nonatomic , copy) NSString              * spec_sku_id;
@property (nonatomic , copy) NSString              * spec_key_name;
@property (nonatomic , strong) SRXGoodsSpecForm              * form;

@end


@interface SRXGoodsSpecListData :NSObject
@property (nonatomic , strong) NSArray <SRXGoodsSpecAttrItem *>              * spec_attr;
@property (nonatomic , strong) NSArray <SRXGoodsSpecListItem *>              * spec_list;

@end

@interface SRXGoodsSpecModel : NSObject

@end

NS_ASSUME_NONNULL_END
