//
//  SRXLoginShopListVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/14.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXLoginShopListVC.h"
#import "SRXLoginShopListTableCell.h"
#import "SRXShopDataItem.h"
#import "NetworkManager+Login.h"

@interface SRXLoginShopListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SRXLoginShopListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = YES;
    self.tableView.rowHeight = 110;
    [self reuqestShopData];
}

- (void)reuqestShopData {
    [[NetworkManager sharedClient] getWithURLString:@"shop/getShopUserShops" parameters:nil isNeedSVP:YES success:^(NSDictionary *messageDic) {
        self.datas = [SRXShopDataItem mj_objectArrayWithKeyValuesArray:messageDic[@"data"]];
        [self.tableView reloadData];
        } failure:^(NSString *error) {
            
        }];
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXLoginShopListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXLoginShopListTableCell" forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"点击了");
    SRXShopDataItem *item = self.datas[indexPath.row];
    [UserManager sharedUserManager].curUserInfo.shop_id = item.shop_id;
    [UserManager saveUserWithLoginMode:[UserManager sharedUserManager].curUserInfo];
    [AppHandyMethods switchWindowToMainScene];
}

@end
