//
//  RootTableViewController.h
//  SeaStarVoiceProject
//
//  Created by 薛静鹏 on 2019/9/30.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootTableViewController : UITableViewController
/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;
@property (nonatomic,strong) NSString *noDataStr;//文字说明没有数据
/**
 *  显示没有数据页面
 */
-(void)showNoDataImage;

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
导航栏透明
@param hidden 是否透明
*/
- (void)setNavigationBarTransparent:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
