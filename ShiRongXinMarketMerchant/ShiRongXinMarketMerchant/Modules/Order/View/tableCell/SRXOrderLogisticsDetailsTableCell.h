//
//  SRXOrderLogisticsDetailsTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/25.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderLogisticsDetailsTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *headLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UILabel *infoLb;
@property (weak, nonatomic) IBOutlet UILabel *hourLb;
@property (weak, nonatomic) IBOutlet UILabel *monthLb;
@property (weak, nonatomic) IBOutlet UIView *safeView;

@end

NS_ASSUME_NONNULL_END
