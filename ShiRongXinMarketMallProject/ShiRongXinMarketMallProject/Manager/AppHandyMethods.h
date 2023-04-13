//
//  AppHandyMethods.h
//  ShiRongXinMarketMallProject
//
//  Created by 奇林刘 on 2020/3/6.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserDefaultkeyLoginModel @"UserDefaultkeyLoginModel"

NS_ASSUME_NONNULL_BEGIN
@interface AppHandyMethods : NSObject
//+ (void)saveUserWithLoginMode:(UserModelLogin *)loginModel;//保存用户信息
+ (void)clearUser;//清除用户信息
+ (void)switchWindowToMainScene;//切换到主界面
+ (void)switchWindowToBindPhoneScene;//切换到绑定手机号界面
+ (void)switchWindowToLoginScene;//切换到登录界面
+ (UIImage *)switchGetImageWithView:(UIScrollView *)scrollView;
+ (UIImage *)getImageWithView:(UIView *)view;

/// 客服页面
+(void)gotoServiceChat;

///绑定极光RegistrationID
+ (void)bindRegistrationID;

+ (void)handleAPNS:(NSDictionary *)apns;//处理收到的推送消息

/**
 比较两个版本号的大小（2.0）
 
 @param v1 第一个版本号
 @param v2 第二个版本号
 @return 版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
 */
+ (NSInteger)compareVersion2:(NSString *)v1 to:(NSString *)v2;

+ (void)theCopyActionWith:(NSString *)string;//复制

+ (NSAttributedString *)attrHtmlStringFrom:(NSString *)str;//加载html片段
//获取UILabel的行数
+ (NSInteger)rowsOfString:(NSString *)text withFont:(UIFont *)font withWidth:(CGFloat)width;

/*!
@brief 修正浮点型精度丢失
@param str 传入接口取到的数据
@return 修正精度后的数据
*/
+(NSString *)reviseString:(NSString *)str;
+ (void)switchToLoginAlert;
//打电话
+ (void)callWithPhone:(NSString *)phone;

//图片&视频 浏览器  图片不显示的问题是YYKit库里#import "YYAnimatedImageView.h" 没有适配iOS14
//- (void)displayLayer:(CALayer *)layer {
////    if (_curFrame) {
////        layer.contents = (__bridge id)_curFrame.CGImage;
////    }
//    UIImage *currentFrame = _curFrame;
//    if (!currentFrame) {
//    currentFrame = self.image;
//    }
//    if (currentFrame) {
//    layer.contentsScale = currentFrame.scale;
//    layer.contents = (__bridge id)currentFrame.CGImage;
//    }
//}
+ (void)showImageVideoBrowserArray:(NSArray *)dataArray selectedIndex:(NSInteger)index projectiveView:(nullable UIView *)projectiveView;
@end

NS_ASSUME_NONNULL_END
