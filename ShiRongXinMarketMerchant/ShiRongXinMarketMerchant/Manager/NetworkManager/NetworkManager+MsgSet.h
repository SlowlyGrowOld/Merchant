//
//  NetworkManager+MsgSet.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager.h"
#import "SRXMessageSetModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager (MsgSet)

/// 编辑回复短语-分组操作
/// - Parameters:
///   - reply_group_type: 1=新增，2=编辑，3=删除
///   - group_id: reply_group_type=2和3必传
///   - group_name: reply_group_type=1和2必传
///   - shop_id: shop_id
+ (void)setQuickReplyGroupWithType:(NSString *)reply_group_type
                          group_id:(NSString *)group_id
                        group_name:(NSString *)group_name
                           shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure;

/// 获取 设置中心-编辑回复短语-数据
+ (void)getQuickReplyGroupWithWithShop_id:(NSString *)shop_id
                            success:(JHNetworkRequestSuccessArray)success
                            failure:(JHNetworkRequestFailure)failure;

/// 设置中心-新增编辑短语
/// - Parameters:
///   - reply_type: 1=新增，2=编辑，3=删除
///   - group_id: 分组id
///   - replay_content: 短语内容，reply_type=1,2时必传
///   - reply_img: 照片img
///   - reply_id: 短语id，reply_type=2,3时必传
+ (void)setQuickReplyPhraseWithType:(NSString *)reply_type
                          group_id:(NSString *)group_id
                     replay_content:(NSString *)replay_content
                          reply_img:(NSString *)reply_img
                           reply_id:(NSString *)reply_id
                          success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure;

/// 获取 设置中心-短语-选择分组
+ (void)getQuickReplyGroupNameWithWithShop_id:(NSString *)shop_id
                            success:(JHNetworkRequestSuccessArray)success
                            failure:(JHNetworkRequestFailure)failure;


/// 设置中心-编辑标签
/// - Parameters:
///   - label_type: 1=新增，2=编辑，3=删除
///   - label_name: 标签名称，label_type=1,2必传
///   - label_color_number: 色号，label_type=1,2必传
///   - label_id: id，label_type=2,3必传
+ (void)setShopLabelsWithType:(NSString *)label_type
                   label_name:(NSString *)label_name
           label_color_number:(NSString *)label_color_number
                     label_id:(NSString *)label_id
                      shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure;
/// 获取商家标签
+ (void)getShopLabelsWithShop_id:(NSString *)shop_id
                         user_id:(NSString *)user_id
                    success:(JHNetworkRequestSuccessArray)success
                    failure:(JHNetworkRequestFailure)failure;

/// 设置中心-获取客户评价设置
+ (void)getChatInviteEvaluateWithShop_id:(NSString *)shop_id
                    success:(void(^)(SRXMsgChatEvaluate *evaluate))success
                    failure:(JHNetworkRequestFailure)failure;

/// 设置中心-客户评价设置
/// - Parameters:
///   - shop_id: 可选
///   - is_auto_invite: 自动邀请评价：0=关，1=开
///   - invite_content: 邀请文本
+ (void)setChatInviteEvaluateWithShop_id:(NSString *)shop_id
                          is_auto_invite:(NSString *)is_auto_invite
                          invite_content:(NSString *)invite_content
                    success:(JHNetworkRequestSuccessVoid)success
                    failure:(JHNetworkRequestFailure)failure;
/// 设置中心-获取欢迎语
+ (void)getChatWelcomeWithShop_id:(NSString *)shop_id
                    success:(void(^)(SRXMsgChatWelcome *welcome))success
                    failure:(JHNetworkRequestFailure)failure;
/// 设置中心-编辑欢迎语
+ (void)setChatWelcomeWithShop_id:(NSString *)shop_id
                  is_auto_welcome:(NSString *)is_auto_welcome
                  welcome_content:(NSString *)welcome_content
                      welcome_img:(NSString *)welcome_img
                    success:(JHNetworkRequestSuccessVoid)success
                    failure:(JHNetworkRequestFailure)failure;
/// 设置中心-状态切换  chat_status   1=值守，0=休息
+ (void)changeChatStatusWithChat_status:(NSString *)chat_status
                    success:(JHNetworkRequestSuccessVoid)success
                    failure:(JHNetworkRequestFailure)failure;

/// 设置中心-状态切换  chat_status   1=值守，0=休息
+ (void)getChatStatusWithSuccess:(JHNetworkRequestSuccessVoid)success
                         failure:(JHNetworkRequestFailure)failure;

/// 全部标记已读
+ (void)markChatAllReadWithSuccess:(JHNetworkRequestSuccessVoid)success
                           failure:(JHNetworkRequestFailure)failure;
@end

NS_ASSUME_NONNULL_END
