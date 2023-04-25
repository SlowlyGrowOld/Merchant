//
//  SRXOrdersListTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/20.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrdersListTableCell.h"
#import "SRXOrderListGoodsTableView.h"

#import "SRXOrdersRemarkVC.h"
#import "SRXOrderGoodsShippedVC.h"
#import "SRXOrderLogisticsDetailsVC.h"

@interface SRXOrdersListTableCell ()
@property (weak, nonatomic) IBOutlet SRXOrderListGoodsTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;

@end

@implementation SRXOrdersListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.datas = @[@"",@""];
    self.tableViewConsH.constant = 80 * 2;
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

- (IBAction)shippedBtnClick:(id)sender {
    UIStoryboard *order = [UIStoryboard storyboardWithName:@"Order" bundle:Nil];
    SRXOrderGoodsShippedVC *vc = [order instantiateViewControllerWithIdentifier:@"SRXOrderGoodsShippedVC"];
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (IBAction)lookLogistcsBtnClick:(id)sender {
    SRXOrderLogisticsDetailsVC *vc = [[SRXOrderLogisticsDetailsVC alloc] init];
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

@end
