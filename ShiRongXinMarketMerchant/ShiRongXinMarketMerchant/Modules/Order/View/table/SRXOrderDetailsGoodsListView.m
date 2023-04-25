//
//  SRXOrderDetailsGoodsTableView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderDetailsGoodsListView.h"
#import "SRXOrderDetailsGoodsListCell.h"

@interface SRXOrderDetailsGoodsListView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SRXOrderDetailsGoodsListView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.rowHeight = 115;
    self.delegate = self;
    self.dataSource = self;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"SRXOrderDetailsGoodsListCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderDetailsGoodsListCell"];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrderDetailsGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderDetailsGoodsListCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
