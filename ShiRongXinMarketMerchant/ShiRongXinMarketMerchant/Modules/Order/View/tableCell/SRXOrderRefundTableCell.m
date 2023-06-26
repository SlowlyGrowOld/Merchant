//
//  SRXOrderRefundTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderRefundTableCell.h"
#import "SRXOrderListGoodsTableView.h"
#import "SRXMsgChatVC.h"
#import "SRXOrdersRemarkVC.h"
#import "SRXOrderRefundDetailsVC.h"

@interface SRXOrderRefundTableCell ()
@property (weak, nonatomic) IBOutlet SRXOrderListGoodsTableView *goodsTable;
@property (weak, nonatomic) IBOutlet UIImageView *user_avatar;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *order_status;
@property (weak, nonatomic) IBOutlet UILabel *jifen_number;
@property (weak, nonatomic) IBOutlet UILabel *pay_type;
@property (weak, nonatomic) IBOutlet UILabel *pay_money;
@property (weak, nonatomic) IBOutlet UILabel *ship_money;
@property (weak, nonatomic) IBOutlet UILabel *refund_type;
@property (weak, nonatomic) IBOutlet UILabel *ship_status;
@property (weak, nonatomic) IBOutlet UILabel *apply_time;
@property (weak, nonatomic) IBOutlet UILabel *reason;
@property (weak, nonatomic) IBOutlet UIButton *detailsBtn;

@end

@implementation SRXOrderRefundTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXOrderAfterSaleListModel *)model {
    _model = model;
    [_user_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    _user_name.text = model.nickname;
    _detailsBtn.superview.hidden = NO;
    if (model.status == 0) {
        _order_status.text = @"售后中";
        _order_status.textColor = UIColorHex(0x5DE0A1);
    } else if (model.status == -1) {
        _order_status.text = @"不同意";
        _order_status.textColor = CRed;
    } else if (model.status == 5) {
        _order_status.text = @"已退款";
        _order_status.textColor = CRed;
        _detailsBtn.superview.hidden = YES;
    }
    if ([model.pay_type isEqualToString:@"wechat"]) {
        _pay_type.text = @"微信";
        _pay_money.text = [NSString stringWithNumber:@(model.refund_money) formatter:@"¥##.##"];
    } else if ([model.pay_type isEqualToString:@"alipay"]) {
        _pay_type.text = @"支付宝";
        _pay_money.text = [NSString stringWithNumber:@(model.refund_money) formatter:@"¥##.##"];
    } else {
        _pay_type.text = @"余额";
        _pay_money.text = [NSString stringWithNumber:@(model.refund_deposit) formatter:@"¥##.##"];
    }
    _jifen_number.superview.hidden = model.refund_integral==0?YES:NO;
    _jifen_number.text = @(model.refund_integral).stringValue;
    
    _refund_type.text = model.type_cn;
    _ship_status.text = model.goods_status==0?@"未收到货":@"已收到货";
    _apply_time.text = model.create_time;
    _reason.text = model.reason;
    self.goodsTable.datas = @[model.order_goods];
}

- (IBAction)menuBtnClick:(id)sender {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertC addAction:[UIAlertAction actionWithTitle:@"订单备注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SRXOrdersRemarkVC *vc = [[SRXOrdersRemarkVC alloc] init];
        
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [[UIViewController jk_currentViewController] presentViewController:alertC animated:YES completion:nil];
}

- (IBAction)kefuBtnClick:(id)sender {
    SRXMsgChatVC *vc = [[SRXMsgChatVC alloc] init];
    SRXMessageListModel *item = [SRXMessageListModel new];
    item.nickname = self.model.nickname;
    item.avatar = self.model.avatar;
    item.user_id = self.model.user_id;
    vc.item = item;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

@end
