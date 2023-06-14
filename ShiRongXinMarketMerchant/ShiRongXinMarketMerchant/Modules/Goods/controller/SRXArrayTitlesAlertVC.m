//
//  SRXArrayTitlesAlertVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/5.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXArrayTitlesAlertVC.h"
#import "NetworkManager+GoodUpdate.h"
#import "NetworkManager+MsgSet.h"

@implementation SRXArrayTitlesModel

@end

@interface SRXArrayTitlesAlertVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation SRXArrayTitlesAlertVC

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isBgClose = YES;
    self.page = 1;
    [self.contentView settingRadius:20 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    self.tableView.rowHeight = 44;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.separatorColor = UIColorHex(0xD8D8D8);
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    [self requestData];
}

- (IBAction)cancleBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestData {
    [SVProgressHUD show];
    if (self.type == SRXArrayTitlesTypePlat) {
        self.titleLb.text = @"选择平台商品分类";
        [NetworkManager getPlatformClassifyListWithSearch_word:@"" page:self.page pageSize:20 success:^(NSArray *modelList) {
            for (SRXShop_PlatClassifyItem *item in modelList) {
                SRXArrayTitlesModel *model = [SRXArrayTitlesModel new];
                model.name = item.name;
                model._id = item._id;
                [self.dataSource addObject:model];
            }
            if (modelList.count<20) {
                self.tableView.mj_footer.hidden = YES;
            }
            self.tableViewConsH.constant = (44*self.dataSource.count>kScreenHeight - 250)?kScreenHeight - 250:44*self.dataSource.count;
            [self.tableView reloadData];
        } failure:^(NSString *message) {
            
        }];
    } else if (self.type == SRXArrayTitlesTypeShop) {
        self.titleLb.text = @"选择店铺商品分类";
        [NetworkManager getShopClassifyListWithSearch_word:@"" page:self.page pageSize:20 success:^(NSArray *modelList) {
            for (SRXShop_PlatClassifyItem *item in modelList) {
                SRXArrayTitlesModel *model = [SRXArrayTitlesModel new];
                model.name = item.name;
                model._id = item._id;
                [self.dataSource addObject:model];
            }
            if (modelList.count<20) {
                self.tableView.mj_footer.hidden = YES;
            }
            self.tableViewConsH.constant = (44*self.dataSource.count>kScreenHeight - 250)?kScreenHeight - 250:44*self.dataSource.count;
            [self.tableView reloadData];
        } failure:^(NSString *message) {
            
        }];
    } else if (self.type == SRXArrayTitlesTypeSupplier) {
        self.titleLb.text = @"选择供应商";
        [NetworkManager getSupplierListSuccess:^(NSArray *modelList) {
            self.tableView.mj_footer.hidden = YES;
            [self.dataSource removeAllObjects];
            for (SRXGoodsSupplierItem *item in modelList) {
                SRXArrayTitlesModel *model = [SRXArrayTitlesModel new];
                model.name = item.storage_name;
                model._id = item.storage_code;
                [self.dataSource addObject:model];
            }
            self.tableViewConsH.constant = (44*self.dataSource.count>kScreenHeight - 250)?kScreenHeight - 250:44*self.dataSource.count;
            [self.tableView reloadData];
        } failure:^(NSString *message) {
            
        }];
    } else if (self.type == SRXArrayTitlesTypeDelivery) {
        self.titleLb.text = @"选择物流公司";
        [NetworkManager getShippingTemplateListWithPage:self.page pageSize:20 success:^(NSArray *modelList) {
            for (SRXGoodsDeliveryItem *item in modelList) {
                SRXArrayTitlesModel *model = [SRXArrayTitlesModel new];
                model.name = item.name;
                model._id = item.delivery_id;
                [self.dataSource addObject:model];
            }
            if (modelList.count<20) {
                self.tableView.mj_footer.hidden = YES;
            }
            self.tableViewConsH.constant = (44*self.dataSource.count>kScreenHeight - 250)?kScreenHeight - 250:44*self.dataSource.count;
            [self.tableView reloadData];
        } failure:^(NSString *message) {
            
        }];
    }else if (self.type == SRXArrayTitlesTypeGroup) {
        self.titleLb.text = @"选择分组";
        [NetworkManager getQuickReplyGroupNameWithWithShop_id:@"" success:^(NSArray *modelList) {
            self.tableView.mj_footer.hidden = YES;
            [self.dataSource removeAllObjects];
            for (SRXMsgReplysGroupItem *item in modelList) {
                SRXArrayTitlesModel *model = [SRXArrayTitlesModel new];
                model.name = item.group_name;
                model._id = item.group_id;
                [self.dataSource addObject:model];
            }
            self.tableViewConsH.constant = (44*self.dataSource.count>kScreenHeight - 250)?kScreenHeight - 250:44*self.dataSource.count;
            [self.tableView reloadData];
        } failure:^(NSString *message) {
            
        }];
    }
}

- (void)requestMoreData {
    self.page++;
    [self requestData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
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
    SRXArrayTitlesModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectBlock) {
        self.selectBlock(self.dataSource[indexPath.row]);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
