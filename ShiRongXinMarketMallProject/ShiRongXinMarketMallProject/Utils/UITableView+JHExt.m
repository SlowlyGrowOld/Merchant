//
//  UITableView+JHExt.m
//  Yacht
//
//  Created by Robin on 2019/8/27.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "UITableView+JHExt.h"

@implementation UITableView (JHExt)

- (void)updateHeaderFooterHeight {
    [self updateHeaderHeight];
    [self updateFooterHeight];
}

- (void)updateHeaderHeight {
    UIView *header = self.tableHeaderView;
    CGRect frame = header.frame;
    frame.size.height = [self.tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    header.frame = frame;
    self.tableHeaderView = header;
}

- (void)updateFooterHeight {
    UIView *footer = self.tableFooterView;
    CGRect frame = footer.frame;
    frame.size.height = [self.tableFooterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    footer.frame = frame;
    self.tableFooterView = footer;
}

@end
