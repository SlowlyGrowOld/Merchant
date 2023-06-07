//
//  CommonMacros.h
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

//全局标记字符串，用于 通知 存储

#ifndef CommonMacros_h
#define CommonMacros_h

#pragma mark - ——————— 用户相关 ————————
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//自动登录成功
#define KNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"

//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"

//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"

//我de信息缓存 名称
#define KMyInfoCacheName @"KMyInfoCacheName"

//用户model缓存
#define KUserModelCache @"KUserModelCache"

//购物车更新通知
#define KShppingCarAdd @"KShppingCarAdd"
#define KShppingCarUpdate @"KShppingCarUpdate"

//首页顶部item切换
#define KSHomeSwitchItem @"KSHomeSwitchItem"

//联创申请结果弹窗
#define KAgentAlertCache @"KAgentAlertCache"

//我的客户列表刷新
#define KMyCustomerListRefresh @"KMyCustomerListRefresh"

//确认订单快递方式改变
#define KSubmitOrderDeliveryMethodChange @"KSubmitOrderDeliveryMethodChange"

//购买会员成功
#define KNotificationBuyMemberSuccess @"KNotificationBuyMemberSuccess"

//创建红包成功
#define KNotificationCreateRedPacketSuccess @"KNotificationCreateRedPacketSuccess"

//商品评价成功
#define KNotificationGoodEvaluateSuccess @"KNotificationGoodEvaluateSuccess"

//我的订单状态改变
#define KNotificationMyOrderChange @"KNotificationMyOrderChange"

//我的订单状态改变
#define KNotificationJumpHomeCategory @"KNotificationJumpHomeCategory"

//发送消息失败
#define KNotificationMsgSendFail @"KNotificationMsgSendFail"

//文本长按菜单操作通知
#define KNotiChatTextMenuAction @"KNotiChatTextMenuAction"

//我的-弹窗去签到提示
#define KSignInRemind @"KSign_in_remind"


#define KNotificationOrderStatusChange @"KNotificationOrderStatusChange"

#define KNotificationGoodsInfoChange @"KNotificationGoodsInfoChange"


#pragma mark - ——————— 网络状态相关 ————————

//网络状态变化
#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"
#define KNotificationNetWorkState @"KNotificationNetWorkState"

//#define AliPayScheme @"aliPay2021001107666926"
#define AliPayScheme @"aliPay2021002161627039"
#define WechatAppID @"wx280f1fcec570f67b"

//切换服务器
#define SwitchServiceOnlineOrTest @"SwitchServiceOnlineOrTest"

#define PageRows 10

#endif /* CommonMacros_h */
