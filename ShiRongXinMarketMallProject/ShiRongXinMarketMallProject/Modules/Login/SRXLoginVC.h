//
//  SRXLoginVC.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2023/4/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootViewController.h"

typedef enum : NSUInteger {
    SRXLoginTypePhoneMsg,
    SRXLoginTypePhonePsd,
    SRXLoginTypeAccountPsd,
} SRXLoginType;

NS_ASSUME_NONNULL_BEGIN

@interface SRXLoginVC : RootViewController
//页面样式
@property (nonatomic, assign) SRXLoginType type;
@end

NS_ASSUME_NONNULL_END
