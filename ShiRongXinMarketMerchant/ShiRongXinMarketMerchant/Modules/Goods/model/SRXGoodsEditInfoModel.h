//
//  SRXGoodsUpdateModel.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXGoodsDeliveryItem :NSObject
@property (nonatomic , copy) NSString              * delivery_id;
@property (nonatomic , copy) NSString              * name;
@end

@interface SRXGoodsSupplierItem :NSObject
@property (nonatomic , copy) NSString              * storage_code;
@property (nonatomic , copy) NSString              * storage_name;
@end

@interface SRXShop_PlatClassifyItem :SRXBaseModel
@property (nonatomic , copy) NSString              * _id;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * shop_id;
@property (nonatomic , assign) BOOL              isSelect;
@end

@interface SRXGoodsFastInfo : NSObject
@property (nonatomic , copy) NSString              * spec_id;
@property (nonatomic , copy) NSString              * key_name;
@property (nonatomic , assign) CGFloat               price;
@property (nonatomic , copy) NSString              * score;
@property (nonatomic , copy) NSString              * store_count;
@end

@interface SRXGoodsBasicInfoItem :NSObject
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * desc;

@end

@interface SRXGoodsEditInfoModel : SRXBaseModel
@property (nonatomic , copy) NSString              * _id;
@property (nonatomic , copy) NSString              * cat_id;
@property (nonatomic , copy) NSString              * cat_name;
@property (nonatomic , copy) NSString              * extend_cat_id;
@property (nonatomic , copy) NSString              * extend_cat_name;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * hupun_storage_id;
@property (nonatomic , copy) NSString              * hupun_storage_name;
@property (nonatomic , copy) NSString              * keywords;
@property (nonatomic , copy) NSString              * goods_info;
@property (nonatomic , copy) NSString              * goods_sn;
@property (nonatomic , strong) NSArray <SRXGoodsBasicInfoItem *>              * basic_info;
@property (nonatomic , assign) CGFloat               market_price;
@property (nonatomic , assign) CGFloat               weight;
@property (nonatomic , assign) NSInteger              refund_deadline;
@property (nonatomic , assign) NSInteger              is_free_shipping;
@property (nonatomic , copy) NSString              * delivery_id;
@property (nonatomic , copy) NSString              * delivery_name;
@property (nonatomic , assign) NSInteger              evaluate_integral;
@property (nonatomic , assign) NSInteger              is_recommend;
@property (nonatomic , assign) NSInteger              is_new;
@property (nonatomic , assign) NSInteger              is_hot;
@property (nonatomic , assign) NSInteger              weigh;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , strong) NSArray <NSString *>              * images;
@property (nonatomic , copy) NSString              * gif_image;
@property (nonatomic , copy) NSString              * video;
@property (nonatomic , strong) NSArray <NSString *>              * videos;
@property (nonatomic , strong) NSArray <NSString *>              * goods_content;
@end

NS_ASSUME_NONNULL_END
