//
//  SRXLogisticsCompanyAlertC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/23.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXLogisticsCompanyAlertC.h"

@interface SRXLogisticsCompanyAlertC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;

@end

@implementation SRXLogisticsCompanyAlertC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isBgClose = YES;
    [self.contentView settingRadius:20 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    self.tableView.rowHeight = 44;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.separatorColor = UIColorHex(0xD8D8D8);
    self.tableViewConsH.constant = (44*self.datas.count>kScreenHeight - 250)?kScreenHeight - 250:44*self.datas.count;
}

- (IBAction)cancleBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    if (self.datas.count>0) {
        [self.tableView reloadData];
    } else {
        [self requestExpressData];
    }
}

- (void)requestExpressData {
    [NetworkManager get_express_listWithSuccess:^(NSArray *modelList) {
        if (modelList.count>0) {
            self.datas = modelList;
            self.tableViewConsH.constant = (44*self.datas.count>kScreenHeight - 250)?kScreenHeight - 250:44*self.datas.count;
        }
    } failure:^(NSString *message) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        cell.textLabel.textColor = CFont3D;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SRXExpressListModel *model = self.datas[indexPath.row];
    cell.textLabel.text = model.express_name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectBlock) {
        self.selectBlock(self.datas[indexPath.row]);
        [self dismissViewControllerAnimated:YES completion:nil];
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
