//
//  SRXOrdersListGoodsTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXOrdersListGoodsTableCell : UITableViewCell
@property (nonatomic, strong) SRXOrderGoodsItem *item;
@property (nonatomic, assign) NSInteger goods_count;
@end

NS_ASSUME_NONNULL_END
