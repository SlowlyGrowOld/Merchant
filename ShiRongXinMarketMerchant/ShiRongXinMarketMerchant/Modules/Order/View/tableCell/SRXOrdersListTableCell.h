//
//  SRXOrdersListTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/20.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXOrdersListTableCell : UITableViewCell
@property (nonatomic, strong) SRXOrderListModel *model;
@property (nonatomic, assign)  NSInteger order_type;
@end

NS_ASSUME_NONNULL_END
