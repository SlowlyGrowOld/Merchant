//
//  SRXAllTheGoodsModel.h
//  ShiRongXinMarketMallProject
//
//  Created by Alucardulad on 1/21/20.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXBaseModel.h"
#import "SRXSpecGoodsPriceModel.h"
#import "SRXSpecModel.h"
NS_ASSUME_NONNULL_BEGIN
@class SRXAllTheGoodsModel;

@interface SRXThreeLevelModel : SRXBaseModel

/** 三级商品分类ID */
@property (nonatomic,strong) NSString *_id;
/** 三级商品分类图标 */
@property (nonatomic,strong) NSString *icon;
/** 三级商品分类名称 */
@property (nonatomic,strong) NSString *name;
@end

@interface SRXShopModel : SRXBaseModel
@property (strong, nonatomic) NSString *_id;
@property (nonatomic,copy) NSString *customer_service_id;
@property (strong, nonatomic) NSString *shop_name;
@property (strong, nonatomic) NSString *shop_img;
@property (strong, nonatomic) NSArray <SRXAllTheGoodsModel *>*shop_goods;
/**详情页店铺背景*/
@property (strong, nonatomic) NSString *bg_img;
/** 在售商品数 */
@property (nonatomic,strong) NSString *goods_count;
/** 粉丝人数 */
@property (nonatomic,strong) NSString *collect_count;
/** 是否关注  允许值: true, false */
@property (nonatomic,assign) BOOL is_collect;
/** 是否自营 */
@property (nonatomic,assign) BOOL is_self;
/** 店铺商品分类列表 */
@property (nonatomic,strong) NSArray<SRXThreeLevelModel *> *goods_categories;

@end

@interface GroupRecord_info :SRXBaseModel
@property (nonatomic , assign) NSInteger              _id;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              current_people;
@property (nonatomic , assign) NSInteger              people_num;
@property (nonatomic , assign) NSInteger              expiration_time;
@property (nonatomic , strong) NSArray <NSString *>              *avatar;
/// 是否加入团
@property (nonatomic, assign) BOOL is_join;
/// 拼团类型
@property (nonatomic, assign) NSInteger type;

/// 商品详情页弹窗.
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * group_price;
@property (nonatomic , copy) NSString              * qr_code;

/// 新增倒计时
@property (nonatomic, assign) NSInteger countDown;

@end

@interface AllTheGoodsComment :NSObject
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , strong) NSArray <NSString *>              * images;

@end


@interface Panic_buying_infoItem :NSObject
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , assign) NSInteger              goods_num;

@end

@interface GoodsMpShareInfo :NSObject
@property (nonatomic , copy) NSString              * mp_share_url;
@property (nonatomic , copy) NSString              * mp_share_title;
@property (nonatomic , copy) NSString              * mp_share_image;

@end

@interface SRXAllTheGoodsModel : SRXBaseModel
@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *goods_name;
/** 库存 */
@property (nonatomic,strong) NSString *store_count;
/** 商品简介 */
@property (nonatomic,strong) NSString *goods_info;
@property (nonatomic,strong) NSString *source_type;
@property (nonatomic,strong) NSString *share_url;
@property (assign, nonatomic) NSInteger type;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *market_price;
@property (copy, nonatomic) NSString * member_price;
@property (strong, nonatomic) NSString *coupon_money;
@property (strong, nonatomic) NSString *price;
/**券后价，空就是没有*/
@property (assign, nonatomic) CGFloat   after_coupon_price;
/**新增返现金额*/
@property (assign, nonatomic) double   cash_back_money;
@property (strong, nonatomic) NSString *goods_content;
@property (strong, nonatomic) NSArray <NSString *> *label;
// 新增内容高度
@property (nonatomic, assign) CGFloat goods_contentHeight;
@property (strong, nonatomic) NSString *sales_sum;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSString *video;
@property (strong, nonatomic) NSString *specs;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSArray <SRXSpecModel *> *spec; // 条件
@property (strong, nonatomic) NSArray <SRXSpecGoodsPriceModel *> *spec_goods_price; //符合条件的库存和价格等
@property (strong, nonatomic) NSDictionary *comment;
@property (strong, nonatomic) SRXShopModel *shop;
/** 产品参数 */
@property (nonatomic,strong) NSArray *basic_info;
@property (copy, nonatomic) NSString * package_price;
/** 为套餐商品时是否能够修改购买数量 */
@property(nonatomic, assign) BOOL  is_package_edit_num;

/** 小程序分享地址 */
@property (nonatomic, strong) GoodsMpShareInfo *mp_share_info;

/** 商品规格ID */
@property (nonatomic,strong) SRXSpecGoodsPriceModel *selectSpec;//选好的规格ID
/** 商品数量 */
@property (nonatomic,strong) NSString *goods_num;//选择的数量
/** general=普通商品，group=拼团商品 */
@property (nonatomic,strong) NSString *goods_type;
/** 团购商品-秒杀||团购 */
@property (nonatomic,strong) NSString *type_name;

/**
 视频数组
 */
@property (nonatomic, strong) NSArray *videos;

@property ( assign) BOOL is_collect;
@property ( assign) BOOL is_member;
@property ( assign) BOOL is_enable_grade;
@property ( assign) BOOL is_special_goods;
@property (strong, nonatomic) NSDictionary *discount_info;
/** 详情数据 */
@property (nonatomic,strong) NSAttributedString *goodsDetailStr;
/** 详情高度 */
@property(nonatomic, assign) CGFloat detailHeight;

// 拼团相关的数据
@property (nonatomic , assign) NSInteger              goods_id;

// 自己添加的
@property (nonatomic , assign) NSInteger              activity_id;

@property (nonatomic , assign) NSInteger              head_exchange_integral;
@property (nonatomic , copy) NSString              * group_price;
// 团长价格
@property (nonatomic, copy) NSString *head_price;

@property (nonatomic , assign) NSInteger              exchange_integral;
@property (nonatomic , assign) NSInteger              people_num;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , assign) NSInteger              end_time;
@property (nonatomic , assign) NSInteger              start_time;
@property (nonatomic , assign) BOOL                   is_start;
/// 开始倒计时时间
@property (nonatomic, assign) NSInteger               startCountDown;
@property (nonatomic , assign) NSInteger              former_stock_num;
@property (nonatomic , assign) NSInteger              stock_num;
@property (nonatomic , copy) NSString              * keywords;
@property (nonatomic , assign) NSInteger              is_vip;
@property (nonatomic , assign) NSInteger              shop_id;
@property (nonatomic , assign) NSInteger              is_multiple;
@property (nonatomic , assign) NSInteger              join_number;

@property (nonatomic , assign) NSInteger              countDown;
@property (nonatomic , assign) NSInteger              countDown2;
@property (nonatomic , strong) NSArray <Panic_buying_infoItem *>              * panic_buying_info;
/// 记录信息
@property (nonatomic, strong) GroupRecord_info *record_info;
/// 参数规格
@property (nonatomic, copy) NSString *parameter_explain;
/// 发货说明
@property (nonatomic, copy) NSString *shipments_explain;
/// 团长提示
@property (nonatomic, copy) NSString *hint;
/// 团长提示
@property (nonatomic, copy) NSString *intro;

@property (nonatomic , assign) NSInteger              join_status;
/// 限制购买个数
@property (nonatomic, assign) NSInteger limit_number;
// 太阳码
@property (nonatomic, copy) NSString *qr_code;

- (id)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
