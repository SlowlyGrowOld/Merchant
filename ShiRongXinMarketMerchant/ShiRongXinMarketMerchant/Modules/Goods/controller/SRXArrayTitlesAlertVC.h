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
    SRXArrayTitlesTypePlat,//平台
    SRXArrayTitlesTypeShop,//店铺
    SRXArrayTitlesTypeSupplier,//供应商
    SRXArrayTitlesTypeDelivery,//快递
    SRXArrayTitlesTypeGroup,//快速回复分组名称
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
