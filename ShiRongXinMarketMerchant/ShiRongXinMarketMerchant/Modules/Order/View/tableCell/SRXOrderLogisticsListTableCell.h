//
//  SRXOrderLogisticsListTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/23.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXOrderDeliveryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderLogisticsListTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (nonatomic, strong) SRXOrderDeliveryModel *model;
@property (nonatomic, strong) NSString *shop_id;
@end

NS_ASSUME_NONNULL_END
