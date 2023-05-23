//
//  SRXSmsAuthenticationVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootViewController.h"
#import "SRXSetInfoUpdateSuccessVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXSmsAuthenticationVC : RootViewController
@property (nonatomic, assign) SRXSetInfoUpdateSuccessType type;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *re_pwd;
@end

NS_ASSUME_NONNULL_END
