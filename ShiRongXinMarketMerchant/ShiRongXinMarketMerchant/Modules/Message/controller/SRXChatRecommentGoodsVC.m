//
//  SRXMsgRecommentGoodsVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatRecommentGoodsVC.h"
#import "SRXChatRecommentGoodsTableCell.h"
#import "NetworkManager+Message.h"
#import "SRXSearchView.h"

@interface SRXChatRecommentGoodsVC ()
@property (nonatomic, strong) SRXSearchView *searchView;
@property (nonatomic, copy) NSString *search_word;
@end

@implementation SRXChatRecommentGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"推荐商品";
    self.tableView.rowHeight = 138;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXChatRecommentGoodsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXChatRecommentGoodsTableCell"];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
    }];
    self.searchView = [[SRXSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.searchView.placeholder_text = @"请输入商品名称";
    [self.view addSubview:self.searchView];
    MJWeakSelf;
    self.searchView.searchBlock = ^(NSString * _Nonnull search_key) {
        weakSelf.search_word = search_key;
        [weakSelf.tableView.mj_header beginRefreshing];
    };
}

- (void)requestTableData {
    [NetworkManager getRecommentChatGoodsWithSearch_word:self.search_word shop_id:self.shop_id page:self.pageNo pageSize:self.pageSize success:^(NSArray *modelList) {
        [self requestTableDataSuccessWithArray:modelList];
    } failure:^(NSString *message) {
        [self requestTableDataFailed];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXChatRecommentGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXChatRecommentGoodsTableCell" forIndexPath:indexPath];
    SRXMsgGoodsInfoItem *item = self.dataSources[indexPath.section];
    cell.item = item;
    MJWeakSelf;
    [cell.goodsBtn addCallBackAction:^(UIButton *button) {
        if (weakSelf.clickBlock) {
            weakSelf.clickBlock(item, YES);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [cell.couponBtn addCallBackAction:^(UIButton *button) {
        item.coupon.image = item.image;
        if (weakSelf.clickBlock) {
            weakSelf.clickBlock(item, NO);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
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
