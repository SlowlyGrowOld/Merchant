//
//  SRXGoodsListNewTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/7/3.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXGoodsListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXGoodsListNewTableCell : UITableViewCell
@property (nonatomic, strong) SRXGoodsListModel *model;
/**默认1。1=出售中，2=编辑中，3=审核中，4=已下架*/
@property (nonatomic , copy) NSString              * goods_status;
@end

NS_ASSUME_NONNULL_END
