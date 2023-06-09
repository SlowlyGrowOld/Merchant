//
//  SRXOrderDetailsBuyerTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXOrderDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderDetailsBuyerTableCell : UITableViewCell
@property (nonatomic, strong) SRXOrderDUser_info *info;
@property (nonatomic, copy) NSString *shop_id;
@end

NS_ASSUME_NONNULL_END
