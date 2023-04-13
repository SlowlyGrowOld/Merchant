//
//  AppDelegate.m
//  ShiRongXinMarketMallProject
//
//  Created by Alucardulad on 1/9/20.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <WXApi.h>
#import <WXApiObject.h>
#import "XHLaunchAd.h"
#import <MeiQiaSDK/MeiQiaSDK.h>

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()<WXApiDelegate, JPUSHRegisterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UITabBar appearance] setTintColor:MainColor];
    //初始化window
    [self initWindow];
    //初始化app服务
    [self initService];
    //初始化IM
//    [[IMManager sharedIMManager] initIM];
    //网络监听
    [self monitorNetworkStatus];
    [self initIQKeyboard];
    //广告页
    [AppManager appStart];

    [UMConfigure initWithAppkey:@"5ec4db22dbc2ec0816fa04fc" channel:nil];
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WechatAppID appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    [WXApi registerApp:WechatAppID universalLink:@"https://app.goeasy.vip/"];
    
    //启动广告页
//    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
//    [XHLaunchAd setWaitDataDuration:0];

    
    //Required
      //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    [self initJPushWithLaunchOptions:launchOptions];
    
    [MQManager initWithAppkey:@"ff054af0af3e16281a0243defaa64315" completion:^(NSString *clientId, NSError *error) {
        if (!error) {
            NSLog(@"美洽 SDK：初始化成功");
        } else {
            NSLog(@"error:%@",error);
        }
    }];
     
    return YES;
}


/**
 广告点击回调

 @param launchAd launchAd
 @param openModel 打开页面参数(此参数即你配置广告数据设置的configuration.openModel)
 @param clickPoint 点击位置
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{

}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            int result;
            if ([resultDic[@"resultStatus"]intValue]==9000) {
                result=1;
            }
            else{
                result=2;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ALIPAYRESULT" object:@{@"result":@(result)}];
        }];
    }
    else {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}
- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WeChatPayResult" object:@{@"payResult":resp} userInfo:nil];
    }
    else if ([resp isKindOfClass:[SendAuthResp class]]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WeChatLoginResult" object:(SendAuthResp *)resp];
    }
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

#pragma mark - JPush
- (void)initJPushWithLaunchOptions:(NSDictionary * _Nullable)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    [JPUSHService setupWithOption:launchOptions appKey:@"a834440e64f992896dc47a2f"
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [JPUSHService resetBadge];
    [application setApplicationIconBadgeNumber:0];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

  // Required, For systems with less than or equal to iOS 6
  [JPUSHService handleRemoteNotification:userInfo];
}

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
  if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    //从通知界面直接进入应用
  }else{
    //从通知设置界面进入应用
  }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    NSString *type = userInfo[@"type"];
    if (type.integerValue == 10) {//type=10，app内不弹推送
        completionHandler(UNNotificationPresentationOptionSound);
    }else {
        completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
  // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [AppHandyMethods handleAPNS:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

@end
