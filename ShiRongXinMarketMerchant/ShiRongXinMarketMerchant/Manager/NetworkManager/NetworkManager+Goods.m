//
//  NetworkManager+Goods.m
//  ShiRongXinMarketMerchant
//
//  Created by wyb on 2023/5/15.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager+Goods.h"

@implementation NetworkManager (Goods)
+ (void)getGoodsListWithDic:(NSDictionary *)parameters
               goods_status:(NSString *)goods_status
                search_word:(NSString *)search_word
                       page:(NSInteger)page
                   pageSize:(NSInteger)pageSize
                success:(JHNetworkRequestSuccessArray)success
                    failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    mdic[@"page"] = @(page);
    mdic[@"page_size"] = @(pageSize);
    mdic[@"goods_status"] = goods_status;
    mdic[@"search_word"] = search_word;
    [[NetworkManager sharedClient] getWithURLString:@"shop/goods_list" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXGoodsListModel mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

+ (void)getGoodsListNumSuccess:(void (^)(SRXGoodsListNumber * _Nonnull))success
                       failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/goods_list_num" parameters:nil isNeedSVP:NO success:^(NSDictionary *messageDic) {
        
        SRXGoodsListNumber *number = [SRXGoodsListNumber mj_objectWithKeyValues:messageDic[@"data"]];
        success(number);
    } failure:failure];
}

+ (void)batchGoodsTakeOffWithIDS:(NSString *)good_id
                         success:(JHNetworkRequestSuccessVoid)success
                         failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] postWithURLString:@"shop/goods_take_off_batch" parameters:@{@"goods_id":good_id} isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"msg"]);
    } failure:failure];
}

/// 商品列表-上架
+ (void)shelfGoodsWithGoods_id:(NSString*)goods_id
                             success:(JHNetworkRequestSuccessVoid)success
                       failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/goods_shelf" parameters:@{@"goods_id":goods_id} isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"msg"]);
    } failure:failure];
}
/// 商品列表-提交审核
+ (void)reviewGoodsWithGoods_id:(NSString*)goods_id
                  is_audit_show:(NSString *)is_audit_show
                             success:(JHNetworkRequestSuccessVoid)success
                             failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"goods_id"] = goods_id;
    mdic[@"is_audit_show"] = is_audit_show;
    [[NetworkManager sharedClient] getWithURLString:@"shop/goods_sub_review" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"msg"]);
    } failure:failure];
}

@end
