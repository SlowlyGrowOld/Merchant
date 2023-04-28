//
//  NetworkManager+Order.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager.h"
#import "SRXOrderListModel.h"
#import "SRXOrderDetailsModel.h"
#import "SRXOrderDeliveryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager (Order)

/// 订单中心-订单列表【不包含售后管理】
/// - Parameters:
///   - search_word: 关键字
///   - order_type: 1=待发货 2=待付款 3=待收货 4=已完成
+ (void)getOrderListWithSearchWord:(NSString *)search_word
                        order_type:(NSString *)order_type
                              page:(NSInteger)page
                         page_size:(NSInteger)page_size
                success:(JHNetworkRequestSuccessArray)success
                  failure:(JHNetworkRequestFailure)failure;
/// 订单中心-订单列表-售后管理
/// - Parameters:
///   - search_word: 关键字
+ (void)getOrderAfterSaleListWithSearchWord:(NSString *)search_word
                              page:(NSInteger)page
                         page_size:(NSInteger)page_size
                success:(JHNetworkRequestSuccessArray)success
                  failure:(JHNetworkRequestFailure)failure;

/// 订单备注
/// - Parameters:
///   - order_id: 订单id
///   - admin_note: 备注内容
+ (void)addOrderRemarkWithOrderID:(NSString *)order_id
                       admin_note:(NSString *)admin_note
                success:(JHNetworkRequestSuccessVoid)success
                  failure:(JHNetworkRequestFailure)failure;

/// 订单详情
/// - Parameters:
///   - order_id: 订单id
+ (void)getOrderDetailsWithOrderID:(NSString *)order_id
                           success:(void (^)(SRXOrderDetailsModel *model))success
                           failure:(JHNetworkRequestFailure)failure;

/// 查看物流-包裹列表
/// - Parameters:
///   - order_id: 订单id
+ (void)getOrderGoodsDeliveryListWithOrderID:(NSString *)order_id
                                     success:(JHNetworkRequestSuccessArray)success
                                     failure:(JHNetworkRequestFailure)failure;


/// 物流详情
/// - Parameters:
///   - order_id: 订单id
///   - express_sn: 订单号
///   - order_type: 默认1。1=普通订单，2=售后订单
///   - order_return_id: 售后订单id
+ (void)getOrderGoodsDeliveryDetailsWithOrderID:(NSString *)order_id
                                     express_sn:(NSString *)express_sn
                                     order_type:(NSString *)order_type
                                order_return_id:(NSString *)order_return_id
                                     success:(void(^)(SRXDeliveryDetailsTraces *details))success
                                     failure:(JHNetworkRequestFailure)failure;


/// 售后详情
/// - Parameters:
///   - order_return_id: 售后订单id
+ (void)getOrderAfterSaleDetailsWithID:(NSString *)order_return_id
                success:(void(^)(SRXOrderAfterSaleDetails *details))success
                  failure:(JHNetworkRequestFailure)failure;


/// 售后详情-同意申请-拒绝申请
/// - Parameters:
///   - order_return_id: 售后id
///   - operate_type: 1=同意，2=拒绝
///   - refuse_msg: operate_type=2时必填，拒绝理由
+ (void)setOrderAfterSaleStatusWithID:(NSString *)order_return_id
                         operate_type:(NSString *)operate_type
                           refuse_msg:(NSString *)refuse_msg
                success:(JHNetworkRequestSuccessVoid)success
                  failure:(JHNetworkRequestFailure)failure;
@end

NS_ASSUME_NONNULL_END
