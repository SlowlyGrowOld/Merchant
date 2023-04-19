//
//  UIScrollView+mjRefreshByLiu70.h
//
//  Created by Liu70 & WZZ on 2018/4/9.
//  Copyright © 2018年 Liu70 & WZZ All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@protocol UIScrollViewRefreshDelegate <NSObject>

- (void)scrollView:(UIScrollView*)scrollView didBeginRefresh:(UIScrollView * (^)(NSMutableArray *))refreshData isHeaderRefreshing:(BOOL)isHeaderRefreshing;

@end

@interface UIScrollView (mjRefreshByLiu70)

@property (nonatomic, strong) NSMutableArray* refreshDataArray; //自动数据源
@property (nonatomic, assign) NSInteger refreshPage; //自动页码

@property (nonatomic, assign) NSInteger refreshFirstPage; //设置从哪一页开始加载 默认1
@property (nonatomic, assign) NSInteger refreshPageCount; //一页几条 默认5

@property (nonatomic, weak) id<UIScrollViewRefreshDelegate> refreshDelegate;

- (void)setRefreshEnable;


- (UIScrollView * (^)(id))fp_enableRefreshAndSetRefreshDelegate;
- (UIScrollView * (^)(NSInteger))fp_refreshPageCount;


@end
