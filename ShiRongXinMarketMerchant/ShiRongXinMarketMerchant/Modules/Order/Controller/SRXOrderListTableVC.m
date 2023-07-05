//
//  SRXOrderListTableVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/20.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderListTableVC.h"
#import "SRXOrdersListTableCell.h"
#import "SRXOrderRefundTableCell.h"
#import "SRXOrderDetailsVC.h"
#import "SRXOrderRefundDetailsVC.h"
#import "NetworkManager+Order.h"

@interface SRXOrderListTableVC ()<UIScrollViewDelegate>

@end

@implementation SRXOrderListTableVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.noDataImg = @"order_no_data";
    self.noDataStr = @"暂无相关订单";
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrdersListTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrdersListTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderRefundTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderRefundTableCell"];
    [self requestTableData];
    if (self.type == SRXOrderListTypeNomal) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderChange:) name:KNotificationOrderStatusChange object:nil];
    }
}

- (void)orderChange:(NSNotification *)noti {
    NSDictionary *dic = noti.userInfo;
    if ([dic[@"info"] isKindOfClass:[SRXOrderListModel class]]) {
        SRXOrderListModel *model = dic[@"info"];
        for (int i=0; i<self.dataSources.count; i++) {
            SRXOrderListModel *m = self.dataSources[i];
            if ([m.order_id isEqualToString:model.order_id]) {
                [self.dataSources replaceObjectAtIndex:i withObject:model];
                [self.tableView reloadRow:0 inSection:i withRowAnimation:UITableViewRowAnimationNone];
                return;
            }
        }
    } else {
        NSString *string = dic[@"info"];
        if ([string isEqualToString:@"refresh"]) {
            [self.tableView.mj_header beginRefreshing];
        } else {
            
        }
    }
}

- (void)setCanScroll:(BOOL)canScroll {
    _canScroll = canScroll;
}

- (void)setIsPullDown:(BOOL)isPullDown {
    _isPullDown = isPullDown;
}

- (void)setScrollTop:(BOOL)scrollTop {
    _scrollTop = scrollTop;
    [self.tableView scrollToTop];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shop_home_leaveTop" object:nil];
}

 #pragma mark - UIScrollViewDelegate
 -(void)scrollViewDidScroll:(UIScrollView *)scrollView{
     
     NSLog(@"collectionView >>>>>>> 滚动 == %.2F",scrollView.contentOffset.y);
     if (!self.canScroll) {
         scrollView.contentOffset = CGPointZero;
         [[NSNotificationCenter defaultCenter] postNotificationName:@"shop_home_leaveTop" object:nil];
     }else if (scrollView.contentOffset.y > 0 ) {
         if (self.isPullDown && self.canScroll) {
             self.canScroll = NO;
             scrollView.contentOffset = CGPointZero;
             [[NSNotificationCenter defaultCenter] postNotificationName:@"shop_home_leaveTop" object:nil];//到顶通知父视图改变状态
         }else {
             self.canScroll = YES;
         }
     }else {
         if (!self.isPullDown && self.canScroll) {
             self.canScroll = NO;
             scrollView.contentOffset = CGPointZero;
             [[NSNotificationCenter defaultCenter] postNotificationName:@"shop_home_leaveTop" object:nil];//到顶通知父视图改变状态
         }
     }
}

- (void)requestTableData {
    if (self.type == SRXOrderListTypeNomal) {
        [NetworkManager getOrderListWithSearchWord:self.search_word order_type:self.order_type page:self.pageNo page_size:self.pageSize success:^(NSArray *modelList) {
            [self requestTableDataSuccessWithArray:modelList];
        } failure:^(NSString *message) {
            
        }];
    } else {
        [NetworkManager getOrderAfterSaleListWithSearchWord:self.search_word page:self.pageNo page_size:self.pageSize success:^(NSArray *modelList) {
            [self requestTableDataSuccessWithArray:modelList];
        } failure:^(NSString *message) {
            
        }];
    }
}

- (void)setSearch_word:(NSString *)search_word {
    _search_word = search_word;
    [self removeNoDataImage];
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_footer resetNoMoreData];
    self.pageNo = 1;
    self.loadMore = NO;
    [SVProgressHUD show];
    [self requestTableData];
}

#pragma mark - tableview data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == SRXOrderListTypeNomal) {
        SRXOrdersListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrdersListTableCell" forIndexPath:indexPath];
        cell.model = self.dataSources[indexPath.section];
        cell.order_type = self.order_type.integerValue;
        return cell;
    } else {
        SRXOrderRefundTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundTableCell" forIndexPath:indexPath];
        cell.model = self.dataSources[indexPath.section];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == SRXOrderListTypeNomal) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
        SRXOrderDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"SRXOrderDetailsVC"];
        SRXOrderListModel *model = self.dataSources[indexPath.section];
        vc.order_id = model.order_id;
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    } else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
        SRXOrderRefundDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"SRXOrderRefundDetailsVC"];
        SRXOrderAfterSaleListModel *model = self.dataSources[indexPath.section];
        vc.order_return_id = model.order_return_id;
        MJWeakSelf;
        vc.refreshBlock = ^{
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
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

@end
