//
//  SRXOrderDetailsVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderDetailsVC.h"
#import "SRXOrderDetailsBuyerTableCell.h"
#import "SRXOrderDetailsGoodsTableCell.h"
#import "SRXOrderDetailsInfoTableCell.h"
#import "SRXOrderDetailsPayInfoTableCell.h"

#import "SRXOrderLogisticsListVC.h"
#import "SRXOrderGoodsShippedVC.h"

@interface SRXOrderDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *logisticsBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation SRXOrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    self.view.backgroundColor = CViewBgColor;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderDetailsBuyerTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderDetailsBuyerTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderDetailsGoodsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderDetailsGoodsTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderDetailsInfoTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderDetailsInfoTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderDetailsPayInfoTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderDetailsPayInfoTableCell"];
}

- (IBAction)logisticsBtnClick:(id)sender {
    SRXOrderLogisticsListVC *vc = [[SRXOrderLogisticsListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)sendGoodsBtnClick:(id)sender {
    UIStoryboard *order = [UIStoryboard storyboardWithName:@"Order" bundle:Nil];
    SRXOrderGoodsShippedVC *vc = [order instantiateViewControllerWithIdentifier:@"SRXOrderGoodsShippedVC"];
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

#pragma mark - table data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        SRXOrderDetailsBuyerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderDetailsBuyerTableCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section==1) {
        SRXOrderDetailsGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderDetailsGoodsTableCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section==2) {
        SRXOrderDetailsInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderDetailsInfoTableCell" forIndexPath:indexPath];
        return cell;
    } else {
        SRXOrderDetailsPayInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderDetailsPayInfoTableCell" forIndexPath:indexPath];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
