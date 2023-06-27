//
//  NetworkManager+Message.m
//  ShiRongXinMarketMerchant
//
//  Created by wyb on 2023/5/15.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager+Message.h"

@implementation NetworkManager (Message)
/// 消息中心 - 接待列表，标记列表
+ (void)getChatListWithSearch_word:(NSString *)search_word
                 chat_type:(NSString *)chat_type
                   shop_id:(NSString *)shop_id
                       page:(NSInteger)page
                   pageSize:(NSInteger)pageSize
                success:(JHNetworkRequestSuccessArray)success
                  failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"page"] = @(page);
    mdic[@"page_size"] = @(pageSize);
    mdic[@"search_word"] = search_word;
    mdic[@"chat_type"] = chat_type;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/chat_list_receive" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXMessageListModel mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

/// 消息中心-获取管理店铺的未读数量
+ (void)getChatShopNumWithSuccess:(JHNetworkRequestSuccessArray)success
                          failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/chat_shop_num" parameters:nil isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXChatShopNumItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}
/// 消息中心-对话设置-移除对话
+ (void)removeChatUserWithUser_id:(NSString *)user_id
                          shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"user_id"] = user_id;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/chat_list_remove" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

/// 对话设置-设置备注
+ (void)setChatRemarkWithUser_id:(NSString *)user_id
                          shop_id:(NSString *)shop_id
                     remark_name:(NSString *)remark_name
                          success:(JHNetworkRequestSuccessVoid)success
                         failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"user_id"] = user_id;
    mdic[@"shop_id"] = shop_id;
    mdic[@"remark_name"] = remark_name;
    [[NetworkManager sharedClient] getWithURLString:@"shop/chat_set_remarks" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

/// 推荐商品列表
+ (void)getRecommentChatGoodsWithSearch_word:(NSString *)search_word
                                     shop_id:(NSString *)shop_id
                                        page:(NSInteger)page
                                    pageSize:(NSInteger)pageSize
                                     success:(JHNetworkRequestSuccessArray)success
                                     failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"page"] = @(page);
    mdic[@"page_size"] = @(pageSize);
    mdic[@"search_word"] = search_word;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/chat_recomment_goods" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXMsgGoodsInfoItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

/// 订单核对列表
+ (void)getChatOrderListWithUser_id:(NSString *)user_id
                        shop_id:(NSString *)shop_id
                               page:(NSInteger)page
                           pageSize:(NSInteger)pageSize
                        success:(JHNetworkRequestSuccessArray)success
                            failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"page"] = @(page);
    mdic[@"page_size"] = @(pageSize);
    mdic[@"user_id"] = user_id;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/chat_order_list" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXOrderListModel mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

/// 优惠券列表
+ (void)getChatCouponListWithSearch:(NSString *)search_word
                        shop_id:(NSString *)shop_id
                               page:(NSInteger)page
                           pageSize:(NSInteger)pageSize
                        success:(JHNetworkRequestSuccessArray)success
                            failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"page"] = @(page);
    mdic[@"page_size"] = @(pageSize);
    mdic[@"search_word"] = search_word;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/chat_coupon_list" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXMsgChatCoupnItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

/// 对话窗口-获取快捷回复列表
+ (void)getQuickReplyWithShop_id:(NSString *)shop_id
                    success:(JHNetworkRequestSuccessArray)success
                         failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_quick_reply" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXMsgReplysItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

/// wss连接成功绑定用户id和client_id
+ (void)bindWSSWithClient_id:(NSString *)client_id
                         uid:(NSString *)uid
                    success:(JHNetworkRequestSuccessVoid)success
                     failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"client_id"] = client_id;
    mdic[@"uid"] = uid;
    [[NetworkManager sharedClient] postWithURLString:@"shop/shop_bind_by_shop_userid" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

+ (void)getChatContentWithUser_id:(NSString *)user_id
                          shop_id:(NSString *)shop_id
                             page:(NSUInteger)page
                         pageSize:(NSUInteger)pageSize
                    success:(JHNetworkRequestSuccessArray)success
                          failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"page"] = @(page);
    mdic[@"page_size"] = @(pageSize);
    mdic[@"user_id"] = user_id;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_chat_content" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXMsgChatModel mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

+ (void)getChatOtherWithUser_id:(NSString *)user_id
                        shop_id:(NSString *)shop_id
                    success:(void(^)(SRXMsgChatOther *other))success
                        failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/chat_content_other" parameters:@{@"user_id":user_id,@"shop_id":shop_id} isNeedSVP:NO success:^(NSDictionary *messageDic) {
        SRXMsgChatOther *other = [SRXMsgChatOther mj_objectWithKeyValues:messageDic[@"data"]];
        success(other);
    } failure:failure];
}

+ (void)getChatTransferListWithSuccess:(JHNetworkRequestSuccessArray)success
                               failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_chat_shop_transfer" parameters:nil isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXMsgChatServiceItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}
/// 转接按钮事件
+ (void)transferChatServiceWithUser_id:(NSString *)user_id
                          shop_user_id:(NSString *)shop_user_id
                               shop_id:(NSString *)shop_id
                               success:(JHNetworkRequestSuccessVoid)success
                               failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"user_id"] = user_id;
    mdic[@"shop_user_id"] = shop_user_id;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/chat_transfer_to" parameters:mdic.copy isNeedSVP:YES success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}
/// 商户发送消息
+ (void)sentChatMsgWithParameters:(NSDictionary *)parameters
                          shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/shop_send_msg" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

/// 给用户添加标签
+ (void)addChatUserLabelWithUser_id:(NSString *)user_id
                           label_id:(NSString *)label_id
                            shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"user_id"] = user_id;
    mdic[@"label_id"] = label_id;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/set_chat_user_label" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

/// 删除用户标签
+ (void)removeChatUserLabelWithUser_id:(NSString *)user_id
                           label_id:(NSString *)label_id
                               shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"user_id"] = user_id;
    mdic[@"label_id"] = label_id;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/set_chat_user_label_del" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}
@end
