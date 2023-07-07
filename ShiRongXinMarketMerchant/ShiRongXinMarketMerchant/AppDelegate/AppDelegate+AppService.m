//
//  AppDelegate+AppService.m
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import <Reachability.h>
#import <IQKeyboardManager.h>
@implementation AppDelegate (AppService)


#pragma mark ————— 初始化服务 —————
-(void)initService{
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkStateChange:)
                                                 name:KNotificationNetWorkStateChange
                                               object:nil];
    
}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
#ifdef DEBUG
    NSString *onlineOrTest = [kUserDefaults stringForKey:SwitchServiceOnlineOrTest];
    if ([onlineOrTest isEqualToString:@"1"]) {//正式线
        [UserAccount sharedAccount].isOnline = YES;
    }else {
        [UserAccount sharedAccount].isOnline = NO;
    }
#else
    [UserAccount sharedAccount].isOnline = NO;
#endif
    
    //加载个人信息
    NSString *loginModelJsonString = [kUserDefaults stringForKey:UserDefaultkeyLoginModel];
    if (loginModelJsonString) [UserManager saveUserWithLoginMode:[UserInfo mj_objectWithKeyValues:loginModelJsonString]];
    if ([UserManager sharedUserManager].curUserInfo.access_token.length>0) {
        [AppHandyMethods switchWindowToMainScene];
    } else {
        [AppHandyMethods switchWindowToLoginScene];
    }

    //展示FPS
    [AppManager showFPS];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    [SVProgressHUD setMaximumDismissTimeInterval:3.0];
    [SVProgressHUD setBackgroundColor:kHRGBAlpha(0, 0, 0, .6)];
    [SVProgressHUD setForegroundColor:UIColor.whiteColor];

}

- (void)initIQKeyboard{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    IQKeyboardReturnKeyHandler  *returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] init];
    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    manager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
}
#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification
{
    BOOL isNetWork = [notification.object boolValue];
    
    if (isNetWork) {//有网络
        
    }else {//登陆失败加载登陆页面控制器

    }
}
#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus
{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    // 设置网络检测的站点
    NSString *remoteHostName = @"www.apple.com";
    Reachability *hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [hostReachability startNotifier];
}
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    [self updateInterfaceWithReachability:curReach];
}
- (void)updateInterfaceWithReachability:(Reachability *)reachability{
    
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus) {
            //            NotReachable = 0,
            //            ReachableViaWiFi,
            //            ReachableViaWWAN
            case 0:{
                DLog(@"网络环境：无网络");
                KPostNotification(KNotificationNetWorkStateChange, @NO);
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:KNotificationNetWorkState];
                break;
            }case 1:{
                DLog(@"网络环境：WiFi");
                KPostNotification(KNotificationNetWorkStateChange, @YES);
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KNotificationNetWorkState];
            }case 2:{
                DLog(@"网络环境：手机自带网络");
                KPostNotification(KNotificationNetWorkStateChange, @YES);
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KNotificationNetWorkState];
                break;
                
            }default:
            break;
    }
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

- (UIViewController *)currentPresentedVC {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


@end
