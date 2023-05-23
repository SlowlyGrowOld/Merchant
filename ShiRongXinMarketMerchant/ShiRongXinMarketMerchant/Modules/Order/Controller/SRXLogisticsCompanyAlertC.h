//
//  SRXLogisticsCompanyAlertC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/23.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"
#import "NetworkManager+Order.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^SRXLogisticsCompanyBlock) (SRXExpressListModel *model);

@interface SRXLogisticsCompanyAlertC : RootPresentViewController
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) SRXLogisticsCompanyBlock selectBlock;
@end

NS_ASSUME_NONNULL_END
