//
//  SRXArrayTitlesAlertVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/5.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SRXArrayTitlesTypePlat,
    SRXArrayTitlesTypeShop,
    SRXArrayTitlesTypeSupplier,
    SRXArrayTitlesTypeDelivery,
} SRXArrayTitlesType;


@interface SRXArrayTitlesModel : SRXBaseModel
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *name;
@end

typedef void (^SRXLogisticsCompanyBlock) (SRXArrayTitlesModel *model);

@interface SRXArrayTitlesAlertVC : RootPresentViewController
@property (nonatomic, copy) SRXLogisticsCompanyBlock selectBlock;
@property (nonatomic, assign) SRXArrayTitlesType type;
@end


NS_ASSUME_NONNULL_END
