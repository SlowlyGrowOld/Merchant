//
//  SRXOrderRefundTableVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderRefundTableVC.h"
#import "SRXOrderRefundTableCell.h"
#import "SRXOrderRefundDetailsVC.h"
#import "NetworkManager+Order.h"

@interface SRXOrderRefundTableVC ()<UIScrollViewDelegate>

@end

@implementation SRXOrderRefundTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderRefundTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderRefundTableCell"];
    [self requestTableData];
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
    
    [NetworkManager getOrderAfterSaleListWithSearchWord:self.search_word page:self.pageNo page_size:self.pageSize success:^(NSArray *modelList) {
        [self requestTableDataSuccessWithArray:modelList];
    } failure:^(NSString *message) {
        
    }];
}

#pragma mark - tableview data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrderRefundTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderRefundTableCell" forIndexPath:indexPath];
    cell.model = self.dataSources[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
    SRXOrderRefundDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"SRXOrderRefundDetailsVC"];
    SRXOrderAfterSaleListModel *model = self.dataSources[indexPath.section];
    vc.order_return_id = model.order_return_id;
    [self.navigationController pushViewController:vc animated:YES];
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
