//
//  NetworkManager+Goods.h
//  ShiRongXinMarketMerchant
//
//  Created by wyb on 2023/5/15.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager.h"
#import "SRXGoodsListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager (Goods)

/// 商品列表
/// - Parameters:
///   - parameters: 请求参数
+ (void)getGoodsListWithDic:(NSDictionary *)parameters
               goods_status:(NSString *)goods_status
                search_word:(NSString *)search_word
                       page:(NSInteger)page
                   pageSize:(NSInteger)pageSize
                success:(JHNetworkRequestSuccessArray)success
                  failure:(JHNetworkRequestFailure)failure;

/// 商品列表数量
+ (void)getGoodsListNumSuccess:(JHNetworkRequestSuccessContent)success
                       failure:(JHNetworkRequestFailure)failure;

/// 批量下架
/// - Parameters:
///   - good_id: 多个用逗号隔开
+ (void)batchGoodsTakeOffWithIDS:(NSString *)good_id
                         success:(JHNetworkRequestSuccessVoid)success
                       failure:(JHNetworkRequestFailure)failure;

/// 商品列表-上架
+ (void)shelfGoodsWithGoods_id:(NSString*)goods_id
                             success:(JHNetworkRequestSuccessVoid)success
                             failure:(JHNetworkRequestFailure)failure;
/// 商品列表-提交审核
+ (void)reviewGoodsWithGoods_id:(NSString*)goods_id
                             success:(JHNetworkRequestSuccessVoid)success
                             failure:(JHNetworkRequestFailure)failure;

@end

NS_ASSUME_NONNULL_END
