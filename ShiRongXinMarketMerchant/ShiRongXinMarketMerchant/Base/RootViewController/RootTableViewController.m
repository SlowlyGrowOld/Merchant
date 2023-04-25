//
//  RootTableViewController.m
//  SeaStarVoiceProject
//
//  Created by 薛静鹏 on 2019/9/30.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()
@property (nonatomic,strong) UIImageView* noDataView;
@property (nonatomic,strong) UILabel *noDataLabel;//
/** 背景 */
@property (nonatomic,strong) UIView *bgView;
@end

@implementation RootTableViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return _StatusBarStyle;
}
//动态更新状态栏颜色
-(void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle{
    [UIApplication sharedApplication].statusBarStyle = StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =KWhiteColor;
    //是否显示返回按钮
    self.isShowLiftBack = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:nil];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
-(void)showNoDataImage
{
    _noDataView=[[UIImageView alloc] init];
    [_noDataView setImage:[UIImage imageNamed:@"不开心"]];
    _noDataLabel = [[UILabel alloc]init];
    _noDataLabel.numberOfLines = 0;
    _noDataLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    _noDataLabel.text = self.noDataStr;
    kWeakSelf;
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

#pragma mark ————— 导航栏 设置是否透明 —————

#pragma mark ————— 导航栏 设置是否透明 —————
- (void)setNavigationBarTransparent:(BOOL)hidden {
    if (hidden) {
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
            [self.navigationController.navigationBar setBackgroundImage:[UIImage jk_imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
        }
        //透明设置
        self.navigationController.navigationBar.translucent = YES;
        //navigationItem控件的颜色
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
    }else {
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
        //透明设置
        self.navigationController.navigationBar.translucent = NO;
        //navigationItem控件的颜色
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    }
}


@end