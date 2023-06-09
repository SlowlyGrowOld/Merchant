//
//  MainTabBarController.m
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import "MainTabBarController.h"
#import "UITabBar+CustomBadge.h"
#import "XYTabBar.h"

#import "SRXMessagePageVC.h"
#import "SRXGoodsListPageVC.h"
#import "SRXMeVC.h"
#import "SRXOrdersCenterPageC.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) NSMutableArray * VCS;//tabbar root VC

@end

@implementation MainTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //初始化tabbar
    [self setUpTabBar];
    //添加子控制器
    [self setUpAllChildViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requstRedDot];
    [JHWebSocketManager shareInstance].receiveBlock = ^(NSDictionary * _Nonnull dic) {
        if ([dic[@"msg_type"] isEqualToString:@"login"]) {
        }else {
            [self requstRedDot];
        }
    };
}


#pragma mark ————— 初始化TabBar —————
-(void)setUpTabBar{
    //设置背景色 去掉分割线
    [self setValue:[XYTabBar new] forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    
    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -5);
    self.tabBar.layer.shadowOpacity = 0.1;
}

#pragma mark - ——————— 初始化VC ————————
-(void)setUpAllChildViewController{
    _VCS = @[].mutableCopy;
    
    UIStoryboard *me = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    SRXMeVC *vc1 = [me instantiateViewControllerWithIdentifier:@"SRXMeVC"];
    [self setupChildViewController:vc1 title:@"工作台" imageName:@"tabbar_workbench" seleceImageName:@"tabbar_workbench_select"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    SRXMessagePageVC *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"SRXMessagePageVC"];
    [self setupChildViewController:vc2 title:@"消息" imageName:@"tabbar_message" seleceImageName:@"tabbar_message_select"];
    
    UIStoryboard *order = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
    SRXOrdersCenterPageC *vc3 =[order instantiateViewControllerWithIdentifier:@"SRXOrdersCenterPageC"];
//    SRXOrdersCenterPageC *vc3 = [SRXOrdersCenterPageC new];
    [self setupChildViewController:vc3 title:@"订单" imageName:@"tabbar_order" seleceImageName:@"tabbar_order_select"];
    
    UIStoryboard *goods = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
    SRXGoodsListPageVC *vc4 = [goods instantiateViewControllerWithIdentifier:@"SRXGoodsListPageVC"];
    [self setupChildViewController:vc4 title:@"商品" imageName:@"tabbar_me" seleceImageName:@"tabbar_me_select"];
    self.viewControllers = _VCS;
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *bar = [UITabBarAppearance new];
        bar.backgroundColor = [UIColor whiteColor];
        bar.backgroundEffect = nil;
        bar.shadowImage = nil;
        bar.shadowColor = nil;
        bar.stackedLayoutAppearance.normal.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:CFont3D};
        bar.stackedLayoutAppearance.selected.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:C43B8F6};
        if (@available(iOS 15.0, *)) {
            self.tabBar.scrollEdgeAppearance = bar;
        } else {
            // Fallback on earlier versions
        }
        self.tabBar.standardAppearance = bar;
    }else {
        //未选中字体颜色
        [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.blackColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateNormal];
        //选中字体颜色
        [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:C43B8F6,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateSelected];
    }
    //包装导航控制器
    RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:controller];
    [_VCS addObject:nav];
    
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //    NSLog(@"选中 %ld",tabBarController.selectedIndex);
//    [self requstRedDot];
}

-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow{
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
    }else{
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
    }
    
}


- (void)requstRedDot {
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_unread_num" parameters:nil isNeedSVP:NO success:^(NSDictionary *messageDic) {
        NSString *number = messageDic[@"data"];
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNumber value:number.intValue atIndex:1];
    } failure:^(NSString *error) {
        
    }];
}

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
