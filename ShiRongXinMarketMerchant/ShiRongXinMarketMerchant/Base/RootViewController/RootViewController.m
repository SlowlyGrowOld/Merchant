//
//  RootViewController.m
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (nonatomic,strong) UIImageView* noDataView;
@property (nonatomic,strong) UILabel *noDataLabel;//
/** 背景 */
@property (nonatomic,strong) UIView *bgView;
@end

@implementation RootViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return _StatusBarStyle;
}
//动态更新状态栏颜色
-(void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle{
    [UIApplication sharedApplication].statusBarStyle = StatusBarStyle;
    // 调用这个方法,会调用上面的方法 preferredStatusBarStyle mark byKing
    [self setNeedsStatusBarAppearanceUpdate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =KWhiteColor;
    //是否显示返回按钮
    self.isShowLiftBack = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    //translucent=NO时,self.view的布局并不会从顶部开始，而是从NavigationBar的底部开始。
//    self.navigationController.navigationBar.translucent = NO;
//    //当导航栏不透明的时候，self.view的布局要不要延伸到Bar的下面铺满屏幕，默认为NO。
//    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)showNoDataImage
{
    [self removeNoDataImage];
    _noDataView=[[UIImageView alloc] init];
    [_noDataView setImage:[UIImage imageNamed:_noDataImg ? _noDataImg : @"不开心"]];
    _noDataLabel = [[UILabel alloc]init];
    _noDataLabel.numberOfLines = 0;
    _noDataLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    _noDataLabel.text = self.noDataStr ? self.noDataStr : @"暂无数据~";
    kWeakSelf;
    // 可以将下面代码合并成一个是scrollView mark byKing
    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            [obj addSubview:weakSelf.noDataView];
            [weakSelf.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view.mas_centerX);
                make.centerY.equalTo(self.view.mas_centerY);
            }];
            [obj addSubview:weakSelf.noDataLabel];
            [weakSelf.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view.mas_centerX);
                make.top.equalTo(self.noDataView.mas_bottom).offset(15);
            }];

        }
        else if ([obj isKindOfClass:[UICollectionView class]]) {
            [obj addSubview:weakSelf.noDataView];
            [weakSelf.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view.mas_centerX);
                make.centerY.equalTo(self.view.mas_centerY);
            }];
            [obj addSubview:weakSelf.noDataLabel];
            [weakSelf.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view.mas_centerX);
                make.top.equalTo(self.noDataView.mas_bottom).offset(15);
            }];
        }
    }];
}


- (void)showNoDataImageToView:(UIView *)view {
    
    [self removeNoDataImage];
    
    _noDataView=[[UIImageView alloc] init];
    [_noDataView setImage:[UIImage imageNamed:_noDataImg ? _noDataImg : @"不开心"]];
    _noDataLabel = [[UILabel alloc]init];
    _noDataLabel.numberOfLines = 0;
    _noDataLabel.textColor = UIColorHex(#202020);
    _noDataLabel.text = self.noDataStr ? self.noDataStr : @"暂无数据~";
    _noDataLabel.textAlignment = NSTextAlignmentCenter;
  
    [view addSubview:self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY);
    }];
    [view addSubview:self.noDataLabel];
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.noDataView.mas_bottom).offset(15);
    }];
}



-(void)removeNoDataImage{
    if (_noDataView) {
        [_noDataView removeFromSuperview];
        _noDataView = nil;
    }
    if (_noDataLabel) {
        [_noDataLabel removeFromSuperview];
        _noDataLabel = nil;
    }
}
/**
   *  是否显示返回按钮
   */
