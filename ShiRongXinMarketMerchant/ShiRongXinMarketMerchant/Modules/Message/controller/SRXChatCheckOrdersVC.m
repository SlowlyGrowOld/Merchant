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
#import "SRXOrderDetailsVC.h"

@interface SRXChatCheckOrdersVC ()

@end

@implementation SRXChatCheckOrdersVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"核对订单";
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXChatCheckOrdersTableCell" bundle:nil] forCellReuseIdentifier:@"SRXChatCheckOrdersTableCell"];
    [self.tableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderChange:) name:KNotificationOrderStatusChange object:nil];
}

- (void)orderChange:(NSNotification *)userinfo {
    [self.tableView.mj_header beginRefreshing];
}

- (void)requestTableData {
    [NetworkManager getChatOrderListWithUser_id:self.user_id shop_id:self.shop_id page:self.pageNo pageSize:self.pageSize success:^(NSArray *modelList) {
        [self requestTableDataSuccessWithArray:modelList];
    } failure:^(NSString *message) {
        [self requestTableDataFailed];
    }];
}
#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXChatCheckOrdersTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXChatCheckOrdersTableCell" forIndexPath:indexPath];
    cell.model = self.dataSources[indexPath.section];
    MJWeakSelf;
    [cell.sendMsgBtn addCallBackAction:^(UIButton *button) {
        if (weakSelf.selectBlock) {
            weakSelf.selectBlock(weakSelf.dataSources[indexPath.section]);
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrderListModel *model = self.dataSources[indexPath.section];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
    SRXOrderDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"SRXOrderDetailsVC"];
    vc.order_id = model.order_id;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
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
