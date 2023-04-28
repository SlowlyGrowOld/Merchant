//
//  SRXGoodsListTableVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsListTableVC.h"
#import "SRXGoodsListTableCell.h"
#import "SRXGoodsListEditTableCell.h"

@interface SRXGoodsListTableVC ()<UIScrollViewDelegate>

@end

@implementation SRXGoodsListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = 160;
    self.tableView.backgroundColor = CViewBgColor;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsListTableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsListTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsListEditTableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsListEditTableCell"];
    [self requestTableData];
}

- (void)requestTableData {
    [self requestTableDataSuccessWithArray:@[@"",@""]];
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    [self.tableView reloadData];
}

#pragma mark - tableview data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEdit) {
        SRXGoodsListEditTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGoodsListEditTableCell" forIndexPath:indexPath];
        return cell;
    } else {
        SRXGoodsListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGoodsListTableCell" forIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.isEdit?126:160;
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

#pragma mark - 联动
- (void)setCanScroll:(BOOL)canScroll {
    _canScroll = canScroll;
}

- (void)setIsPullDown:(BOOL)isPullDown {
    _isPullDown = isPullDown;
}

- (void)setScrollTop:(BOOL)scrollTop {
    _scrollTop = scrollTop;
    [self.tableView scrollToTop];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goods_leaveTop" object:nil];
}

 #pragma mark - UIScrollViewDelegate
 -(void)scrollViewDidScroll:(UIScrollView *)scrollView{
     
     NSLog(@"collectionView >>>>>>> 滚动 == %.2F",scrollView.contentOffset.y);
     if (!self.canScroll) {
         scrollView.contentOffset = CGPointZero;
         [[NSNotificationCenter defaultCenter] postNotificationName:@"goods_leaveTop" object:nil];
     }else if (scrollView.contentOffset.y > 0 ) {
         if (self.isPullDown && self.canScroll) {
             self.canScroll = NO;
             scrollView.contentOffset = CGPointZero;
             [[NSNotificationCenter defaultCenter] postNotificationName:@"goods_leaveTop" object:nil];//到顶通知父视图改变状态
         }else {
             self.canScroll = YES;
         }
     }else {
         if (!self.isPullDown && self.canScroll) {
             self.canScroll = NO;
             scrollView.contentOffset = CGPointZero;
             [[NSNotificationCenter defaultCenter] postNotificationName:@"goods_leaveTop" object:nil];//到顶通知父视图改变状态
         }
     }
}
@end
