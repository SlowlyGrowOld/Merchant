//
//  NetworkManager+Order.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager+Order.h"

@implementation NetworkManager (Order)
+ (void)getOrderListWithSearchWord:(NSString *)search_word
                        order_type:(NSString *)order_type
                              page:(NSInteger)page
                         page_size:(NSInteger)page_size
                success:(JHNetworkRequestSuccessArray)success
                           failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"search_word"] = search_word;
    dic[@"order_type"] = order_type;
    dic[@"shop_id"] = [UserManager sharedUserManager].curUserInfo.shop_id;
    dic[@"page"] = @(page);
    dic[@"page_size"] = @(page_size);
    [[NetworkManager sharedClient] getWithURLString:@"shop/order_center" parameters:dic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXOrderListModel mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

+ (void)getOrderAfterSaleListWithSearchWord:(NSString *)search_word
                              page:(NSInteger)page
                         page_size:(NSInteger)page_size
                success:(JHNetworkRequestSuccessArray)success
                                    failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"search_word"] = search_word;
    dic[@"shop_id"] = [UserManager sharedUserManager].curUserInfo.shop_id;
    dic[@"page"] = @(page);
    dic[@"page_size"] = @(page_size);
    [[NetworkManager sharedClient] getWithURLString:@"shop/order_center_after_sale" parameters:dic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXOrderAfterSaleListModel mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

+ (void)addOrderRemarkWithOrderID:(NSString *)order_id
                       admin_note:(NSString *)admin_note
                success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"order_id"] = order_id;
    dic[@"admin_note"] = admin_note;
    [[NetworkManager sharedClient] postWithURLString:@"shop/order_remark" parameters:dic.copy isNeedSVP:YES success:^(NSDictionary *messageDic) {
        success(@"保存成功");
    } failure:failure];
}

+ (void)getOrderDetailsWithOrderID:(NSString *)order_id
                           shop_id:(NSString *)shop_id
                           success:(nonnull void (^)(SRXOrderDetailsModel * _Nonnull))success
                           failure:(nonnull JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"order_id"] = order_id;
    dic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/order_details" parameters:dic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        SRXOrderDetailsModel *model = [SRXOrderDetailsModel mj_objectWithKeyValues:messageDic[@"data"]];
        success(model);
    } failure:failure];
}

+ (void)getOrderGoodsDeliveryListWithOrderID:(NSString *)order_id
                                     shop_id:(NSString *)shop_id
                                     success:(JHNetworkRequestSuccessArray)success
                                     failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"order_id"] = order_id;
    dic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/delivery_goods" parameters:dic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXOrderDeliveryModel mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

+ (void)getOrderGoodsDeliveryDetailsWithOrderID:(NSString *)order_id
                                        shop_id:(NSString *)shop_id
                                     express_sn:(NSString *)express_sn
                                     order_type:(NSString *)order_type
                                order_return_id:(NSString *)order_return_id
                                     success:(nonnull void (^)(SRXDeliveryDetailsData * _Nonnull))success
                                        failure:(nonnull JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"order_id"] = order_id;
    dic[@"express_sn"] = express_sn;
    dic[@"order_type"] = order_type;
    dic[@"order_return_id"] = order_return_id;
    dic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/logistics_details" parameters:dic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        SRXDeliveryDetailsData *details = [SRXDeliveryDetailsData mj_objectWithKeyValues:messageDic[@"data"]];
        success(details);
    } failure:failure];
}

+ (void)getOrderAfterSaleDetailsWithID:(NSString *)order_return_id
                success:(nonnull void (^)(SRXOrderAfterSaleDetails * _Nonnull))success
                               failure:(nonnull JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/after_sale_details" parameters:@{@"order_return_id":order_return_id} isNeedSVP:NO success:^(NSDictionary *messageDic) {
        SRXOrderAfterSaleDetails *details = [SRXOrderAfterSaleDetails mj_objectWithKeyValues:messageDic[@"data"]];
        success(details);
    } failure:failure];
}

+ (void)setOrderAfterSaleStatusWithID:(NSString *)order_return_id
                         operate_type:(NSString *)operate_type
                           refuse_msg:(NSString *)refuse_msg
                success:(JHNetworkRequestSuccessVoid)success
                              failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"order_return_id"] = order_return_id;
    dic[@"operate_type"] = operate_type;
    dic[@"refuse_msg"] = refuse_msg;
    [[NetworkManager sharedClient] getWithURLString:@"shop/after_sale_apply_for" parameters:dic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(@"请求成功");
    } failure:failure];
}

+ (void)sureOrderAfterSaleRefundWithID:(NSString *)order_return_id
                success:(JHNetworkRequestSuccessVoid)success
                               failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"order_return_id"] = order_return_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/after_sale_refund" parameters:dic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(@"请求成功");
    } failure:failure];
}


+ (void)sendGoodsBySelfLiftingWithID:(NSString *)order_id
                             shop_id:(NSString *)shop_id
                             success:(JHNetworkRequestSuccessVoid)success
                             failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"order_id"] = order_id;
    dic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/order_delivery_self_lifting" parameters:dic.copy isNeedSVP:YES success:^(NSDictionary *messageDic) {
        success(@"请求成功");
    } failure:^(NSString *error) {
        
    }];
}

+ (void)get_express_listWithShop_id:(NSString *)shop_id
                            success:(JHNetworkRequestSuccessArray)success
                         failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_express_list" parameters:dic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXExpressListModel mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

+ (void)sendOrderGoodsWithOrderID:(NSString *)order_id
                          shop_id:(NSString *)shop_id
                       express_sn:(NSString *)express_sn
                       express_id:(NSString *)express_id
                             success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"order_id"] = order_id;
    dic[@"express_sn"] = express_sn;
    dic[@"express_id"] = express_id;
    dic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/order_delivery_by_order" parameters:dic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"msg"]);
    } failure:failure];
}

+ (void)sendOrderGoodsWithGoodsID:(NSString *)order_goods_id
                          shop_id:(NSString *)shop_id
                         order_id:(NSString *)order_id
                       express_sn:(NSString *)express_sn
                       express_id:(NSString *)express_id
                             success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"order_goods_id"] = order_goods_id;
    dic[@"order_id"] = order_id;
    dic[@"express_sn"] = express_sn;
    dic[@"express_id"] = express_id;
    dic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/order_delivery_by_package" parameters:dic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"msg"]);
    } failure:failure];
}

/// 按商品包裹发货 - 获取商品
/// @param order_id 订单id
+ (void)getOrderDeliveryGoodsWithOrder_id:(NSString *)order_id
                                  shop_id:(NSString *)shop_id
                             success:(JHNetworkRequestSuccessArray)success
                                  failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"order_id"] = order_id;
    dic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_order_delivery_goods" parameters:dic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXOrderGoodsItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}
@end
