//
//  NetworkManager+GoodUpdate.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager+GoodUpdate.h"

@implementation NetworkManager (GoodUpdate)

+ (void)addGoodsWithDic:(NSDictionary *)parameters
                success:(JHNetworkRequestSuccessVoid)success
                failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [[NetworkManager sharedClient] postWithURLString:@"shop/goods_add" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

/// 商品编辑保存处理
/// - Parameters:
///   - parameters: 请求参数
+ (void)saveGoodsEditInfoWithGoods_id:(NSString*)goods_id
                           parameters:(NSDictionary *)parameters
                         success:(JHNetworkRequestSuccessVoid)success
                         failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    mdic[@"goods_id"] = goods_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/goods_save" parameters:mdic.copy isNeedSVP:YES success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

+ (void)getGoodsFateInfoWithGoods_id:(NSString *)goods_id
                             success:(JHNetworkRequestSuccessArray)success
                             failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/fast_change_goods_spec_price_get" parameters:@{@"goods_id":goods_id} isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array =[SRXGoodsFastInfo mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

+ (void)changeGoodsFateInfoWithGoods_id:(NSString*)goods_id
                                   spec:(nullable NSArray *)spec
                             success:(JHNetworkRequestSuccessVoid)success
                                failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"goods_id"] = goods_id;
    mDic[@"spec"] = spec;
    [[NetworkManager sharedClient] postWithURLString:@"shop/fast_change_goods_spec_price" parameters:mDic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(@"修改成功");
    } failure:failure];
}

+ (void)changeGoodsStoreInfoWithGoods_id:(NSString*)goods_id
                                   spec:(nullable NSArray *)spec
                             success:(JHNetworkRequestSuccessVoid)success
                                 failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"goods_id"] = goods_id;
    mDic[@"spec"] = spec;
    [[NetworkManager sharedClient] postWithURLString:@"shop/fast_change_goods_spec_store_count" parameters:mDic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(@"修改成功");
    } failure:failure];
}

/// 商品编辑信息-商品详情
+ (void)getGoodsEditInfoWithGoods_id:(NSString*)goods_id
                             success:(void(^)(SRXGoodsEditInfoModel *info))success
                             failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/goodsInfo" parameters:@{@"goods_id":goods_id} isNeedSVP:NO success:^(NSDictionary *messageDic) {
        SRXGoodsEditInfoModel *info = [SRXGoodsEditInfoModel mj_objectWithKeyValues:messageDic[@"data"]];
        success(info);
    } failure:failure];
}
/// 平台商品分类
+ (void)getPlatformClassifyListWithSearch_word:(NSString *)search_word
                                  page:(NSInteger)page
                              pageSize:(NSInteger)pageSize
                               success:(JHNetworkRequestSuccessArray)success
                               failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"page"] = @(page);
    mdic[@"page_size"] = @(pageSize);
    mdic[@"search_word"] = search_word;
    [[NetworkManager sharedClient] getWithURLString:@"shop/plat_form_goods_category" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXShop_PlatClassifyItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}
/// 店铺商品分类
+ (void)getShopClassifyListWithSearch_word:(NSString *)search_word
                                  page:(NSInteger)page
                              pageSize:(NSInteger)pageSize
                               success:(JHNetworkRequestSuccessArray)success
                               failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"page"] = @(page);
    mdic[@"page_size"] = @(pageSize);
    mdic[@"search_word"] = search_word;
    [[NetworkManager sharedClient] getWithURLString:@"shop/shop_goods_category" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXShop_PlatClassifyItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}
/// 供应商列表
+ (void)getSupplierListSuccess:(JHNetworkRequestSuccessArray)success
                    failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_hupun_storage" parameters:nil isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXGoodsSupplierItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}
/// 获取运费模板
+ (void)getShippingTemplateListWithPage:(NSInteger)page
                              pageSize:(NSInteger)pageSize
                               success:(JHNetworkRequestSuccessArray)success
                                failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"page"] = @(page);
    mdic[@"page_size"] = @(pageSize);
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_shop_delivery_list" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXGoodsDeliveryItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

/// 规格数据
+ (void)getGoodsSpecListWithGoods_id:(NSString*)goods_id
                             success:(nonnull void (^)(SRXGoodsSpecListData * _Nonnull))success
                             failure:(nonnull JHNetworkRequestFailure)failure{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"goods_id"] = goods_id;
    [[NetworkManager sharedClient] getWithURLString:@"/shop/get_goods_spec" parameters:mDic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        SRXGoodsSpecListData *data = [SRXGoodsSpecListData mj_objectWithKeyValues:messageDic[@"data"]];
        success(data);
    } failure:failure];
}
/// 新增规格
+ (void)addGoodsSpecKeyWithGoods_id:(NSString *)goods_id
                          spec_name:(NSString *)spec_name
                             success:(JHNetworkRequestSuccessVoid)success
                             failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"goods_id"] = goods_id;
    mDic[@"spec_name"] = spec_name;
    [[NetworkManager sharedClient] postWithURLString:@"shop/add_spec_key" parameters:mDic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}
/// 新增规格值
+ (void)addGoodsSpecValueWithSpec_id:(NSString*)spec_key_id
                     spec_value_name:(NSString*)spec_value_name
                             success:(JHNetworkRequestSuccessVoid)success
                             failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"spec_key_id"] = spec_key_id;
    mDic[@"spec_value_name"] = spec_value_name;
    [[NetworkManager sharedClient] postWithURLString:@"shop/add_spec_value" parameters:mDic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

+ (void)saveGoodsSpecInfoWithGoods_id:(NSString *)goods_id
                           parameters:(NSDictionary *)parameters
                              success:(JHNetworkRequestSuccessVoid)success
                              failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    mdic[@"goods_id"] = goods_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/goods_spec_edit" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}
@end
