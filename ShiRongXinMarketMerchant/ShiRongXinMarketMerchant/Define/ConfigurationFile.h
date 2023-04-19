//
//  ConfigurationFile.h
//  ShiRongXinMarketMerchant
//
//  Created by 薛静鹏 on 2020/3/23.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#ifndef ConfigurationFile_h
#define ConfigurationFile_h

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HomeClassifyTypeFirst,//一级分类
    HomeClassifyTypeSecond,//二级分类
    HomeClassifyTypeThird,//三级分类
    HomeClassifyTypeShop,//店铺分类
} HomeClassifyType;

typedef enum : NSUInteger {
    ShoppingTypeClassify,//从三级分类获取列表
    ShoppingTypeSearch,//从搜索结果获取列表
    ShoppingTypeSetMeal,//从套餐类别获取列表
    ShoppingTypeMember,//会员商品类别获取列表
} ShoppingType;

typedef enum : NSUInteger {
    GoodsDetailTypeNormal,//正常商品详情
    GoodsDetailTypeSetMeal,//套餐商品详情
    GoodsDetailTypeAssemble,//拼团商品详情
    GoodsDetailTypeMember,//会员商品详情
    GoodsDetailTypeSpecGood,//特殊商品详情
} GoodsDetailType;

typedef enum : NSUInteger {
    SearchTypeNormal,//所有商品搜索
    SearchTypeShop,//针对店铺中的搜索
    SearchTypeClassifyTwo,//针对二级分类中的所有商品搜索
} SearchType;
typedef enum : NSUInteger {
    SRXSubmitOrderTypeNormal,//单件商品的购买
    SRXSubmitOrderTypeCar,//购物车
    SRXSubmitOrderTypeSetMeal,//套餐商品购买
    SRXSubmitOrderTypeBecomeAgentAdd,//购物车成为创客
    SRXSubmitOrderTypeBecomeAgent,//成为创客
    SRXSubmitOrderTypeTeam,//成为创客
    SRXSubmitOrderTypeGroup // 团购订单
} SRXSubmitOrderType;//确认订单页面

typedef enum : NSUInteger {
    SRXOrderTypeAll,//所有订单类型
    SRXOrderTypeWaitPay,//待支付订单
    SRXOrderTypeWaitDeliver,//待发货
    SRXOrderTypeWaitReceiving,//待收货
    SRXOrderTypeComplete,//已完成
    SRXOrderTypeRefund//退款/售后
} SRXOrderType;//订单列表上的订单类型

typedef enum : NSUInteger {
    SRXInMemberTypeNoMember,//不是会员
    SRXInMemberTypeInMember//是会员
} SRXInMemberType;//是否会员

typedef enum : NSUInteger {
    ReturnGoodsTypeReturnRefund,//退款（无需退货）
    ReturnGoodsTypeReturnGoodsAndRefund,//退货退款
    ReturnGoodsTypeChangeGoods,//我要换货
} ReturnGoodsType;//退货方式

typedef enum : NSUInteger {
    SRXProtocolTypeBasicProtocol,//基本用户协议
    SRXProtocolTypeAboutUs,//关于我们
    SRXProtocolTypePrivacy,//隐私政策
    SRXProtocolTypeSend,//代发协议
    SRXProtocolTypeSaveDetail,//寄存功能详情
    SRXProtocolTypeGoodsSave,//商品寄存协议
    SRXProtocolTypeAgent,//创客协议
    SRXProtocolTypePayment,//货款协议
    SRXProtocolTypeExchange,//兑换奖励规则
} SRXProtocolType;//协议类型

typedef enum : NSUInteger {
    DistributionChildMemberListTypeAll,//所有成员
    DistributionChildMemberListTypeOne,//一级成员
    DistributionChildMemberListTypeTwo,//二级成员
    DistributionChildMemberListTypeThree//三级成员
} DistributionChildMemberListType;//分销下级

typedef enum : NSUInteger {
    DistributionOrderDetailListTypeMember,//会员订单
    DistributionOrderDetailListTypeGoods,//商品订单
} DistributionOrderDetailListType;//分销中心订单明细


typedef enum : NSUInteger {
    AddressManageTypeNormal,//正常进入
    AddressManageTypeSelect,//选择地址
} AddressManageType;

typedef enum : NSUInteger {
    SRXBalanceDetailListTypeALL,//全部
    SRXBalanceDetailListTypeINCOME,//收入
    SRXBalanceDetailListTypePAY//支出
} SRXBalanceDetailListType;//余额详情页类型

typedef enum : NSUInteger {
    SRXPopFeatureSelectionTypeBuy,//直接购买商品选规格跳转确认订单
    SRXPopFeatureSelectionTypeShoppingCar,//选规格后，加入到购物车
    SRXPopFeatureSelectionTypeSelectFeature,//只是选择规格后收起
    SRXPopFeatureSelectionTypeCartChange,//购物车规格更改
    SRXPopFeatureSelectionTypeAddOrderList,//添加采购单
    SRXPopFeatureSelectionTypeBecomeAgentAdd,//成为创客-添加购物车
    SRXPopFeatureSelectionTypeBecomeAgent,//成为创客-购买
} SRXPopFeatureSelectionType;

typedef enum : NSUInteger {
    SRXDistributionIncomeDetailListTypeToday,
    SRXDistributionIncomeDetailListTypeYesterday,
    SRXDistributionIncomeDetailListTypeThisMonth,
    SRXDistributionIncomeDetailListTypeLastMonth
} SRXDistributionIncomeDetailListType;

/**
 *  chat消息发送状态
 */
typedef enum{
    SRXSendMessageType_Successed = 1,  //发送成功
    SRXSendMessageType_Failed,         //发送失败
    SRXSendMessageType_Sending         //发送中
}SRXSendMessageStatus;

#endif /* ConfigurationFile_h */
