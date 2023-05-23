//
//  SRXOrderRefundDetailsInfoTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderRefundDetailsInfoTableCell.h"

@interface SRXOrderRefundDetailsInfoTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *refund_integral;
@property (weak, nonatomic) IBOutlet UILabel *pay_amount;
@property (weak, nonatomic) IBOutlet UILabel *pay_type;
@property (weak, nonatomic) IBOutlet UILabel *shipping_amount;
@property (weak, nonatomic) IBOutlet UILabel *refund_type;
@property (weak, nonatomic) IBOutlet UILabel *refund_goods_status;
@property (weak, nonatomic) IBOutlet UILabel *create_time;
@property (weak, nonatomic) IBOutlet UILabel *reason;

@end

@implementation SRXOrderRefundDetailsInfoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setReturn_info:(SRXOrderDReturn_info *)return_info {
    _return_info = return_info;
    _refund_integral.text = @(return_info.refund_integral).stringValue;
    //wechat=微信,alipay=支付宝，其他不显示
    if ([return_info.pay_type isEqualToString:@"alipay"]) {
        _pay_type.text = @"支付宝";
    } else if ([return_info.pay_type isEqualToString:@"wechat"]) {
        _pay_type.text = @"微信";
    } else {
        _pay_type.text = @"";
    }
    _pay_amount.text = [NSString stringWithNumber:@(return_info.pay_amount) formatter:@"¥##.##"];
    _create_time.text = return_info.create_time;
    _shipping_amount.text = [NSString stringWithFormat:@"¥%@",return_info.shipping_amount];
    _refund_type.text = return_info.refund_type==1?@"退货退款":@"仅退款";
    _refund_goods_status.text = return_info.refund_goods_status==1?@"已收到货":@"未收到货";
    _reason.text = return_info.reason;
}

@end
