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

@interface SRXOrderRefundDetailsVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *rejectBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

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
}
- (IBAction)kefuBtnClick:(id)sender {
}
- (IBAction)rejectBtnClick:(id)sender {
}
- (IBAction)agreeBtnClick:(id)sender {
}


#pragma mark - table data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        SRXOrderRefundDetailsFlowTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundDetailsFlowTableCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section==1) {
        SRXOrderRefundDetailsGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundDetailsGoodsTableCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section==2) {
        SRXOrderRefundDetailsBuyerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundDetailsBuyerTableCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section==3) {
        SRXOrderRefundDetailsInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundDetailsInfoTableCell" forIndexPath:indexPath];
        return cell;
    } else {
        SRXOrderRefundDetailsPicsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundDetailsPicsTableCell" forIndexPath:indexPath];
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
    return 1;
}

@end
