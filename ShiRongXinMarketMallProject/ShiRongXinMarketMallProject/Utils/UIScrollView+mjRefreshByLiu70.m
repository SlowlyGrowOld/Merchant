//
//  UIScrollView+mjRefreshByLiu70.m
//
//  Created by Liu70 & WZZ on 2018/4/9.
//  Copyright © 2018年 Liu70 & WZZ All rights reserved.
//

#import "UIScrollView+mjRefreshByLiu70.h"

@implementation UIScrollView (mjRefreshByLiu70)

#pragma mark - 设置使自己支持上下拉刷新
- (void)setRefreshEnable {
    [self initRefreshData];
    [self setMJHeaderFooter];
}

- (void)initRefreshData {
    self.refreshFirstPage = 1;
    self.refreshDataArray = [NSMutableArray array];
    self.refreshPageCount = 5;
}

- (void)setMJHeaderFooter {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self handleMJHeaderLogic];
    }];
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self handleMJFooterLogic];
    }];
}

- (void)handleMJHeaderLogic {
    self.refreshPage = self.refreshFirstPage;
    [self.refreshDelegate scrollView:self didBeginRefresh:[self refreshData] isHeaderRefreshing:YES];
}

- (void)handleMJFooterLogic {
    self.refreshPage += 1;
    [self.refreshDelegate scrollView:self didBeginRefresh:[self refreshData] isHeaderRefreshing:NO];
}

#pragma mark - more methods
- (void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (BOOL)isNoMoreData:(NSMutableArray*)newDataArray {
    return ((self.refreshDataArray.count % self.refreshPageCount != 0) || (newDataArray.count <= 0));
}

#pragma mark - 核心bolck
- (UIScrollView * (^)(NSMutableArray *))refreshData {
    __weak typeof(self) weakSelf = self;
    UIScrollView * (^block)(NSMutableArray *) = ^(NSMutableArray *newDataArray) {
        if (!newDataArray) {
            weakSelf.refreshPage -= 1;
            [weakSelf endRefresh];
            return weakSelf;
        }
        if (weakSelf.mj_header.isRefreshing) weakSelf.refreshDataArray = [NSMutableArray array];
        weakSelf.refreshDataArray = (NSMutableArray*)[weakSelf.refreshDataArray arrayByAddingObjectsFromArray:newDataArray];
        [weakSelf performSelector:@selector(reloadData)];
        [weakSelf endRefresh];
        if ([weakSelf isNoMoreData:newDataArray]) [weakSelf.mj_footer endRefreshingWithNoMoreData];
        return weakSelf;
    };
    return block;
}

#pragma mark - 手动定义属性
static char refreshDataArrayKey, refreshPageKey, refreshFirstPageKey, refreshPageCountKey, refreshDelegateKey;

//refreshDataArray
- (void)setRefreshDataArray:(NSMutableArray *)refreshDataArray {
    objc_setAssociatedObject(self, &refreshDataArrayKey, refreshDataArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)refreshDataArray {
    return objc_getAssociatedObject(self, &refreshDataArrayKey);
}

//refreshPage
- (void)setRefreshPage:(NSInteger)refreshPage {
    objc_setAssociatedObject(self, &refreshPageKey, @(refreshPage), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)refreshPage {
    return [objc_getAssociatedObject(self, &refreshPageKey) integerValue];
}

//refreshFirstPage
- (void)setRefreshFirstPage:(NSInteger)refreshFirstPage {
    objc_setAssociatedObject(self, &refreshFirstPageKey, @(refreshFirstPage), OBJC_ASSOCIATION_ASSIGN);
    self.refreshPage = refreshFirstPage - 1;
}

- (NSInteger)refreshFirstPage {
    return [objc_getAssociatedObject(self, &refreshFirstPageKey) integerValue];
}

//refreshPageCount
- (void)setRefreshPageCount:(NSInteger)refreshPageCount {
    objc_setAssociatedObject(self, &refreshPageCountKey, @(refreshPageCount), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)refreshPageCount {
    return [objc_getAssociatedObject(self, &refreshPageCountKey) integerValue];
}

//refreshDelegate
- (void)setRefreshDelegate:(id<UIScrollViewRefreshDelegate>)refreshDelegate {
    objc_setAssociatedObject(self, &refreshDelegateKey, refreshDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<UIScrollViewRefreshDelegate>)refreshDelegate {
    return objc_getAssociatedObject(self, &refreshDelegateKey);
}

#pragma mark - 链式编程
- (UIScrollView * (^)(id))fp_enableRefreshAndSetRefreshDelegate {
    UIScrollView * (^block)(id) = ^(id refreshDelegate) {
        [self setRefreshEnable];
        self.refreshDelegate = refreshDelegate;
        return self;
    };
    return block;
}

- (UIScrollView * (^)(NSInteger))fp_refreshPageCount {
    UIScrollView * (^block)(NSInteger) = ^(NSInteger count) {
        self.refreshPageCount = count;
        return self;
    };
    return block;
}

#pragma mark - debug
- (void)reloadData {
    NSLog(@"\n--------------------\n（╯‵□′）╯︵┻━┻\n【错误！】：UIScrollView+mjRefreshByLiu70 reloadData");
//    exit(0);
}





@end
