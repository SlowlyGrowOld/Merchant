//
//  SRXChatQuickReplyTableView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/16.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatQuickReplyTableView.h"


@interface SRXChatQuickReplyTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SRXChatQuickReplyTableView

// 从xib/sb加载调用的方法. mark byKing
-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self initWithTableView];
    }
    return self;
}

- (void)initWithTableView {
    self.delegate = self;
    self.dataSource = self;
    self.rowHeight = 36;
    self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    SRXMsgReplysItem *item = self.datas[indexPath.row];
    cell.textLabel.text = item.reply_content;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectBlock) {
        self.selectBlock(self.datas[indexPath.row]);
    }
}

@end
