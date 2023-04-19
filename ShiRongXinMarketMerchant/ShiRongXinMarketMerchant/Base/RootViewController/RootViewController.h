//
//  RootViewController.h
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 VC 基类
 */
@interface RootViewController : UIViewController
/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;
@property (nonatomic,strong) NSString *noDataStr;//文字说明没有数据
@property (nonatomic,strong) NSString *noDataImg;//文字说明没有数据

/**
 *  显示没有数据页面
 */
-(void)showNoDataImage;
-(void)showNoDataImageToView:(UIView *)view;

/**
 *  移除无数据页面
 */
-(void)removeNoDataImage;

/**
 *  是否显示返回按钮,默认情况是YES
 */
@property (nonatomic, assign) BOOL isShowLiftBack;

/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;

/**
 导航栏添加文本按钮
 
 @param titles 文本数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 导航栏添加图标按钮
 
 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 *  默认返回按钮的点击事件，默认是返回，子类可重写
 */
- (void)backBtnClicked;

/**
导航栏透明
@param hidden 是否透明
*/
- (void)setNavigationBarTransparent:(BOOL)hidden;

/**
标题及返回按钮设置成黑色
*/
- (void)setNavigationBarBlackColor;

//取消网络请求
- (void)cancelRequest;
@end
