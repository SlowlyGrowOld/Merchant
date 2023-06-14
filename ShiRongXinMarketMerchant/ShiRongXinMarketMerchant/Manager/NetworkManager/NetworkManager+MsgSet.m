//
//  NetworkManager+MsgSet.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager+MsgSet.h"

@implementation NetworkManager (MsgSet)

+ (void)setQuickReplyGroupWithType:(NSString *)reply_group_type
                          group_id:(NSString *)group_id
                        group_name:(NSString *)group_name
                           shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                           failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"reply_group_type"] = reply_group_type;
    mdic[@"group_id"] = group_id;
    mdic[@"group_name"] = group_name;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/set_quick_reply_group" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

+ (void)getQuickReplyGroupWithWithShop_id:(NSString *)shop_id
                            success:(JHNetworkRequestSuccessArray)success
                                  failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_quick_reply_group" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXMsgReplysGroupItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

+ (void)setQuickReplyPhraseWithType:(NSString *)reply_type
                          group_id:(NSString *)group_id
                     replay_content:(NSString *)replay_content
                          reply_img:(NSString *)reply_img
                           reply_id:(NSString *)reply_id
                          success:(JHNetworkRequestSuccessVoid)success
                            failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"reply_type"] = reply_type;
    mdic[@"group_id"] = group_id;
    mdic[@"replay_content"] = replay_content;
    mdic[@"reply_img"] = reply_img;
    mdic[@"reply_id"] = reply_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/set_quick_reply" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

+ (void)getQuickReplyGroupNameWithWithShop_id:(NSString *)shop_id
                            success:(JHNetworkRequestSuccessArray)success
                                      failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_quick_reply_group_data" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXMsgReplysGroupItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

+ (void)setShopLabelsWithType:(NSString *)label_type
                   label_name:(NSString *)label_name
           label_color_number:(NSString *)label_color_number
                     label_id:(NSString *)label_id
                      shop_id:(NSString *)shop_id
                          success:(JHNetworkRequestSuccessVoid)success
                      failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"label_type"] = label_type;
    mdic[@"label_name"] = label_name;
    mdic[@"label_color_number"] = label_color_number;
    mdic[@"label_id"] = label_id;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/set_shop_labels" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

+ (void)getShopLabelsWithShop_id:(NSString *)shop_id
                    success:(JHNetworkRequestSuccessArray)success
                         failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_shop_labels" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSArray *array = [SRXMsgLabelsItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        success(array);
    } failure:failure];
}

+ (void)getChatInviteEvaluateWithShop_id:(NSString *)shop_id
                    success:(nonnull void (^)(SRXMsgChatEvaluate * _Nonnull))success failure:(nonnull JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_chat_shop_invite_evaluate" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        SRXMsgChatEvaluate *e = [SRXMsgChatEvaluate mj_objectWithKeyValues:messageDic[@"data"]];
        success(e);
    } failure:failure];
}

+ (void)setChatInviteEvaluateWithShop_id:(NSString *)shop_id
                          is_auto_invite:(NSString *)is_auto_invite
                          invite_content:(NSString *)invite_content
                    success:(JHNetworkRequestSuccessVoid)success
                    failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"is_auto_invite"] = is_auto_invite;
    mdic[@"invite_content"] = invite_content;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/set_chat_shop_invite_evaluate" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

+ (void)getChatWelcomeWithShop_id:(NSString *)shop_id
                    success:(nonnull void (^)(SRXMsgChatWelcome * _Nonnull))success
                          failure:(nonnull JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_chat_shop_welcome" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        SRXMsgChatWelcome *w = [SRXMsgChatWelcome mj_objectWithKeyValues:messageDic[@"data"]];
        success(w);
    } failure:failure];
}

+ (void)setChatWelcomeWithShop_id:(NSString *)shop_id
                  is_auto_welcome:(NSString *)is_auto_welcome
                  welcome_content:(NSString *)welcome_content
                      welcome_img:(NSString *)welcome_img
                    success:(JHNetworkRequestSuccessVoid)success
                          failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"is_auto_welcome"] = is_auto_welcome;
    mdic[@"welcome_content"] = welcome_content;
    mdic[@"welcome_img"] = welcome_img;
    mdic[@"shop_id"] = shop_id;
    [[NetworkManager sharedClient] postWithURLString:@"shop/set_chat_shop_welcome" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

+ (void)changeChatStatusWithChat_status:(NSString *)chat_status
                    success:(JHNetworkRequestSuccessVoid)success
                                failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"chat_status"] = chat_status;
    [[NetworkManager sharedClient] postWithURLString:@"shop/chat_shop_status_change" parameters:mdic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}

+ (void)getChatStatusWithSuccess:(JHNetworkRequestSuccessVoid)success
                         failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_chat_status" parameters:nil isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSDictionary *dic = messageDic[@"data"];
        success(dic[@"chat_status"]);
    } failure:failure];
}

/// 全部标记已读
+ (void)markChatAllReadWithSuccess:(JHNetworkRequestSuccessVoid)success
                           failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/chat_all_marks_read" parameters:nil isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}
@end
