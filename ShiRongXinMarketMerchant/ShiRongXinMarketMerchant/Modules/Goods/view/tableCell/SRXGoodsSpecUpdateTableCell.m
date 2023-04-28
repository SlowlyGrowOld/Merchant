//
//  SRXGoodsSpecUpdateTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsSpecUpdateTableCell.h"

@interface SRXGoodsSpecUpdateTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *integral;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextField *integralTF;

@end

@implementation SRXGoodsSpecUpdateTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIsStore:(BOOL)isStore {
    _isStore = isStore;
    self.priceTF.superview.hidden = isStore;
    self.integral.text = @"库存";
}

@end
