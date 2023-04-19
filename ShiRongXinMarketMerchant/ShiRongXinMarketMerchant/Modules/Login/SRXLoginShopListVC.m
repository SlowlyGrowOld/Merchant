//
//  SRXLoginShopListVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/14.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXLoginShopListVC.h"
#import "SRXLoginShopListTableCell.h"

@interface SRXLoginShopListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SRXLoginShopListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = YES;
    self.tableView.rowHeight = 110;
    
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXLoginShopListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXLoginShopListTableCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了");
    [AppHandyMethods switchWindowToMainScene];
}

@end
