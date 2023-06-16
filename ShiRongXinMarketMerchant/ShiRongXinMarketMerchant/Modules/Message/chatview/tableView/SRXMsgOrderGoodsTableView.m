//
//  SRXMsgOrderGoodsTableView.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/26.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgOrderGoodsTableView.h"
#import "SRXMsgOrderGoodsTableCell.h"
#import "SRXMsgChatModel.h"

@interface SRXMsgOrderGoodsTableView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation SRXMsgOrderGoodsTableView

// 从xib/sb加载调用的方法. mark byKing
-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self initWithTableView];
    }
    return self;
}
- (void)initWithTableView{
    self.delegate = self;
    self.dataSource = self;
    self.rowHeight = 35;
    self.scrollEnabled = NO;
    self.backgroundColor = UIColor.whiteColor;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"SRXMsgOrderGoodsTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgOrderGoodsTableCell"];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXMsgGoodsInfoItem *item = self.datas[indexPath.section];
    SRXMsgOrderGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgOrderGoodsTableCell" forIndexPath:indexPath];
    [cell.good_image sd_setImageWithURL:[NSURL URLWithString:item.image]];
    cell.good_name.text = item.goods_name;
    cell.good_spec.text = item.spec_key_name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

@end
