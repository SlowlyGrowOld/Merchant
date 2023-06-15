//
//  SRXChatCouponListVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/14.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatCouponListVC.h"
#import "SRXChatCouponTableCell.h"

#import "NetworkManager+Message.h"

@interface SRXChatCouponListVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (nonatomic, strong) SRXMsgChatCoupnItem *selectItem;
@end

@implementation SRXChatCouponListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发优惠卷";
    self.view.backgroundColor = CViewBgColor;
    self.tableView.rowHeight = 104;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXChatCouponTableCell" bundle:nil] forCellReuseIdentifier:@"SRXChatCouponTableCell"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(52);
        make.bottom.mas_equalTo(-20-BottomSafeHeight-50);
    }];
    
    [self requestTableData];
}

#pragma mark - request
- (void)requestTableData {
    [NetworkManager getChatCouponListWithSearch:self.textField.text shop_id:self.shop_id page:self.pageNo pageSize:self.pageSize success:^(NSArray *modelList) {
        [self requestTableDataSuccessWithArray:modelList];
    } failure:^(NSString *message) {
        [self requestTableDataFailed];
    }];
}

#pragma mark - UIButton
- (IBAction)searchBtnClick:(id)sender {
    [self.tableView.mj_header beginRefreshing];
}

- (IBAction)sendCouponBtnClick:(id)sender {
    if (self.selectBlock && self.selectItem) {
        self.selectBlock(self.selectItem);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [SVProgressHUD showInfoWithStatus:@"请选择优惠券"];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    [self.tableView.mj_header beginRefreshing];
    return YES;
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXChatCouponTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXChatCouponTableCell" forIndexPath:indexPath];
    cell.item = self.dataSources[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (SRXMsgChatCoupnItem *m in self.dataSources) {
        m.is_select = NO;
    }
    self.selectItem = self.dataSources[indexPath.section];
    self.selectItem.is_select = YES;
    [self.tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
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
