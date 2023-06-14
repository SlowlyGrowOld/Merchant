//
//  SHMessageInputView.h
//  SHChatUI
//
//  Created by CSH on 2018/6/5.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHMessageEnum.h"
#import "SHShareMenuItem.h"
/**
 聊天输入框
 */

@protocol SHMessageInputViewDelegate <NSObject>

@optional

// 文本
- (void)chatMessageWithSendText:(NSString *)text;

// 图片
- (void)chatMessageWithSendImage:(NSString *)imageName size:(CGSize)size;

// 视频
- (void)chatMessageWithSendVideo:(NSString *)videoName fileSize:(NSString *)fileSize duration:(NSString *)duration size:(CGSize)size;

// 语音
- (void)chatMessageWithSendAudio:(NSString *)audioName duration:(NSInteger)duration;

//工具栏高度改变
- (void)toolbarHeightChange;

//下方菜单点击
- (void)didSelecteMenuItem:(SHShareMenuItem *)menuItem index:(NSInteger)index;

@end

@interface SHMessageInputView : UIView

//父视图
@property (nonatomic, weak) UIViewController *supVC;
//代理
@property (nonatomic, weak) id<SHMessageInputViewDelegate> delegate;
//当前输入框类型
@property (nonatomic, assign) SHInputViewType inputType;
//多媒体数据
@property (nonatomic, copy) NSArray *shareMenuItems;
//引用文本
@property (nonatomic, copy) NSString *quoteText;

//刷新视图
- (void)reloadView;

#pragma mark - 菜单内容
//打开照片
- (void)openPhoto;
//打开相机
- (void)openCarema;
//打开我的订单
- (void)openOrders;

//清除内部通知
-(void)clear;

@end
