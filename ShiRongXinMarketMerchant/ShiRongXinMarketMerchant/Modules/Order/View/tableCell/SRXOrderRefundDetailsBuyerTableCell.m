//
//  SRXOrderRefundDetailsBuyerTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderRefundDetailsBuyerTableCell.h"

@interface SRXOrderRefundDetailsBuyerTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *consignee;
@property (weak, nonatomic) IBOutlet UILabel *mobile;

@end

@implementation SRXOrderRefundDetailsBuyerTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser_info:(SRXOrderDUser_info *)user_info {
    _user_info = user_info;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:user_info.avatar]];
    _user_name.text = user_info.nickname;
    _consignee.text = user_info.consignee;
    _mobile.text = user_info.mobile;
}

@end
