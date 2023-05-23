//
//  NetworkManager+Me.m
//  ShiRongXinMarketMerchant
//
//  Created by wyb on 2023/5/15.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager+Me.h"

@implementation NetworkManager (Me)
+ (void)getShopInfoWithShop_id:(NSString *)shop_id
                       success:(void(^)(SRXShopInfoModel *info))success
                       failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/shop_info" parameters:@{@"shop_id":shop_id} isNeedSVP:NO success:^(NSDictionary *messageDic) {
        SRXShopInfoModel *info = [SRXShopInfoModel mj_objectWithKeyValues:messageDic[@"data"]];
        success(info);
    } failure:failure];
}


+ (void)getIncomeInfoWithShop_id:(NSString *)shop_id
                      start_date:(NSString *)start_date
                        end_date:(NSString *)end_date
                       success:(void(^)(SRXIncomeInfo *info))success
                         failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"shop_id"] = shop_id;
    mDic[@"start_date"] = start_date;
    mDic[@"end_date"] = end_date;
    [[NetworkManager sharedClient] getWithURLString:@"shop/shop_info_income_data" parameters:mDic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        SRXIncomeInfo *info = [SRXIncomeInfo mj_objectWithKeyValues:messageDic[@"data"]];
        success(info);
    } failure:failure];
}

+ (void)getMeInfoWithSuccess:(void(^)(SRXMeInfo *info))success
                     failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/shop_user_info" parameters:nil isNeedSVP:NO success:^(NSDictionary *messageDic) {
        SRXMeInfo *info = [SRXMeInfo mj_objectWithKeyValues:messageDic[@"data"]];
        success(info);
    } failure:failure];
}

+ (void)changePasswordWithPwd:(NSString *)pwd
                       re_pwd:(NSString *)re_pwd
                      success:(JHNetworkRequestSuccessVoid)success
                      failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"pwd"] = pwd;
    mDic[@"re_pwd"] = re_pwd;
    [[NetworkManager sharedClient] postWithURLString:@"shop/shop_user_change_pwd" parameters:mDic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"data"]);
    } failure:failure];
}
 
+ (void)changePasswordWithPwd:(NSString *)pwd
                       re_pwd:(NSString *)re_pwd
                         code:(NSString *)code
                      success:(JHNetworkRequestSuccessVoid)success
                      failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"pwd"] = pwd;
    mDic[@"re_pwd"] = re_pwd;
    mDic[@"code"] = code;
    [[NetworkManager sharedClient] postWithURLString:@"shop/shop_user_change_pwd_deal" parameters:mDic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"msg"]);
    } failure:failure];
}

+ (void)changePhoneWithMobile:(NSString *)mobile
                      success:(JHNetworkRequestSuccessVoid)success
                      failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"mobile"] = mobile;
    [[NetworkManager sharedClient] postWithURLString:@"shop/shop_user_change_phone" parameters:mDic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"msg"]);
    } failure:failure];
}


/// 更换手机号处理
/// @param mobile 手机号
/// @param code 验证码
+ (void)changePhoneWithMobile:(NSString *)mobile
                         code:(NSString *)code
                      success:(JHNetworkRequestSuccessVoid)success
                      failure:(JHNetworkRequestFailure)failure {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"mobile"] = mobile;
    mDic[@"code"] = code;
    [[NetworkManager sharedClient] postWithURLString:@"shop/shop_user_change_phone_deal" parameters:mDic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(messageDic[@"msg"]);
    } failure:failure];
}
@end
