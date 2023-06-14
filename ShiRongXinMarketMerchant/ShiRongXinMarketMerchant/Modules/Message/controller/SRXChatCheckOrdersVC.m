//
//  SRXMsgCheckOrdersVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatCheckOrdersVC.h"
#import "SRXChatCheckOrdersTableCell.h"
#import "NetworkManager+Message.h"

@interface SRXChatCheckOrdersVC ()

@end

@implementation SRXChatCheckOrdersVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"核对订单";
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXChatCheckOrdersTableCell" bundle:nil] forCellReuseIdentifier:@"SRXChatCheckOrdersTableCell"];
    [self.tableView.mj_header beginRefreshing];
}

- (void)requestTableData {
    [NetworkManager getChatOrderListWithUser_id:self.user_id shop_id:self.shop_id success:^(NSArray *modelList) {
        [self requestTableDataSuccessWithArray:modelList];
    } failure:^(NSString *message) {
        [self requestTableDataFailed];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXChatCheckOrdersTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXChatCheckOrdersTableCell" forIndexPath:indexPath];
    cell.model = self.dataSources[indexPath.row];
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
    return 0.01;
}

@end
