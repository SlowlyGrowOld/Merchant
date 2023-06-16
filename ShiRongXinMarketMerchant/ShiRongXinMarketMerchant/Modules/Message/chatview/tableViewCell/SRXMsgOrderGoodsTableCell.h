//
//  SRXMsgOrderGoodsTableCell.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/26.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXMsgOrderGoodsTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *good_name;
@property (weak, nonatomic) IBOutlet UILabel *good_spec;

@end

NS_ASSUME_NONNULL_END
