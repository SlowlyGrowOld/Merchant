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
#import "SRXGoodsListNewTableCell.h"
#import "NetworkManager+Goods.h"
#import "SRXGoodsDetailsVC.h"

@interface SRXGoodsListTableVC ()<UIScrollViewDelegate>

@end

@implementation SRXGoodsListTableVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = CViewBgColor;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsListTableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsListTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsListNewTableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsListNewTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsListEditTableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsListEditTableCell"];
    [self requestTableData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goodsInfoChange:) name:KNotificationGoodsInfoChange object:nil];
}

- (void)goodsInfoChange:(NSNotification *)noti {
    [self.tableView.mj_header beginRefreshing];
}

- (void)requestTableData {
    [NetworkManager getGoodsListWithDic:[self.parameters mj_keyValues] goods_status:self.goods_status search_word:self.search_word page:self.pageNo pageSize:self.pageSize success:^(NSArray *modelList) {
        [self requestTableDataSuccessWithArray:modelList];
        [self notificationEditBottomData];
    } failure:^(NSString *message) {
        
    }];
}

- (void)setSearch_word:(NSString *)search_word {
    _search_word = search_word;
    [self.tableView.mj_header beginRefreshing];
}

- (void)setParameters:(SRXGoodsListParameter *)parameters {
    _parameters = parameters;
    [self.tableView.mj_header beginRefreshing];
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    if (!isEdit) {
        for (SRXGoodsListModel *model in self.dataSources) {
            model.is_select = NO;
        }
    }
    [self.tableView reloadData];
    [self notificationEditBottomData];
}

- (void)setIsAllEdit:(BOOL)isAllEdit {
    _isAllEdit = isAllEdit;
    for (SRXGoodsListModel *model in self.dataSources) {
        model.is_select = isAllEdit;
    }
    [self.tableView reloadData];
    [self notificationEditBottomData];
}

- (void)notificationEditBottomData {
    NSInteger select_num = 0;
    NSMutableArray *array = [NSMutableArray array];
    for (SRXGoodsListModel *model in self.dataSources) {
        if (model.is_select) {
            select_num ++;
            [array addObject:model.goods_id];
        }
    }
    NSString *isAll = self.dataSources.count == select_num?@"1":@"0";
    NSString *good_id = [array componentsJoinedByString:@","];
    KPostNotificationInfo(@"KNotificationGoodsListBatchStateChange", nil, (@{@"select_num":@(select_num).stringValue,@"isAll":isAll,@"good_id":good_id}));
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
        cell.model = self.dataSources[indexPath.section];
        return cell;
    } else {
        if (self.goods_status.intValue == 1) {
            SRXGoodsListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGoodsListTableCell" forIndexPath:indexPath];
            cell.model = self.dataSources[indexPath.section];
            cell.goods_status = self.goods_status;
            return cell;
        } else {
            SRXGoodsListNewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGoodsListNewTableCell" forIndexPath:indexPath];
            cell.model = self.dataSources[indexPath.section];
            cell.goods_status = self.goods_status;
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEdit) {
        SRXGoodsListModel *model = self.dataSources[indexPath.section];
        model.is_select = !model.is_select;
        [self.tableView reloadData];
        [self notificationEditBottomData];
    }else {
        SRXGoodsListModel *model = self.dataSources[indexPath.section];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
        SRXGoodsDetailsVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsDetailsVC"];
        vc.goods_id = model.goods_id;
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.isEdit?126:(self.goods_status.intValue==1?160:UITableViewAutomaticDimension);
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
