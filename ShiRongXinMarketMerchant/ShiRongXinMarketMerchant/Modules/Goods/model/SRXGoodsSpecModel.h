//
//  SRXGoodsSpecModel.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/26.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXGoodsSpecItemsItem :NSObject
@property (nonatomic , assign) NSInteger              item_id;
@property (nonatomic , copy) NSString              * spec_value;

@property (nonatomic , assign) BOOL              is_select;
@end


@interface SRXGoodsSpecAttrItem :NSObject
@property (nonatomic , copy) NSString              * group_id;
@property (nonatomic , copy) NSString              * group_name;
@property (nonatomic , strong) NSArray <SRXGoodsSpecItemsItem *>              * spec_items;

@property (nonatomic , assign) CGFloat              contentSizeHeight;
@end


@interface SRXGoodsSpecForm :NSObject
@property (nonatomic , copy) NSString              * goods_sn;
@property (nonatomic , assign) CGFloat               market_price;
@property (nonatomic , assign) CGFloat               price;
@property (nonatomic , assign) CGFloat               package_price;
@property (nonatomic , assign) NSInteger              store_count;
@property (nonatomic , assign) CGFloat               weight;
@property (nonatomic , copy) NSString              * spec_img;
@property (nonatomic , assign) NSInteger              score;
@property (nonatomic , copy) NSString              * score_limit;
@property (nonatomic , assign) CGFloat               profit;

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
