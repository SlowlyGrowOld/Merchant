//
//  UITableView+JHExt.h
//  Yacht
//
//  Created by Robin on 2019/8/27.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (JHExt)

/**
 Update tableHeaderView and tableFooterView's height, in which subViews' vertical constraints changed
 */
- (void)updateHeaderFooterHeight;

/**
  Update tableHeaderView's height, in which subViews' vertical constraints changed
 */
- (void)updateHeaderHeight;

/**
  Update tableFooterView's height, in which subViews' vertical constraints changed
 */
- (void)updateFooterHeight;

@end

NS_ASSUME_NONNULL_END
