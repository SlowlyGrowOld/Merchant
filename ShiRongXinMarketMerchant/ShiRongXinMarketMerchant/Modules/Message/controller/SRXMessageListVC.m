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
#import "SRXMsgChatSetAlertVC.h"

@interface SRXMessageListVC ()
@property (nonatomic, strong) SRXMessageListShopView *shopView;

@property (nonatomic, strong) NSArray *shopArray;
@end

@implementation SRXMessageListVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.noDataImg = @"msg_list_nodata";
    self.noDataStr = @"暂无更多消息...";
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.rowHeight = 65;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXMessageListTableCell" bundle:nil] forCellReuseIdentifier:@"SRXMessageListTableCell"];
    self.tableView.mj_header.hidden = YES;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestShopData) name:KNotificationMsgAllRead object:nil];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressRecognizer:)];
    [self.tableView addGestureRecognizer:longPress];
    
    [JHWebSocketManager shareInstance].receiveBlock = ^(NSDictionary * _Nonnull dic) {
        if ([dic[@"msg_type"] isEqualToString:@"login"]) {
        }else {
//            SRXMsgChatModel *message = [SRXMsgChatModel receiveMessageWithDic:dic];
            [self initRequestData];
        }
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestShopData];
}

- (void)requestShopData {
    [NetworkManager getChatShopNumWithSuccess:^(NSArray *modelList) {
        self.shopArray = modelList;
        if (modelList.count>0) {
            if (self.shop) {
                for (SRXChatShopNumItem *item in modelList) {
                    if ([item.shop_id isEqualToString:self.shop.shop_id]) {
                        item.is_select = YES;
                        self.shop = item;
                        self.shopView.datas = modelList;
                    }
                }
            } else {
                self.shop = modelList.firstObject;
                self.shop.is_select = YES;
                self.shopView.datas = modelList;
            }
        }else {
            [self initRequestData];
        }
    } failure:^(NSString *message) {
        
    }];
}

- (void)setShop:(SRXChatShopNumItem *)shop {
    _shop = shop;
    [self initRequestData];
}

- (void)setSearch_word:(NSString *)search_word {
    _search_word = search_word;
    [self initRequestData];
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
    return self.shopArray.count<2?0:54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXMsgChatVC *vc = [[SRXMsgChatVC alloc] init];
    vc.item = self.dataSources[indexPath.row];
    vc.shop_id = self.shop.shop_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initRequestData {
    [self removeNoDataImage];
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_footer resetNoMoreData];
    self.pageNo = 1;
    self.loadMore = NO;
    [self requestTableData];
}

//cell长按拖动排序
- (void)longPressRecognizer:(UILongPressGestureRecognizer *)longPress{
    //获取长按的点及cell
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    UIGestureRecognizerState state = longPress.state;
    if (state == UIGestureRecognizerStateEnded) {
        DLog(@"长按---%zd--%zd-",indexPath.row,state);
        SRXMsgChatSetAlertVC *vc = [SRXMsgChatSetAlertVC new];
        vc.shop_id = self.shop.shop_id;
        vc.model = self.dataSources[indexPath.row];
        MJWeakSelf;
        vc.refreshBlock = ^{
            [weakSelf initRequestData];
        };
        [self presentViewController:vc animated:YES completion:nil];
    }
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
