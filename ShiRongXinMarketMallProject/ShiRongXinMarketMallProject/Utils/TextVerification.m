//
//  TextVerification.m
//  PolyMerchant
//
//  Created by yxh on 2018/10/12.
//  Copyright © 2018年 yxh. All rights reserved.
//

#import "TextVerification.h"

@implementation TextVerification

+(BOOL)verificationPhone:(NSString *)phone{
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[05-8]|8[0-9]|9[89])\\d{8}$";
    
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
    
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|66|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    
    NSString *CT = @"(^1(33|53|77|8[019]|99)\\d{8}$)|(^1700\\d{7}$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:phone] == YES)
       || ([regextestcm evaluateWithObject:phone] == YES)
       || ([regextestct evaluateWithObject:phone] == YES)
       || ([regextestcu evaluateWithObject:phone] == YES)) {
        return YES;
    } else {
        return NO;
    }
}
+(BOOL)isEmailAddress:(NSString *)email{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",regex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)judgePassWordLegal:(NSString *)pass
{
    BOOL result = false;
    if ([pass length] >= 6 && [pass length] <= 12){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
//        NSString *passWordRegex = @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{6,18}$";
//        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
//        result = [pred evaluateWithObject:pass];
        return true;
    }
    return result;
}

+ (NSString *)getSeparatedPhoneNumberWithString:(NSString *)phoneString{
    NSString *truePhone = [phoneString stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *specCharacterSet = [characterSet invertedSet];
    NSArray * strArr = [truePhone componentsSeparatedByCharactersInSet:specCharacterSet];
    return [strArr componentsJoinedByString:@""];
}

@end
