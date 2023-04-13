//
//  UserAccount.h
//  ZFTParking
//
//  Created by 薛静鹏 on 2018/4/4.
//  Copyright © 2018年 薛静鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UserAccount : NSObject

@property (nonatomic,strong)NSString *account;//账号
//@property (nonatomic,strong)NSString *accountID;//用户id
@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong) NSDictionary *user;//用户所有信息
@property (strong, nonatomic) NSDictionary *systemConfig;
@property (nonatomic,assign) BOOL isOnline;
+ (instancetype)sharedAccount;

//设置用户信息
- (void)setUserInfo:(NSDictionary *)data;
/// 记住账号和密码
- (void)saveAccount:(NSString *)account Password:(NSString *)pwd;
/// 获取保存的用户名
- (NSString *)getSavedAccount;
/// 获取保存的密码
- (NSString *)getSavedPassword;
//是否退出登录 1:退出状态  2：登录状态
-(int)isOutLogin;

@end
