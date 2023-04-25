//
//  SRXOrderLogisticsDetailsTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/25.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderLogisticsDetailsTableCell.h"

@interface SRXOrderLogisticsDetailsTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UILabel *infoLb;
@property (weak, nonatomic) IBOutlet UILabel *hourLb;
@property (weak, nonatomic) IBOutlet UILabel *monthLb;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation SRXOrderLogisticsDetailsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
