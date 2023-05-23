//
//  SRXOrderGoodsShippedVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderGoodsShippedVC.h"
#import "SRXOrderShippedSelfVC.h"
#import "SRXOrderShippedGroupVC.h"

@interface SRXOrderGoodsShippedVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@end

@implementation SRXOrderGoodsShippedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发货";
    self.view.backgroundColor = UIColor.whiteColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    self.tableView.rowHeight = 48;
    if (@available(iOS 15.0, *)) {
       self.tableView.sectionHeaderTopPadding = 0;
    }
    self.titles = self.is_distribute?@[@"商品分包裹发货"]:@[@"按订单发货",@"商品分包裹发货",@"用户线下自提"];
    self.images = self.is_distribute?@[@"order_ship_group"]:@[@"order_ship_all",@"order_ship_group",@"order_ship_self"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        cell.textLabel.textColor = CFont3D;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MJWeakSelf;
    
    if (indexPath.row == 2) {
        SRXOrderShippedSelfVC *vc = [[SRXOrderShippedSelfVC alloc] init];
        vc.order_id = self.order_id;
        vc.closeBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
        SRXOrderShippedGroupVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXOrderShippedGroupVC"];
        vc.order_id = self.order_id;
        vc.closeBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        vc.type = (indexPath.row==0 && !self.is_distribute)?SRXOrderShippedTypeAll:SRXOrderShippedTypeGoods;
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    }
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
