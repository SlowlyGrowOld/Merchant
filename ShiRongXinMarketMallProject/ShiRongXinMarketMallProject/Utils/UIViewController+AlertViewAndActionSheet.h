//
//  UIViewController+AlertViewAndActionSheet.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/6/1.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NO_USE -1000
typedef void(^click)(NSInteger index);
typedef void(^configuration)(UITextField *field, NSInteger index);
typedef void(^clickHaveField)(NSArray<UITextField *> *fields, NSInteger index);

@interface UIViewController (AlertViewAndActionSheet)
#ifdef kiOS8Later

#else
<
UIAlertViewDelegate,
UIActionSheetDelegate
>
#endif

/*!
 *  弹窗
 *
 *  @param title    标题
 *  @param message  详细描述
 *  @param others   按钮文字描述
 *  @param animated 是否需要动画
 *  @param click    点击事件
 */
- (void)AlertWithTitle:(NSString *)title
                 message:(NSString *)message
               andOthers:(NSArray<NSString *> *)others
                animated:(BOOL)animated
                  action:(click)click;

/*!
 *  use action sheet
 *
 *  @param title             标题
 *  @param message           详细描述
 *  @param destructive       按钮为红色的
 *  @param destructiveAction 红色按钮的点击事件
 *  @param others           其他按钮
 *  @param animated          是否需要动画
 *  @param click             其他按钮点击事件
 */
- (void)ActionSheetWithTitle:(NSString *)title
                       message:(NSString *)message
                   destructive:(NSString *)destructive
             destructiveAction:(click )destructiveAction
                     andOthers:(NSArray <NSString *> *)others
                      animated:(BOOL )animated
                        action:(click )click;

/*!
 *  包含输入框
 *
 *  @param title         标题
 *  @param message       详细描述
 *  @param buttons       按钮字符串数组
 *  @param number        输入框个数
 *  @param configuration 输入框值
 *  @param animated      是否需要动画
 *  @param click         按钮点击事件
 */
- (void)AlertWithTitle:(NSString *)title
                 message:(NSString *)message
                 buttons:(NSArray<NSString *> *)buttons
         textFieldNumber:(NSInteger )number
           configuration:(configuration )configuration
                animated:(BOOL )animated
                  action:(clickHaveField )click;

@end
