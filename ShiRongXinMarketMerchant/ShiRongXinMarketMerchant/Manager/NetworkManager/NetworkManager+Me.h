//
//  NetworkManager+Me.h
//  ShiRongXinMarketMerchant
//
//  Created by wyb on 2023/5/15.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "NetworkManager.h"
#import "SRXShopInfoModel.h"
#import "SRXIncomeInfo.h"
#import "SRXMeInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager (Me)


/// 工作台-店铺数据
/// @param shop_id 店铺id
+ (void)getShopInfoWithShop_id:(NSString *)shop_id
                       success:(void(^)(SRXShopInfoModel *info))success
                       failure:(JHNetworkRequestFailure)failure;


/// 工作台-收入数据
/// @param shop_id 店铺id
/// @param start_date 筛选开始时间 示例值:2023-04-25
/// @param end_date 筛选结束时间
+ (void)getIncomeInfoWithShop_id:(NSString *)shop_id
                      start_date:(nullable NSString *)start_date
                        end_date:(nullable NSString *)end_date
                       success:(void(^)(SRXIncomeInfo *info))success
                       failure:(JHNetworkRequestFailure)failure;

/// 工作台-个人资料
+ (void)getMeInfoWithSuccess:(void(^)(SRXMeInfo *info))success
                    failure:(JHNetworkRequestFailure)failure;


/// 修改密码1-判断密码-返回手机号
/// @param pwd 密码
/// @param re_pwd 二次密码
+ (void)changePasswordWithPwd:(NSString *)pwd
                       re_pwd:(NSString *)re_pwd
                      success:(JHNetworkRequestSuccessVoid)success
                      failure:(JHNetworkRequestFailure)failure;

/// 修改密码2-修改密码
/// @param pwd 密码
/// @param re_pwd 二次密码
/// @param code 验证码
+ (void)changePasswordWithPwd:(NSString *)pwd
                       re_pwd:(NSString *)re_pwd
                         code:(NSString *)code
                      success:(JHNetworkRequestSuccessVoid)success
                      failure:(JHNetworkRequestFailure)failure;


/// 更换手机号第一步-验证手机号是否已存在
/// @param mobile 手机号
+ (void)changePhoneWithMobile:(NSString *)mobile
                      success:(JHNetworkRequestSuccessVoid)success
                      failure:(JHNetworkRequestFailure)failure;


/// 更换手机号处理
/// @param mobile 手机号
/// @param code 验证码
+ (void)changePhoneWithMobile:(NSString *)mobile
                         code:(NSString *)code
                      success:(JHNetworkRequestSuccessVoid)success
                      failure:(JHNetworkRequestFailure)failure;
@end

NS_ASSUME_NONNULL_END
