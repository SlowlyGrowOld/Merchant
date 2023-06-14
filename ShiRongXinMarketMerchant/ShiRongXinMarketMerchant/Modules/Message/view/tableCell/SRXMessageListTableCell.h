//
//  SRXMessageListTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXMessageListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXMessageListTableCell : UITableViewCell
@property (nonatomic, strong) SRXMessageListModel *model;
@end

NS_ASSUME_NONNULL_END
