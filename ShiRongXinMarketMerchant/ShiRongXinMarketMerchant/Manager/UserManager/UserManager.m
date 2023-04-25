//
//  UserManager.m
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import "UserManager.h"
#import <JPUSHService.h>

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager);

-(instancetype)init{
    self = [super init];
    if (self) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKick)
                                                     name:KNotificationOnKick
                                                   object:nil];
    }
    return self;
}

#pragma mark ————— 三方登录 —————
-(void)login:(UserLoginType )loginType completion:(loginBlock)completion{
    [self login:loginType params:nil completion:completion];
}

#pragma mark ————— 带参数登录 —————
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(loginBlock)completion{
//    //友盟登录类型
//    UMSocialPlatformType platFormType;
//
//    if (loginType == kUserLoginTypeQQ) {
//        platFormType = UMSocialPlatformType_QQ;
//    }else if (loginType == kUserLoginTypeWeChat){
//        platFormType = UMSocialPlatformType_WechatSession;
//    }else{
//        platFormType = UMSocialPlatformType_UnKnown;
//    }
    //第三方登录
    if (loginType != kUserLoginTypePwd) {
        
    }else{
        //账号登录 暂未提供
    }
}

#pragma mark ————— 手动登录到服务器 —————
-(void)loginToServer:(NSDictionary *)params completion:(loginBlock)completion{
//    [MBProgressHUD showActivityMessageInView:@"登录中..."];
//    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_login) parameters:params success:^(id responseObject) {
//        [self LoginSuccess:responseObject completion:completion];
//
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUD];
//        if (completion) {
//            completion(NO,error.localizedDescription);
//        }
//    }];
}

#pragma mark ————— 自动登录到服务器 —————
-(void)autoLoginToServer:(loginBlock)completion{
//    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_auto_login) parameters:nil success:^(id responseObject) {
//        [self LoginSuccess:responseObject completion:completion];
//
//    } failure:^(NSError *error) {
//        if (completion) {
//            completion(NO,error.localizedDescription);
//        }
//    }];
}

#pragma mark ————— 登录成功处理 —————
-(void)LoginSuccess:(id )responseObject completion:(loginBlock)completion{
//    if (ValidDict(responseObject)) {
//        if (ValidDict(responseObject[@"data"])) {
//            NSDictionary *data = responseObject[@"data"];
//            if (ValidStr(data[@"imId"]) && ValidStr(data[@"imPass"])) {
//                //登录IM
//                [[IMManager sharedIMManager] IMLogin:data[@"imId"] IMPwd:data[@"imPass"] completion:^(BOOL success, NSString *des) {
//                    [MBProgressHUD hideHUD];
//                    if (success) {
//                        self.curUserInfo = [UserInfo modelWithDictionary:data];
//                        [self saveUserInfo];
//                        self.isLogined = YES;
//                        if (completion) {
//                            completion(YES,nil);
//                        }
//                        KPostNotification(KNotificationLoginStateChange, @YES);
//                    }else{
//                        if (completion) {
//                            completion(NO,@"IM登录失败");
//                        }
//                        KPostNotification(KNotificationLoginStateChange, @NO);
//                    }
//                }];
//            }else{
//                if (completion) {
//                    completion(NO,@"登录返回数据异常");
//                }
//                KPostNotification(KNotificationLoginStateChange, @NO);
//            }
//            
//        }
//    }else{
//        if (completion) {
//            completion(NO,@"登录返回数据异常");
//        }
//        KPostNotification(KNotificationLoginStateChange, @NO);
//    }
    
}
+ (void)saveUserWithLoginMode:(UserInfo *)loginModel {
    [UserManager sharedUserManager].curUserInfo = loginModel;
    [kUserDefaults setValue:loginModel.mj_JSONString forKey:UserDefaultkeyLoginModel];
    [kUserDefaults synchronize];
}

+ (void)clearUser {
    [UserManager sharedUserManager].curUserInfo = nil;
    [kUserDefaults setValue:nil forKey:UserDefaultkeyLoginModel];
    [kUserDefaults synchronize];
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        DLog(@"deleteAlias");
    } seq:1];
}

+ (void)saveCurrentShop:(SRXShopDataItem *)currentShop {
    [UserManager sharedUserManager].currentShop = currentShop;
    [kUserDefaults setValue:currentShop.mj_JSONString forKey:@"currentShop"];
    [kUserDefaults synchronize];
}

- (SRXShopDataItem *)currentShop {
    NSString *jsonString = [kUserDefaults stringForKey:@"currentShop"];
    if (jsonString) {
        return [SRXShopDataItem mj_objectWithKeyValues:jsonString];
    }else {
        return nil;
    }
}
//#pragma mark ————— 储存用户信息 —————
//-(void)saveUserInfo{
//    if (self.curUserInfo) {
//        YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
//        NSDictionary *dic = [self.curUserInfo modelToJSONObject];
//        [cache setObject:dic forKey:KUserModelCache];
//    }
//
//}
//#pragma mark ————— 加载缓存的用户信息 —————
//-(BOOL)loadUserInfo{
//    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
//    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
//    if (userDic) {
//        self.curUserInfo = [UserInfo modelWithJSON:userDic];
//        return YES;
//    }
//    return NO;
//}
//#pragma mark ————— 储存用户信息 —————
//-(void)saveMyInfo{
//    if (self.myInfoModel) {
//        YYCache *cache = [[YYCache alloc]initWithName:KMyInfoCacheName];
//        NSDictionary *dic = [self.myInfoModel modelToJSONObject];
//        [cache setObject:dic forKey:KMyInfoCacheName];
//    }
//
////}
//#pragma mark ————— 加载缓存的用户信息 —————
//-(BOOL)loadMyInfo{
//    YYCache *cache = [[YYCache alloc]initWithName:KMyInfoCacheName];
//    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KMyInfoCacheName];
//    if (userDic) {
//        self.myInfoModel = [MyInfoModel modelWithJSON:userDic];
//        return YES;
//    }
//    return NO;
//}
#pragma mark ————— 被踢下线 —————
-(void)onKick{
    [self logout:nil];
}
//#pragma mark ————— 退出登录 —————
//- (void)logout:(void (^)(BOOL, NSString *))completion{
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//
//    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
//
////    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogout object:nil];//被踢下线通知用户退出直播间
//
////    [[IMManager sharedIMManager] IMLogout];
//    self.curUserInfo = nil;
//    self.isLogined = NO;
//
////    //移除缓存
//    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
//    [cache removeAllObjectsWithBlock:^{
//        if (completion) {
//            completion(YES,nil);
//        }
//    }];
//
//    KPostNotification(KNotificationLoginStateChange, @NO);
//}
@end
