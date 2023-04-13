//
//  AppDelegate.h
//  ShiRongXinMarketMallProject
//
//  Created by Alucardulad on 1/9/20.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"
/**
这里面只做调用，具体实现放到 AppDelegate+AppService 或者Manager里面，防止代码过多不清晰
*/
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainTabBarController *mainTabBar;

@end

