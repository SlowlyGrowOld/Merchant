//
//  SRXChatTransferServiceVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/16.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatTransferServiceVC.h"
#import "SRXChatTransferServiceTableCell.h"

@interface SRXChatTransferServiceVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SRXChatTransferServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isBgClose = YES;
    self.tableView.rowHeight = 70;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXChatTransferServiceTableCell" bundle:nil] forCellReuseIdentifier:@"SRXChatTransferServiceTableCell"];
    [self requstData];
}

- (void)requstData {
    [SVProgressHUD show];
    [NetworkManager getChatTransferListWithShop_id:self.shop_id success:^(NSArray *modelList) {
        self.datas = modelList;
        if (modelList.count*70>kScreenHeight-200) {
            self.tableViewConsH.constant = kScreenHeight-200;
        } else {
            self.tableViewConsH.constant = modelList.count*70;
        }
        [self.tableView reloadData];
        if (modelList.count==0) {
            [self dismissViewControllerAnimated:YES completion:^{
                [SVProgressHUD showInfoWithStatus:@"暂无客服"];
            }];
        }
    } failure:^(NSString *message) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXChatTransferServiceTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXChatTransferServiceTableCell" forIndexPath:indexPath];
    cell.service = self.datas[indexPath.row];
    [cell.transferBtn addCallBackAction:^(UIButton *button) {
        if (self.serviceBlock) {
            self.serviceBlock(self.datas[indexPath.row]);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    return cell;
}

@end
