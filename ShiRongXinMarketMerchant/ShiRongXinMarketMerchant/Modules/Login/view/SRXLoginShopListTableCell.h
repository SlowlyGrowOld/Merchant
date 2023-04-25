//
//  SRXLoginShopListTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/14.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXLoginModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXLoginShopListTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) SRXShopDataItem *model;
@end

NS_ASSUME_NONNULL_END
