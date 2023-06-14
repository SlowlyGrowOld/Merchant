//
//  SRXMsgCheckOrdersTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatCheckOrdersTableCell.h"
#import "SRXOrderListGoodsTableView.h"

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
@property (weak, nonatomic) IBOutlet UIButton *sendMsgBtn;

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
    _deduct_amount.text = model.deduct_amount;
    _pay_amount.text = [NSString stringWithNumber:@(model.pay_amount) formatter:@"¥##.##"];
    _consignee.text = model.consignee;
    _address.text = model.full_address;
    _user_remark.text = model.remark;

    self.tableView.datas = model.order_goods;
    self.tableViewConsH.constant = model.order_goods.count * 80;
}

- (IBAction)sendGoodsBtnClick:(id)sender {
    
}

- (IBAction)updateBtnClick:(id)sender {
}

- (IBAction)sendOrderBtnClick:(id)sender {
}

- (IBAction)copyBtnClick:(id)sender {
    [AppHandyMethods theCopyActionWith:self.model.full_address];
}

@end
