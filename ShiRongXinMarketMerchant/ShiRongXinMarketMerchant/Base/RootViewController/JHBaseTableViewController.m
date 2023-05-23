//
//  JHBaseTableViewController.m
//  Yacht
//
//  Created by Jonphy on 2018/11/9.
//  Copyright © 2018 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "JHBaseTableViewController.h"
#import <Masonry.h>

@interface JHBaseTableViewController ()

@end

@implementation JHBaseTableViewController

static NSString *cellID = @"JHBaseTableViewCell";

#pragma mark - Life cycle
- (void)dealloc{
    
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

- (instancetype)init{
    
    if (self = [super init]) {
        
//        _pageNo = 1;
//        _pageSize = 20;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pageNo = 1;
    _pageSize = 20;
    _loadMore = NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = CViewBgColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.showsVerticalScrollIndicator = NO;
//
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.top.right.equalTo(self.view);
//        if (@available(iOS 11.0, *)) {
//            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//        } else {
            make.bottom.equalTo(self.view);
            // Fallback on earlier versions
//        }
    }];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
  
    [self setMj_header];
    [self setMj_footer];
    
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_footer resetNoMoreData];
//    [self.tableView.mj_header beginRefreshing];

    if (@available (iOS 11.0,*)) {
         _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
     }
    if (@available(iOS 15.0, *)) {
        [UITableView appearance].sectionHeaderTopPadding = 0;
    }
}

#pragma mark - Table view data source & TableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (NSMutableArray *)dataSources{
    
    if (_dataSources == nil) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

#pragma mark - private & public methods
- (void)setMj_header{
    
    MJWeakSelf
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf removeNoDataImage];
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf.tableView.mj_footer resetNoMoreData];
        weakSelf.pageNo = 1;
        weakSelf.loadMore = NO;
        [weakSelf requestTableData];
    }];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    self.tableView.mj_header = header;
}

- (void)setMj_footer{
    
    MJWeakSelf
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.pageNo ++;
        weakSelf.currentPage = weakSelf.pageNo;
        weakSelf.loadMore = YES;
        [weakSelf requestTableData];
    }];
    [footer setTitle:@"(^_^) 下面已经没有内容啦！" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    footer.stateLabel.font = [UIFont systemFontOfSize:14.0f];
//    footer.backgroundColor = JHViewBgColor;
    self.tableView.mj_footer = footer;
}

- (void)requestTableData{
    
    [self requestTableDataFailed];
}

- (void)requestTableDataSuccessWithArray:(NSArray *)modelList{
    
    if (!self.loadMore) {
        [self.dataSources removeAllObjects];
        [self.dataSources addObjectsFromArray:modelList];
        
        [self.tableView.mj_header endRefreshing];
        [self reloadData];
        self.tableView.mj_footer.hidden = modelList.count == 0?YES:NO;
        
    }else{
        [self.dataSources addObjectsFromArray:modelList];
        [self reloadData];
        [self.tableView.mj_footer endRefreshing];
    }
    
    if (modelList.count < _pageSize) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}


- (void)requestTableDataFailed{
    
    if (!self.loadMore) {
        [self.tableView.mj_header endRefreshing];
        if (self.dataSources.count != 0) {
            self.tableView.mj_footer.hidden = NO;
        }
        self.pageNo = _currentPage;
        [self reloadData];
        return;
    }
    self.pageNo --;
    [self.tableView.mj_footer endRefreshing];
}

- (void)reloadData{
    
    [self.tableView reloadData];
    if (self.dataSources.count == 0) {
        [self showNoDataImageToView:self.tableView];
    }else{
        [self removeNoDataImage];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
