//
//  SRXOrderListGoodsTableView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/23.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderListGoodsTableView.h"
#import "SRXOrdersListGoodsTableCell.h"

@interface SRXOrderListGoodsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SRXOrderListGoodsTableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.rowHeight = 80;
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"SRXOrdersListGoodsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrdersListGoodsTableCell"];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrdersListGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrdersListGoodsTableCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
