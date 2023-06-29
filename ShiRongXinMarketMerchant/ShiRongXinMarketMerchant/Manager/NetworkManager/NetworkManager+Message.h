//
//  NetworkManager+Message.h
//  ShiRongXinMarketMerchant
//
//  Created by wyb on 2023/5/15.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager.h"
#import "SRXMessageListModel.h"
#import "SRXOrderListModel.h"
#import "SRXMsgChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager (Message)

/// 消息中心 - 接待列表，标记列表
/// - Parameters:
///   - search_word: 搜索词，目前仅可搜索聊天内容
///   - chat_type: 默认1。1=招待列表， 2=标记列表
+ (void)getChatListWithSearch_word:(NSString *)search_word
                 chat_type:(NSString *)chat_type
                   shop_id:(NSString *)shop_id
                       page:(NSInteger)page
                   pageSize:(NSInteger)pageSize
                success:(JHNetworkRequestSuccessArray)success
                  failure:(JHNetworkRequestFailure)failure;

/// 消息中心-获取管理店铺的未读数量
+ (void)getChatShopNumWithSuccess:(JHNetworkRequestSuccessArray)success
                  failure:(JHNetworkRequestFailure)failure;

/// 消息中心-对话设置-移除对话
+ (void)removeChatUserWithUser_id:(NSString *)user_id
                          shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure;

/// 对话设置-设置备注
+ (void)setChatRemarkWithUser_id:(NSString *)user_id
                          shop_id:(NSString *)shop_id
                     remark_name:(NSString *)remark_name
                          success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure;

/// 推荐商品列表
+ (void)getRecommentChatGoodsWithSearch_word:(NSString *)search_word
                                     shop_id:(NSString *)shop_id
                                        page:(NSInteger)page
                                    pageSize:(NSInteger)pageSize
                                     success:(JHNetworkRequestSuccessArray)success
                                     failure:(JHNetworkRequestFailure)failure;

/// 订单核对列表
+ (void)getChatOrderListWithUser_id:(NSString *)user_id
                        shop_id:(NSString *)shop_id
                             search:(NSString *)search_word
                               page:(NSInteger)page
                           pageSize:(NSInteger)pageSize
                        success:(JHNetworkRequestSuccessArray)success
                        failure:(JHNetworkRequestFailure)failure;

/// 优惠券列表
+ (void)getChatCouponListWithSearch:(NSString *)search_word
                        shop_id:(NSString *)shop_id
                               page:(NSInteger)page
                           pageSize:(NSInteger)pageSize
                        success:(JHNetworkRequestSuccessArray)success
                        failure:(JHNetworkRequestFailure)failure;

/// 对话窗口-获取快捷回复列表
+ (void)getQuickReplyWithShop_id:(NSString *)shop_id
                    success:(JHNetworkRequestSuccessArray)success
                    failure:(JHNetworkRequestFailure)failure;

/// wss连接成功绑定用户id和client_id
+ (void)bindWSSWithClient_id:(NSString *)client_id
                         uid:(NSString *)uid
                    success:(JHNetworkRequestSuccessVoid)success
                    failure:(JHNetworkRequestFailure)failure;

/// 对话窗口 - 聊天记录
+ (void)getChatContentWithUser_id:(NSString *)user_id
                          shop_id:(NSString *)shop_id
                             page:(NSUInteger)page
                         pageSize:(NSUInteger)pageSize
                    success:(JHNetworkRequestSuccessArray)success
                    failure:(JHNetworkRequestFailure)failure;
/// 对话窗口 - 待发货，待付款，待评价数量 和 标签
+ (void)getChatOtherWithUser_id:(NSString *)user_id
                        shop_id:(NSString *)shop_id
                    success:(void(^)(SRXMsgChatOther *other))success
                    failure:(JHNetworkRequestFailure)failure;

/// 对话窗口-转接客服列表
+ (void)getChatTransferListWithShop_id:(NSString *)shop_id
                               success:(JHNetworkRequestSuccessArray)success
                               failure:(JHNetworkRequestFailure)failure;
/// 对话窗口-转接店铺列表
+ (void)getChatTransferShopsWithSearch_word:(NSString *)search_word
                               success:(JHNetworkRequestSuccessArray)success
                               failure:(JHNetworkRequestFailure)failure;

/// 转接按钮事件
+ (void)transferChatServiceWithUser_id:(NSString *)user_id
                          shop_user_id:(NSString *)shop_user_id
                               shop_id:(NSString *)shop_id
                            to_shop_id:(NSString *)to_shop_id //转接店铺列表的shop_id，is_mine_pipe=1时传
                               success:(JHNetworkRequestSuccessVoid)success
                               failure:(JHNetworkRequestFailure)failure;
/// 商户发送消息
+ (void)sentChatMsgWithParameters:(NSDictionary *)parameters
                          shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                               failure:(JHNetworkRequestFailure)failure;
/// 给用户添加标签
+ (void)addChatUserLabelWithUser_id:(NSString *)user_id
                           label_id:(NSString *)label_id
                            shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure;

/// 删除用户标签
+ (void)removeChatUserLabelWithUser_id:(NSString *)user_id
                           label_id:(NSString *)label_id
                               shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure;
@end

NS_ASSUME_NONNULL_END
