//
//  NetworkManager+Login.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/25.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager.h"
#import "SRXLoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager (Login)
/// 登录
/// @param username 账号或手机号
/// @param password 密码
/// @param login_type 1=账号+密码，2=手机号+密码
+ (void)loginAccountWithUsername:(NSString *)username
               password:(NSString *)password
             login_type:(NSString *)login_type
                success:(JHNetworkRequestSuccessVoid)success
                  failure:(JHNetworkRequestFailure)failure;

/// 手机验证码登录
/// @param mobile 手机号
/// @param code 短信
+ (void)loginSMSWithMobile:(NSString *)mobile
                   code:(NSString *)code
                success:(JHNetworkRequestSuccessVoid)success
                  failure:(JHNetworkRequestFailure)failure;


/// 发送短信
/// @param mobile 手机号
/// @param sms_event 事件，登录=login，
+ (void)sendSMSWithMobile:(NSString *)mobile
                sms_event:(NSString *)sms_event
                success:(JHNetworkRequestSuccessVoid)success
                  failure:(JHNetworkRequestFailure)failure;
@end

NS_ASSUME_NONNULL_END
