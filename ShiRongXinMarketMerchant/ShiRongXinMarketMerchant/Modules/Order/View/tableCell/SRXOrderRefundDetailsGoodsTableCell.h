//
//  SRXOrderRefundDetailsGoodsTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXOrderDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderRefundDetailsGoodsTableCell : UITableViewCell
@property (nonatomic , strong) SRXOrderDGoods_infoItem              * goods_info;
@end

NS_ASSUME_NONNULL_END
