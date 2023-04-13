//
//  TextVerification.h
//  PolyMerchant
//
//  Created by yxh on 2018/10/12.
//  Copyright © 2018年 yxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextVerification : NSObject


/**
 验证手机号

 @param phone 手机号
 @return 结果
 */
+(BOOL)verificationPhone:(NSString *)phone;

/**
 邮箱验证

 @param email 邮箱
 @return 结果
 */
+(BOOL)isEmailAddress:(NSString *)email;


/**
 密码验证

 @param pass 密码
 @return 结果
 */
+(BOOL)judgePassWordLegal:(NSString *)pass;


/**
 去除特殊字符

 @param phoneString 手机号
 @return 返回结果
 */
+ (NSString *)getSeparatedPhoneNumberWithString:(NSString *)phoneString;

@end