- (void) setIsShowLiftBack:(BOOL)isShowLiftBack
{
    _isShowLiftBack = isShowLiftBack;
    NSInteger VCCount = self.navigationController.viewControllers.count;
    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
    if (isShowLiftBack && ( VCCount > 1 || self.navigationController.presentingViewController != nil)) {
        self.navigationItem.hidesBackButton = NO;

    } else {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}
- (void)backBtnClicked
{
    if (self.presentingViewController) { // 有模态出自己的控制器
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ————— 导航栏 添加图片按钮 —————
/**
   导航栏添加图标按钮
 
 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    NSMutableArray * items = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    for (NSString * imageName in imageNames) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

        // 左边向左边10, 右边向右边10 mark byKing
        if (isLeft) {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }

        btn.tag = [tags[i++] integerValue];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

#pragma mark ————— 导航栏 添加文字按钮 —————
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    NSMutableArray * items = [[NSMutableArray alloc] init];
    NSMutableArray * buttonArray = [NSMutableArray array];
    NSInteger i = 0;
    for (NSString * title in titles) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = SYSTEMFONT(16);
        [btn setTitleColor:KBlackColor forState:UIControlStateNormal];
        btn.tag = [tags[i++] integerValue];
        [btn sizeToFit];

       //设置偏移
        if (isLeft) {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }

        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        [buttonArray addObject:btn];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}


#pragma mark ————— 导航栏 设置是否透明 —————
- (void)setNavigationBarTransparent:(BOOL)hidden {
    if (hidden) {
//        self.navigationController.navigationBar.translucent = YES;
//        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//        self.navigationController.navigationBar.shadowImage = [UIImage new];
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage jk_imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
//        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//        [self.navigationController.navigationBar setTitleTextAttributes:
//         @{NSFontAttributeName:[UIFont systemFontOfSize:17.f],
//           NSForegroundColorAttributeName:[UIColor whiteColor]}];
//        if (@available(iOS 11.0, *)) {
//
//        }else {
//            self.automaticallyAdjustsScrollViewInsets = UIApplicationBackgroundFetchIntervalMinimum;
//        }
        //navigation标题文字颜色
        NSDictionary *dic = @{NSForegroundColorAttributeName : UIColor.whiteColor,
                              NSFontAttributeName : [UIFont systemFontOfSize:17]};
        
        if (@available(iOS 13.0, *)) {
            UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
            barApp.backgroundColor = [UIColor clearColor];
            barApp.backgroundEffect = nil;
            barApp.shadowColor = [UIColor clearColor];
            //标题文字颜色
            barApp.titleTextAttributes = dic;
            self.navigationController.navigationBar.scrollEdgeAppearance = nil;
            self.navigationController.navigationBar.standardAppearance = barApp;
        }else {
            self.navigationController.navigationBar.titleTextAttributes = dic;
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
            // 通过透明色来设置透明图片. mark byKing
            [self.navigationController.navigationBar setBackgroundImage:[UIImage jk_imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
        }
        //透明设置
        self.navigationController.navigationBar.translucent = YES;
        //navigationItem控件的颜色
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
    }else {
//        self.navigationController.navigationBar.translucent = NO;
//        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//        self.navigationController.navigationBar.shadowImage = [UIImage new];
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage jk_imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setTitleTextAttributes:
//        @{NSFontAttributeName:[UIFont systemFontOfSize:17.f],
//          NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        NSDictionary *dic = @{NSForegroundColorAttributeName : UIColor.blackColor,
                              NSFontAttributeName : [UIFont systemFontOfSize:17]};
        
        if (@available(iOS 13.0, *)) {
            UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
            barApp.backgroundColor = [UIColor whiteColor];
            barApp.backgroundEffect = nil;
            barApp.shadowColor = [UIColor whiteColor];
            //标题文字颜色
            barApp.titleTextAttributes = dic;
            self.navigationController.navigationBar.scrollEdgeAppearance = barApp;
            self.navigationController.navigationBar.standardAppearance = barApp;
        }else {
            self.navigationController.navigationBar.titleTextAttributes = dic;
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
            [self.navigationController.navigationBar setBackgroundImage:[UIImage jk_imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
        }
        
        /*
         如果导航栏没有自定义背景图像，或者背景图像的任何像素的alpha值小于1.0，则此属性的默认值为“是”。如果背景图像完全不透明，则此属性的默认值为“否”。如果将此属性设置为“是”，并且自定义背景图像完全不透明，则UIKit会对图像应用小于1.0的系统定义不透明度。<#如果将此属性设置为“否”，且背景图像不不透明，UIKit会添加不透明背景。#>
         
         */
        //透明设置
        self.navigationController.navigationBar.translucent = NO;
        //navigationItem控件的颜色
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    }
}

/*
 1. 设置透明背景(黑色字体)
 
 */
- (void)setNavigationBarBlackColor {
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    NSDictionary *dic = @{NSForegroundColorAttributeName : UIColor.blackColor,
                          NSFontAttributeName : [UIFont systemFontOfSize:17]};
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
        barApp.backgroundColor = [UIColor clearColor];
        barApp.backgroundEffect = nil;
        barApp.shadowColor = [UIColor clearColor];
        //标题文字颜色
        barApp.titleTextAttributes = dic;
        self.navigationController.navigationBar.scrollEdgeAppearance = nil;
        self.navigationController.navigationBar.standardAppearance = barApp;
    }else {
        self.navigationController.navigationBar.titleTextAttributes = dic;
        [self.navigationController.navigationBar setShadowImage:[UIImage new]]; // 去掉分割线
        [self.navigationController.navigationBar setBackgroundImage:[UIImage jk_imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    }
    
}


//取消请求
- (void)cancelRequest
{

}

- (void)dealloc{
    NSLog(@">>>>>界面摧毁%@",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -  屏幕旋转
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //当前支持的旋转类型
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    // 是否支持旋转
    return NO;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    // 默认进去类型
    return   UIInterfaceOrientationPortrait;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

