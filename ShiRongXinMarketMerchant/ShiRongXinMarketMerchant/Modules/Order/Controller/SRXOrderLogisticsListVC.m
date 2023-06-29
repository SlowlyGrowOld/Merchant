//
//  SRXOrderLogisticsListVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/23.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderLogisticsListVC.h"
#import "SRXOrderLogisticsListTableCell.h"
#import "SRXOrderLogisticsDetailsVC.h"

#import "NetworkManager+Order.h"

@interface SRXOrderLogisticsListVC ()

@end

@implementation SRXOrderLogisticsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"查看物流";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderLogisticsListTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderLogisticsListTableCell"];
    self.tableView.mj_footer.hidden = YES;
    [self requestTableData];
}

- (void)requestTableData {
    
    [NetworkManager getOrderGoodsDeliveryListWithOrderID:self.order_id shop_id:self.shop_id success:^(NSArray *modelList) {
        [self requestTableDataSuccessWithArray:modelList];
    } failure:^(NSString *message) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrderLogisticsListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderLogisticsListTableCell" forIndexPath:indexPath];
    cell.shop_id = self.shop_id;
    cell.model = self.dataSources[indexPath.section];
    cell.titleLb.text = [NSString stringWithFormat:@"包裹%zd",indexPath.section+1];
    return cell;
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
