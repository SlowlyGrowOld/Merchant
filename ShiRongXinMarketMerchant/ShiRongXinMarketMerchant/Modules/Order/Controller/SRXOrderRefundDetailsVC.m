//
//  SRXOrderRefundDetailsVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderRefundDetailsVC.h"
#import "SRXOrderRefundDetailsFlowTableCell.h"
#import "SRXOrderRefundDetailsGoodsTableCell.h"
#import "SRXOrderRefundDetailsBuyerTableCell.h"
#import "SRXOrderRefundDetailsInfoTableCell.h"
#import "SRXOrderRefundDetailsPicsTableCell.h"

#import "NetworkManager+Order.h"
#import "SRXOrderLogisticsDetailsVC.h"
#import "SRXOrderLogisticsListVC.h"

@interface SRXOrderRefundDetailsVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *rejectBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (nonatomic, strong) SRXOrderAfterSaleDetails *details;
@end

@implementation SRXOrderRefundDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"售后详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderRefundDetailsFlowTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderRefundDetailsFlowTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderRefundDetailsGoodsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderRefundDetailsGoodsTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderRefundDetailsBuyerTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderRefundDetailsBuyerTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderRefundDetailsInfoTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderRefundDetailsInfoTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderRefundDetailsPicsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderRefundDetailsPicsTableCell"];
    
    [self requestData];
}

- (IBAction)kefuBtnClick:(id)sender {
    
}

- (IBAction)rejectBtnClick:(id)sender {
    if ([self.rejectBtn.titleLabel.text isEqualToString:@"查看物流"]) {
        //    if (self.model.goods_count>1) {
        //        SRXOrderLogisticsListVC *vc = [[SRXOrderLogisticsListVC alloc] init];
        //        vc.order_id = self.model.order_id;
        //        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
        //    } else {
        //        SRXOrderLogisticsDetailsVC *vc = [[SRXOrderLogisticsDetailsVC alloc] init];
        //        vc.order_id = self.model.order_id;
        //        vc.express_sn = self.model.express_sn;
        //        vc.order_type = @"1";
        //        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
        //    }
            SRXOrderLogisticsListVC *vc = [[SRXOrderLogisticsListVC alloc] init];
//            vc.order_id = self.model.order_id;
            [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    } else {
        [NetworkManager setOrderAfterSaleStatusWithID:self.order_return_id operate_type:@"2" refuse_msg:@"" success:^(NSString *message) {
            
        } failure:^(NSString *message) {
            
        }];
    }
}

- (IBAction)agreeBtnClick:(id)sender {
    if ([self.agreeBtn.titleLabel.text isEqualToString:@"确认退款"]) {
        [NetworkManager sureOrderAfterSaleRefundWithID:self.order_return_id success:^(NSString *message) {
            [self requestData];
        } failure:^(NSString *message) {
            
        }];
    } else {
        [NetworkManager setOrderAfterSaleStatusWithID:self.order_return_id operate_type:@"1" refuse_msg:@"" success:^(NSString *message) {
            [self requestData];
        } failure:^(NSString *message) {
            
        }];
    }
}

- (void)requestData {
    [SVProgressHUD show];
    [NetworkManager getOrderAfterSaleDetailsWithID:self.order_return_id success:^(SRXOrderAfterSaleDetails * _Nonnull details) {
        self.details = details;
        [self setBottomBtn];
        [self.tableView reloadData];
    } failure:^(NSString *message) {
        
    }];
}

- (void)setBottomBtn {
    if (self.details.now_process==0) {
        self.rejectBtn.hidden = NO;
        self.agreeBtn.hidden = NO;
    } else {
        if (self.details.process_num==4) {
            if (self.details.now_process == 1) {
                [self.rejectBtn setTitle:@"查看物流" forState:UIControlStateNormal];
                self.agreeBtn.hidden = YES;
            } else if (self.details.now_process == 2) {
                [self.rejectBtn setTitle:@"查看物流" forState:UIControlStateNormal];
                [self.agreeBtn setTitle:@"确认退款" forState:UIControlStateNormal];
            }else {
                self.rejectBtn.hidden = YES;
                self.agreeBtn.hidden = YES;
            }
        } else {
            if (self.details.now_process == 1) {
                self.rejectBtn.hidden = YES;
                [self.agreeBtn setTitle:@"确认退款" forState:UIControlStateNormal];
            }else {
                self.rejectBtn.hidden = YES;
                self.agreeBtn.hidden = YES;
            }
        }
    }
}

#pragma mark - table data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.details.refund_images.count>0?5:4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        SRXOrderRefundDetailsFlowTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundDetailsFlowTableCell" forIndexPath:indexPath];
        [cell setProcessWithProcess_num:self.details.process_num now_process:self.details.now_process];
        return cell;
    } else if (indexPath.section==1) {
        SRXOrderRefundDetailsGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundDetailsGoodsTableCell" forIndexPath:indexPath];
        cell.goods_info = self.details.goods_info;
        return cell;
    } else if (indexPath.section==2) {
        SRXOrderRefundDetailsBuyerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundDetailsBuyerTableCell" forIndexPath:indexPath];
        cell.user_info = self.details.user_info;
        return cell;
    } else if (indexPath.section==3) {
        SRXOrderRefundDetailsInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundDetailsInfoTableCell" forIndexPath:indexPath];
        cell.return_info = self.details.return_info;
        return cell;
    } else {
        SRXOrderRefundDetailsPicsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundDetailsPicsTableCell" forIndexPath:indexPath];
        cell.datas = self.details.refund_images;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section==[tableView numberOfSections]-1?10:1;
}

@end
