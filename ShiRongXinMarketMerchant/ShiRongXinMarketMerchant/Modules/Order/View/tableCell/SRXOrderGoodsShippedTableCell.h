//
//  SRXOrderGoodsShippedTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXOrderGoodsShippedModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderGoodsShippedTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (nonatomic, strong) SRXOrderGoodsShippedModel *model;
@end

NS_ASSUME_NONNULL_END
