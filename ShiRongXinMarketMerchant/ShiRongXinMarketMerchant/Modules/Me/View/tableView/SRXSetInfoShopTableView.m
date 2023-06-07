//
//  SRXSetInfoShopTableView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXSetInfoShopTableView.h"
#import "SRXSetInfoShopTableCell.h"
#import "SRXMeInfo.h"

@interface SRXSetInfoShopTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SRXSetInfoShopTableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.rowHeight = 50;
    self.delegate = self;
    self.dataSource = self;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"SRXSetInfoShopTableCell" bundle:nil] forCellReuseIdentifier:@"SRXSetInfoShopTableCell"];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXSetInfoShopTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXSetInfoShopTableCell" forIndexPath:indexPath];
    SRXMeShopItem *item = self.datas[indexPath.row];
    [cell.shop_image sd_setImageWithURL:[NSURL URLWithString:item.shop_img]];
    cell.shop_name.text = item.shop_name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
