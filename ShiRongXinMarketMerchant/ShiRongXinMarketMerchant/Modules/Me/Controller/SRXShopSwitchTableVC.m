//
//  SRXShopSwitchTableVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/7/7.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXShopSwitchTableVC.h"
#import "SRXShopSwitchTableCell.h"
#import "NetworkManager+Login.h"
#import "SRXSearchView.h"

@interface SRXShopSwitchTableVC ()
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) SRXSearchView *searchView;
@property (nonatomic, copy) NSString *search_word;
@end

@implementation SRXShopSwitchTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"切换店铺";
    self.view.backgroundColor = CViewBgColor;
    self.tableView.rowHeight = 105;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXShopSwitchTableCell" bundle:nil] forCellReuseIdentifier:@"SRXShopSwitchTableCell"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
    }];
    [self reuqestShopData];
    self.searchView = [[SRXSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.searchView.placeholder_text = @"请输入店铺名称";
    [self.view addSubview:self.searchView];
    MJWeakSelf;
    self.searchView.searchBlock = ^(NSString * _Nonnull search_key) {
        weakSelf.search_word = search_key;
        [weakSelf reuqestShopData];
    };
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 50, kScreenWidth-24, 15)];
    label.text = @"请选择需要切换的店铺";
    label.textColor = CFont3D;
    label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [self.view addSubview:label];
}

- (void)reuqestShopData {
    [[NetworkManager sharedClient] getWithURLString:@"shop/getShopUserShops" parameters:@{@"shop_id":[UserManager sharedUserManager].curUserInfo.shop_id,@"search_word":self.search_word?:@""} isNeedSVP:YES success:^(NSDictionary *messageDic) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

@end
