//
//  NetworkManager+GoodUpdate.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager.h"
#import "SRXGoodsEditInfoModel.h"
#import "SRXGoodsSpecModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager (GoodUpdate)

/// 商品添加
/// - Parameters:
///   - parameters: 请求参数
+ (void)addGoodsWithDic:(NSDictionary *)parameters
                success:(JHNetworkRequestSuccessVoid)success
                failure:(JHNetworkRequestFailure)failure;
/// 商品编辑保存处理
/// - Parameters:
///   - parameters: 请求参数
+ (void)saveGoodsEditInfoWithGoods_id:(NSString*)goods_id
                           parameters:(NSDictionary *)parameters
                         success:(JHNetworkRequestSuccessVoid)success
                         failure:(JHNetworkRequestFailure)failure;

/// 快捷变更规格参数-改价格-改库存 获取规格的销售价，积分抵扣，库存
/// - Parameters:
///   - goods_id: 商品id
+ (void)getGoodsFateInfoWithGoods_id:(NSString*)goods_id
                             success:(JHNetworkRequestSuccessArray)success
                             failure:(JHNetworkRequestFailure)failure;

/// 快捷变更规格参数-改价格和积分
/// - Parameters:
///   - goods_id: 商品id
///   - spec: 规格参数
+ (void)changeGoodsFateInfoWithGoods_id:(NSString*)goods_id
                                   spec:(nullable NSArray *)spec
                             success:(JHNetworkRequestSuccessVoid)success
                             failure:(JHNetworkRequestFailure)failure;
/// 快捷修改库存
/// - Parameters:
///   - goods_id: 商品id
///   - spec: 规格参数
+ (void)changeGoodsStoreInfoWithGoods_id:(NSString*)goods_id
                                   spec:(nullable NSArray *)spec
                             success:(JHNetworkRequestSuccessVoid)success
                             failure:(JHNetworkRequestFailure)failure;

/// 商品编辑信息-商品详情
+ (void)getGoodsEditInfoWithGoods_id:(NSString*)goods_id
                             success:(void(^)(SRXGoodsEditInfoModel *info))success
                             failure:(JHNetworkRequestFailure)failure;

/// 平台商品分类
+ (void)getPlatformClassifyListWithSearch_word:(NSString *)search_word
                                  page:(NSInteger)page
                              pageSize:(NSInteger)pageSize
                               success:(JHNetworkRequestSuccessArray)success
                               failure:(JHNetworkRequestFailure)failure;
/// 店铺商品分类
+ (void)getShopClassifyListWithSearch_word:(NSString *)search_word
                                  page:(NSInteger)page
                              pageSize:(NSInteger)pageSize
                               success:(JHNetworkRequestSuccessArray)success
                               failure:(JHNetworkRequestFailure)failure;
/// 供应商列表
+ (void)getSupplierListSuccess:(JHNetworkRequestSuccessArray)success
                    failure:(JHNetworkRequestFailure)failure;
/// 获取运费模板
+ (void)getShippingTemplateListWithPage:(NSInteger)page
                              pageSize:(NSInteger)pageSize
                               success:(JHNetworkRequestSuccessArray)success
                               failure:(JHNetworkRequestFailure)failure;

/// 获取规格数据
+ (void)getGoodsSpecListWithGoods_id:(NSString*)goods_id
                             success:(void(^)(SRXGoodsSpecListData *data))success
                             failure:(JHNetworkRequestFailure)failure;
/// 新增规格名
+ (void)addGoodsSpecKeyWithGoods_id:(NSString*)goods_id
                          spec_name:(NSString*)spec_name
                             success:(JHNetworkRequestSuccessVoid)success
                             failure:(JHNetworkRequestFailure)failure;
/// 新增规格值
+ (void)addGoodsSpecValueWithSpec_id:(NSString*)spec_key_id
                     spec_value_name:(NSString*)spec_value_name
                             success:(JHNetworkRequestSuccessVoid)success
                             failure:(JHNetworkRequestFailure)failure;
/// 保存规格数据
+ (void)saveGoodsSpecInfoWithGoods_id:(NSString*)goods_id
                       parameters:(NSDictionary *)parameters
                             success:(JHNetworkRequestSuccessVoid)success
                             failure:(JHNetworkRequestFailure)failure;
@end

NS_ASSUME_NONNULL_END
