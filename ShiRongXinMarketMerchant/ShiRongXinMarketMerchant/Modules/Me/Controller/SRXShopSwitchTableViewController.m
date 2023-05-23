//
//  SRXShopSwitchTableViewController.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/19.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXShopSwitchTableViewController.h"
#import "SRXShopSwitchTableCell.h"
#import "NetworkManager+Login.h"

@interface SRXShopSwitchTableViewController ()
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SRXShopSwitchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"切换店铺";
    self.view.backgroundColor = CViewBgColor;
    self.tableView.rowHeight = 105;
    [self reuqestShopData];
}

- (void)reuqestShopData {
    [[NetworkManager sharedClient] getWithURLString:@"shop/getShopUserShops" parameters:@{@"shop_id":[UserManager sharedUserManager].curUserInfo.shop_id} isNeedSVP:YES success:^(NSDictionary *messageDic) {
        self.datas = [SRXShopDataItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        [self.tableView reloadData];
        } failure:^(NSString *error) {
            
        }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXShopSwitchTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXShopSwitchTableCell" forIndexPath:indexPath];
    cell.item = self.datas[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXShopDataItem *item = self.datas[indexPath.section];
    [UserManager sharedUserManager].curUserInfo.shop_id = item.shop_id;
    [UserManager saveUserWithLoginMode:[UserManager sharedUserManager].curUserInfo];
    [AppHandyMethods switchWindowToMainScene];
}

@end
