//
//  SRXGoodsListModel.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXGoodsListParameter : NSObject
/**筛选-开始时间*/
@property (nonatomic , copy , nullable) NSString              * start_time;
/**筛选-结束时间*/
@property (nonatomic , copy , nullable) NSString              * end_time;
/**店铺商品分类id*/
@property (nonatomic , copy , nullable) NSString              * extend_cat_id;
/**价格区间-最低价*/
@property (nonatomic , copy , nullable) NSString              * price_low;
/**价格区间-最高价*/
@property (nonatomic , copy , nullable) NSString              * price_high;
/**库存区间-低*/
@property (nonatomic , copy , nullable) NSString              * store_count_low;
/**库存区间-高*/
@property (nonatomic , copy , nullable) NSString              * store_count_high;
/**销量区间-低*/
@property (nonatomic , copy , nullable) NSString              * sale_num_low;
/**销量区间-高*/
@property (nonatomic , copy , nullable) NSString              * sale_num_high;
/**分润区间-低*/
@property (nonatomic , copy , nullable) NSString              * profit_low;
/**分润区间-高*/
@property (nonatomic , copy , nullable) NSString              * profit_high;
/**搜索词*/
@property (nonatomic , copy , nullable) NSString              * search_word;
@end

@interface SRXGoodsListModel : NSObject
@property (nonatomic , copy) NSString              * goods_id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              sales_sum;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , assign) NSInteger              is_show;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , assign) NSInteger              store_count;

@property (nonatomic , assign) BOOL              is_select;
@end


@interface SRXGoodsListNumber : NSObject
@property (nonatomic , assign) NSUInteger              sale_count_num;
@property (nonatomic , assign) NSUInteger              edit_count_num;
@property (nonatomic , assign) NSUInteger              audit_count_num;
@property (nonatomic , assign) NSUInteger              off_count_num;
@end

NS_ASSUME_NONNULL_END
