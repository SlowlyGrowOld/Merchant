//
//  SRXOrderShippedGoodsTableView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/23.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderShippedGoodsTableView.h"
#import "SRXOrderShippedGoodsTableCell.h"

@interface SRXOrderShippedGoodsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SRXOrderShippedGoodsTableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.rowHeight = 28;
    self.delegate = self;
    self.dataSource = self;
    self.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"SRXOrderShippedGoodsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderShippedGoodsTableCell"];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrderShippedGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderShippedGoodsTableCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
