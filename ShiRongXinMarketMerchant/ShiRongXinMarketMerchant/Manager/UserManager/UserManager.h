//
//  UserManager.h
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "SRXShopDataItem.h"

typedef NS_ENUM(NSInteger, UserLoginType){
    kUserLoginTypeUnKnow = 0,//未知
    kUserLoginTypeWeChat,//微信登录
    kUserLoginTypeQQ,///QQ登录
    kUserLoginTypePwd,///账号登录
};

typedef void (^loginBlock)(BOOL success, NSString * des);

/**
 包含用户相关服务
 */
@interface UserManager : NSObject
//单例
SINGLETON_FOR_HEADER(UserManager)

//当前用户
@property (nonatomic, assign) UserLoginType loginType;
@property (nonatomic, strong) UserInfo *curUserInfo;
@property (nonatomic, strong) SRXShopDataItem *currentShop;
@property (nonatomic, assign) BOOL isLogined;

#pragma mark - ——————— 登录相关 ————————

/**
 三方登录

 @param loginType 登录方式
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType completion:(loginBlock)completion;

/**
 带参登录

 @param loginType 登录方式
 @param params 参数，手机和账号登录需要
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(loginBlock)completion;

/**
 自动登录

 @param completion 回调
 */
-(void)autoLoginToServer:(loginBlock)completion;

/**
 退出登录

 @param completion 回调
 */
- (void)logout:(loginBlock)completion;

/**
 加载缓存用户数据

 @return 是否成功
 */
-(BOOL)loadUserInfo;

//保存登录信息
+ (void)saveUserWithLoginMode:(UserInfo *)loginModel;
//清除登录信息
+ (void)clearUser;
//当前门店
+ (void)saveCurrentShop:(SRXShopDataItem *)currentShop;
@end
