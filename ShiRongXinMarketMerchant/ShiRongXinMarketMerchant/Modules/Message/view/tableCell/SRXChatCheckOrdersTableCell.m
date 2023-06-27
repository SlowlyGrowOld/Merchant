//
//  SRXMsgCheckOrdersTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatCheckOrdersTableCell.h"
#import "SRXOrderListGoodsTableView.h"
#import "SRXOrderGoodsShippedVC.h"

@interface SRXChatCheckOrdersTableCell ()
@property (weak, nonatomic) IBOutlet SRXOrderListGoodsTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;
@property (weak, nonatomic) IBOutlet UILabel *create_time;
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UILabel *shipping_amount;
@property (weak, nonatomic) IBOutlet UILabel *deduct_amount;
@property (weak, nonatomic) IBOutlet UILabel *pay_amount;
@property (weak, nonatomic) IBOutlet UILabel *consignee;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *address_status;
@property (weak, nonatomic) IBOutlet UILabel *user_remark;
@property (weak, nonatomic) IBOutlet UIButton *send_btn;
@property (weak, nonatomic) IBOutlet UIButton *update_btn;

@end

@implementation SRXChatCheckOrdersTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXOrderListModel *)model {
    _model = model;
    _create_time.text = model.create_time;
    _shipping_amount.text = [NSString stringWithNumber:@(model.shipping_amount) formatter:@"¥##.##"];
    _deduct_amount.text = model.deduct_score;
    _pay_amount.text = [NSString stringWithNumber:@(model.pay_amount) formatter:@"¥##.##"];
    _consignee.text = model.consignee;
    _address.text = model.full_address;
    _user_remark.text = model.remark;
    _statusLb.text = model.pay_status==1?@"已付款":@"待付款";
    _statusLb.textColor = model.pay_status==1?C43B8F6:UIColorHex(0x5DE0A1);

    self.tableView.datas = model.order_goods;
    self.tableViewConsH.constant = model.order_goods.count * 80;
    self.send_btn.hidden = YES;
    for (SRXOrderGoodsItem *item in self.model.order_goods) {
        if (item.order_delivery_id>0) {
            
        }else {
            self.send_btn.hidden = NO;
        }
    }
}

- (IBAction)sendGoodsBtnClick:(id)sender {
    UIStoryboard *order = [UIStoryboard storyboardWithName:@"Order" bundle:Nil];
    SRXOrderGoodsShippedVC *vc = [order instantiateViewControllerWithIdentifier:@"SRXOrderGoodsShippedVC"];
    vc.order_id = self.model.order_id;
    for (SRXOrderGoodsItem *item in self.model.order_goods) {
        if (item.order_delivery_id>0) {
            vc.is_distribute = YES;
        }
    }
    vc.is_single = self.model.goods_count==1?YES:NO;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (IBAction)updateBtnClick:(id)sender {
}

- (IBAction)copyBtnClick:(id)sender {
    [AppHandyMethods theCopyActionWith:self.model.full_address];
}

@end
