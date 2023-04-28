//
//  SRXMemberCenterImageVC.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/11/16.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "RootViewController.h"


typedef enum : NSUInteger {
    SRXProtocolHtmlTypeUserProtocol,//用户协议
    SRXProtocolHtmlTypePrivacyPolicy,//会员规则
} SRXProtocolHtmlType;

NS_ASSUME_NONNULL_BEGIN

@interface SRXProtocolHtmlVC : RootViewController
@property (nonatomic, copy) NSString *content;

@property (nonatomic,assign) SRXProtocolHtmlType type;
@end

NS_ASSUME_NONNULL_END
