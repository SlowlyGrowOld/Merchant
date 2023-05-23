//
//  SRXOrderDetailsInfoTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderDetailsInfoTableCell.h"

@interface SRXOrderDetailsInfoTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *order_sn;
@property (weak, nonatomic) IBOutlet UILabel *create_time;
@property (weak, nonatomic) IBOutlet UILabel *pay_type;
@property (weak, nonatomic) IBOutlet UILabel *pay_time;

@end

@implementation SRXOrderDetailsInfoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(SRXOrderDOrder_info *)info {
    _info = info;
    _order_sn.text = info.order_sn;
    _create_time.text = info.create_time;
    _pay_type.text = info.pay_type;
    _pay_time.text = info.pay_time;
}

- (IBAction)copyBtnClick:(id)sender {
    [AppHandyMethods theCopyActionWith:self.info.order_sn];
}

@end
