//
//  SRXOrderShippedGoodsTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/23.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderShippedGoodsTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goods_img;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UIView *selectView;

@end

NS_ASSUME_NONNULL_END
