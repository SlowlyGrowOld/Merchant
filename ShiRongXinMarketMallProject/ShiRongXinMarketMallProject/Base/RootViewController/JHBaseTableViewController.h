//
//  JHBaseTableViewController.h
//  Yacht
//
//  Created by Jonphy on 2018/11/9.
//  Copyright © 2018 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface JHBaseTableViewController : RootViewController <UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, readonly, weak) UITableView *tableView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, assign) NSUInteger pageNo;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) BOOL loadMore;


- (void)setMj_header;
- (void)setMj_footer;
- (void)requestTableData;
- (void)reloadData;
- (void)requestTableDataSuccessWithArray:(NSArray *)modelList;
- (void)requestTableDataFailed;

@end

NS_ASSUME_NONNULL_END
