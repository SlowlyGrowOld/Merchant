//
//  SRXShopSwitchTableViewController.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/19.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXShopSwitchTableViewController.h"
#import "SRXShopSwitchTableCell.h"

@interface SRXShopSwitchTableViewController ()
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SRXShopSwitchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"切换店铺";
    self.view.backgroundColor = CViewBgColor;
    self.tableView.rowHeight = 105;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXShopSwitchTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXShopSwitchTableCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
