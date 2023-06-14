//
//  SRXMessageListVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMessageListVC.h"
#import "SRXMessageListTableCell.h"
#import "SRXMessageListShopView.h"
#import "NetworkManager+Message.h"
#import "SRXMsgChatVC.h"

@interface SRXMessageListVC ()
@property (nonatomic, strong) SRXMessageListShopView *shopView;
@property (nonatomic, strong) SRXChatShopNumItem *shop;
@end

@implementation SRXMessageListVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.rowHeight = 65;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXMessageListTableCell" bundle:nil] forCellReuseIdentifier:@"SRXMessageListTableCell"];
    self.tableView.mj_header.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestShopData) name:KNotificationMsgAllRead object:nil];
    [self requestShopData];
}

- (void)requestShopData {
    [NetworkManager getChatShopNumWithSuccess:^(NSArray *modelList) {
        if (modelList.count>0) {
            self.shop = modelList.firstObject;
            self.shop.is_select = YES;
            self.shopView.datas = modelList;
        }
    } failure:^(NSString *message) {
        
    }];
}

- (void)setShop:(SRXChatShopNumItem *)shop {
    _shop = shop;
    [self requestTableData];
}

- (void)requestTableData {
    [NetworkManager getChatListWithSearch_word:self.search_word chat_type:self.chat_type shop_id:self.shop.shop_id page:self.pageNo pageSize:self.pageSize success:^(NSArray *modelList) {
        [self requestTableDataSuccessWithArray:modelList];
    } failure:^(NSString *message) {
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXMessageListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMessageListTableCell" forIndexPath:indexPath];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.shopView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXMsgChatVC *vc = [[SRXMsgChatVC alloc] init];
    vc.item = self.dataSources[indexPath.row];
    vc.shop_id = self.shop.shop_id;
    [self.navigationController pushViewController:vc animated:YES];
}

// 允许长按菜单
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 允许每一个Action
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath*)indexPath withSender:(id)sender
{
    DLog(@"长按---%zd---",indexPath.row)
    return NO;
}

- (SRXMessageListShopView *)shopView {
    if(!_shopView) {
        _shopView = [[NSBundle mainBundle] loadNibNamed:@"SRXMessageListShopView" owner:nil options:nil].firstObject;
        MJWeakSelf;
        _shopView.selectBlock = ^(SRXChatShopNumItem * _Nonnull item) {
            weakSelf.shop = item;
        };
    }
    return _shopView;
}

@end
