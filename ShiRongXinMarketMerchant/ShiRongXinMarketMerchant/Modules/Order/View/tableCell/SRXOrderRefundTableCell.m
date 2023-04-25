//
//  SRXOrderRefundTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderRefundTableCell.h"
#import "SRXOrderListGoodsTableView.h"

#import "SRXOrdersRemarkVC.h"

@interface SRXOrderRefundTableCell ()
@property (weak, nonatomic) IBOutlet SRXOrderListGoodsTableView *goodsTable;
@property (weak, nonatomic) IBOutlet UIImageView *user_avatar;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *order_status;
@property (weak, nonatomic) IBOutlet UILabel *jifen_number;
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
    self.goodsTable.datas = @[@""];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
- (IBAction)detailsBtnClick:(id)sender {
}

- (IBAction)kefuBtnClick:(id)sender {
    
}

@end
