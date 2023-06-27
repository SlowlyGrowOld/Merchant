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
#import "SRXSearchView.h"

@interface SRXChatCheckOrdersVC ()
@property (nonatomic, strong) SRXSearchView *searchView;
@property (nonatomic, copy) NSString *search_word;
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
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
    }];
    self.searchView = [[SRXSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.searchView.placeholder_text = @"请输入商品名称或订单编号";
    [self.view addSubview:self.searchView];
    MJWeakSelf;
    self.searchView.searchBlock = ^(NSString * _Nonnull search_key) {
        weakSelf.search_word = search_key;
        [weakSelf.tableView.mj_header beginRefreshing];
    };
}

- (void)orderChange:(NSNotification *)userinfo {
    [self.tableView.mj_header beginRefreshing];
}

- (void)requestTableData {
    [NetworkManager getChatOrderListWithUser_id:self.user_id shop_id:self.shop_id search:self.search_word page:self.pageNo pageSize:self.pageSize success:^(NSArray *modelList) {
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
        [weakSelf.navigationController popViewControllerAnimated:YES];
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
