//
//  SRXSetInfoUpdateSuccessVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootViewController.h"

typedef enum : NSUInteger {
    SRXSetInfoUpdateSuccessTypePsd,
    SRXSetInfoUpdateSuccessTypePhone,
} SRXSetInfoUpdateSuccessType;
NS_ASSUME_NONNULL_BEGIN

@interface SRXSetInfoUpdateSuccessVC : RootViewController
@property (nonatomic, assign) SRXSetInfoUpdateSuccessType type;
@end

NS_ASSUME_NONNULL_END
