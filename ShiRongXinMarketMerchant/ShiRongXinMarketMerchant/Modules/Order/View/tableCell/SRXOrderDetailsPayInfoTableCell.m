//
//  SRXOrderDetailsPayInfoTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderDetailsPayInfoTableCell.h"

@interface SRXOrderDetailsPayInfoTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *goods_amount;
@property (weak, nonatomic) IBOutlet UILabel *shipping_amount;
@property (weak, nonatomic) IBOutlet UILabel *discount_money;
@property (weak, nonatomic) IBOutlet UILabel *deduct_amount;
@property (weak, nonatomic) IBOutlet UILabel *pay_amount;

@end

@implementation SRXOrderDetailsPayInfoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(SRXOrderDPay_info *)info {
    _info = info;
    _goods_amount.text = [NSString stringWithFormat:@"¥%@",info.goods_amount];
    _shipping_amount.text = [NSString stringWithFormat:@"¥%@",info.shipping_amount];
    _discount_money.text = [NSString stringWithFormat:@"¥%@",info.discount_money];
    _deduct_amount.text = [NSString stringWithFormat:@"%@",info.deduct_amount];
    _pay_amount.text = [NSString stringWithFormat:@"¥%@",info.pay_amount];
}

@end
