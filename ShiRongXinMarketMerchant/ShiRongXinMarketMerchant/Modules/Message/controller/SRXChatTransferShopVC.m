//
//  SRXChatTransferShopVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/29.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatTransferShopVC.h"
#import "SRXChatTransferShopTableCell.h"


@interface SRXChatTransferShopVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;
@property (nonatomic, strong) NSArray *datas;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

@end

@implementation SRXChatTransferShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isBgClose = YES;
    self.tableView.rowHeight = 70;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXChatTransferShopTableCell" bundle:nil] forCellReuseIdentifier:@"SRXChatTransferShopTableCell"];
    [self requstData];
}

- (void)requstData {
    [SVProgressHUD show];
    [NetworkManager getChatTransferShopsWithSearch_word:self.searchTF.text success:^(NSArray *modelList) {
        self.datas = modelList;
        if (modelList.count*70>kScreenHeight-250) {
            self.tableViewConsH.constant = kScreenHeight-250;
        } else {
            self.tableViewConsH.constant = modelList.count*70;
        }
        [self.tableView reloadData];
    } failure:^(NSString *message) {
        
    }];
}

- (IBAction)searchBtnClick:(id)sender {
    [self requstData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    [self requstData];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXChatTransferShopTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXChatTransferShopTableCell" forIndexPath:indexPath];
    SRXChatShopNumItem *item = self.datas[indexPath.row];
    [cell.service_image sd_setImageWithURL:[NSURL URLWithString:item.shop_img]];
    cell.nameLb.text = item.shop_name;
    [cell.transferBtn addCallBackAction:^(UIButton *button) {
        if (self.serviceBlock) {
            [self dismissViewControllerAnimated:NO completion:^{
                self.serviceBlock(item);
            }];
        }
    }];
    return cell;
}

@end
