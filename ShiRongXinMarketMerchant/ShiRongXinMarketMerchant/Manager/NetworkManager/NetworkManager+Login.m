//
//  NetworkManager+Login.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/25.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager+Login.h"

@implementation NetworkManager (Login)
+ (void)loginAccountWithUsername:(NSString *)username
               password:(NSString *)password
             login_type:(NSString *)login_type
                  success:(nonnull JHNetworkRequestSuccessVoid)success failure:(nonnull JHNetworkRequestFailure)failure {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"username"] = username;
    mDic[@"password"] = password;
    mDic[@"login_type"] = login_type;
    [[NetworkManager sharedClient] postWithURLString:@"shop/login_pwd" parameters:mDic.copy isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSDictionary *dic = messageDic[@"data"];
        UserInfo *info = [UserInfo mj_objectWithKeyValues:dic];
        [UserManager saveUserWithLoginMode:info];
        success(@"登录成功");
    } failure:^(NSString *error) {
        
    }];
}

+ (void)loginSMSWithMobile:(NSString *)mobile
                   code:(NSString *)code
                success:(JHNetworkRequestSuccessVoid)success
                  failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] postWithURLString:@"shop/login_verify_code" parameters:@{@"mobile":mobile,@"code":code} isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSDictionary *dic = messageDic[@"data"];
        UserInfo *info = [UserInfo mj_objectWithKeyValues:dic];
        [UserManager saveUserWithLoginMode:info];
        success(@"登录成功");
    } failure:failure];
}

+ (void)sendSMSWithMobile:(NSString *)mobile
                sms_event:(NSString *)sms_event
                success:(JHNetworkRequestSuccessVoid)success
                  failure:(JHNetworkRequestFailure)failure {
    [[NetworkManager sharedClient] getWithURLString:@"shop/send_code" parameters:@{@"mobile":mobile,@"sms_event":sms_event?:@""} isNeedSVP:NO success:^(NSDictionary *messageDic) {
        success(@"发送成功");
    } failure:failure];
}
@end
