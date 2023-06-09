//
//  SRXGoodsSpecGroupCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/7.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXGoodsSpecGroupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *group_name;
@property (weak, nonatomic) IBOutlet UILabel *hintLb;
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

NS_ASSUME_NONNULL_END
