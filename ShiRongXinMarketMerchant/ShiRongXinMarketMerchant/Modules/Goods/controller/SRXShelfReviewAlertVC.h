//
//  SRXShelfReviewAlertVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/7/3.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"

typedef enum : NSUInteger {
    SRXShelfReviewAlertTypeAdded,//上架
    SRXShelfReviewAlertTypeAudit,//提交审核
} SRXShelfReviewAlertType;
NS_ASSUME_NONNULL_BEGIN

typedef void(^SRXShelfReviewAlertBlock)(BOOL isSure);

@interface SRXShelfReviewAlertVC : RootPresentViewController
@property (nonatomic, assign) SRXShelfReviewAlertType type;
@property (nonatomic, copy)  SRXShelfReviewAlertBlock block;
@end

NS_ASSUME_NONNULL_END
