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

@interface SRXChatRecommentGoodsVC ()

@end

@implementation SRXChatRecommentGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"推荐商品";
    self.tableView.rowHeight = 138;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXChatRecommentGoodsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXChatRecommentGoodsTableCell"];
    [self.tableView.mj_header beginRefreshing];
}

- (void)requestTableData {
    [NetworkManager getRecommentChatGoodsWithSearch_word:@"" shop_id:self.shop_id page:self.pageNo pageSize:self.pageSize success:^(NSArray *modelList) {
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
            [SVProgressHUD showSuccessWithStatus:@"商品已发送成功"];
        }
    }];
    [cell.couponBtn addCallBackAction:^(UIButton *button) {
        item.coupon.image = item.image;
        if (weakSelf.clickBlock) {
            weakSelf.clickBlock(item, NO);
            [SVProgressHUD showSuccessWithStatus:@"优惠券已发送成功"];
        }
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
