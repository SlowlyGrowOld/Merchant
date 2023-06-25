//
//  SRXChatTagsListVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/13.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatTagsListVC.h"
#import "SRXChatTagsTableCell.h"

#import "NetworkManager+MsgSet.h"
#import "SRXChatTagsEditVC.h"

@interface SRXChatTagsListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SRXChatTagsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑标签";
    self.tableView.rowHeight = 60;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.separatorColor = CViewBgColor;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXChatTagsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXChatTagsTableCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [self addNavigationItemWithImageNames:@[@"back_black"] isLeft:YES target:self action:@selector(back1BtnClicked) tags:nil];
}

- (void)back1BtnClicked {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)requestData {
    [NetworkManager getShopLabelsWithShop_id:@"" user_id:@"" success:^(NSArray *modelList) {
        [self.tableView.mj_header endRefreshing];
        self.datas = modelList;
        [self.tableView reloadData];
    } failure:^(NSString *message) {
        
    }];
}

- (IBAction)deleteBtnClick:(id)sender {
    NSMutableArray *array = [NSMutableArray array];
    for (SRXMsgLabelsItem *item in self.datas) {
        if (item.is_chose){
            [array addObject:item.label_id];
        }
    }
    if (array.count==0) {
        return;
    }
    [SVProgressHUD show];
    [NetworkManager setShopLabelsWithType:@"3" label_name:@"" label_color_number:@"" label_id:[array componentsJoinedByString:@","] shop_id:@"" success:^(NSString *message) {
        [self.tableView.mj_header beginRefreshing];
    } failure:^(NSString *message) {
        
    }];
}

- (IBAction)addBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    SRXChatTagsEditVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXChatTagsEditVC"];
    MJWeakSelf;
    vc.refreshBlock = ^{
        [weakSelf requestData];
    };
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXChatTagsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXChatTagsTableCell" forIndexPath:indexPath];
    SRXMsgLabelsItem *item = self.datas[indexPath.row];
    cell.item = item;
    [cell.editBtn addCallBackAction:^(UIButton *button) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
        SRXChatTagsEditVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXChatTagsEditVC"];
        vc.item = item;
        MJWeakSelf;
        vc.refreshBlock = ^{
            [weakSelf requestData];
        };
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    }];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
