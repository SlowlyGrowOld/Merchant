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

@interface SRXChatCouponListVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation SRXChatCouponListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = 104;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXChatCouponTableCell" bundle:nil] forCellReuseIdentifier:@"SRXChatCouponTableCell"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(52);
        make.bottom.mas_equalTo(-20-BottomSafeHeight);
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
    
}

#pragma mark - UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXChatCouponTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXChatCouponTableCell" forIndexPath:indexPath];
    return cell;
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
