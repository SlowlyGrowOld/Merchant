//
//  SRXShopSwtichTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/19.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXShopSwitchTableCell.h"

@interface SRXShopSwitchTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *tagLb;
@property (weak, nonatomic) IBOutlet UIImageView *shop_image;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet UILabel *unpaid_number;
@property (weak, nonatomic) IBOutlet UILabel *unSend_number;
@property (weak, nonatomic) IBOutlet UILabel *return_number;

@end

@implementation SRXShopSwitchTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.tagLb settingRadius:10 corner:UIRectCornerBottomLeft];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
