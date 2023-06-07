//
//  SRXGoodsSpecSetTableVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/26.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsSpecSetTableVC.h"
#import "SRXTextFieldAlertVC.h"
#import "NetworkManager+GoodUpdate.h"
#import "SRXGoodsSpecAddTableCell.h"
#import "SRXGoodsSpecAdd1TableCell.h"
#import "SRXGoodsSpecTableCell.h"
#import "SRXGoodsSpecInfoEditVC.h"

@interface SRXGoodsSpecSetTableVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (nonatomic, strong) SRXGoodsSpecListData *datas;

@property (nonatomic, strong) SRXGoodsSpecListItem *editItem;
@end

@implementation SRXGoodsSpecSetTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置规格";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsSpecAddTableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsSpecAddTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsSpecTableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsSpecTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsSpecAdd1TableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsSpecAdd1TableCell"];
    [self requestData];
}

- (void)requestData {
    [NetworkManager getGoodsSpecListWithGoods_id:self.goods_id success:^(SRXGoodsSpecListData * _Nonnull data) {
        self.datas = data;
        self.saveBtn.superview.hidden = data.spec_attr.count==0?YES:NO;
        [self.tableView reloadData];
    } failure:^(NSString *message) {
        
    }];
}

- (void)addSpecKeyWithKey:(NSString *)key {
    [NetworkManager addGoodsSpecKeyWithGoods_id:self.goods_id spec_name:key success:^(NSString *message) {
        [self requestData];
    } failure:^(NSString *message) {
        
    }];
}

- (IBAction)saveBtnClick:(id)sender {
    
}

- (IBAction)editBtnClick:(id)sender {
    if (self.editItem) {
        SRXGoodsSpecInfoEditVC *vc = [[SRXGoodsSpecInfoEditVC alloc] init];
        vc.item = self.editItem;
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        [SVProgressHUD showInfoWithStatus:@"未选中规格"];
    }
}

- (void)configSpec_sku_id {
    NSMutableArray *mArr = [NSMutableArray array];
    for (SRXGoodsSpecAttrItem *item in self.datas.spec_attr) {
        for (SRXGoodsSpecItemsItem *i in item.spec_items) {
            if (i.is_select) {
                [mArr addObject:@(i.item_id).stringValue];
            }
        }
    }
    if(mArr.count == self.datas.spec_attr.count){
        NSString *ID = [mArr componentsJoinedByString:@"_"];
        for (SRXGoodsSpecListItem *i in self.datas.spec_list) {
            if ([i.spec_sku_id isEqualToString:ID]) {
                self.editItem = i;
                self.editBtn.enabled = YES;
                self.editBtn.backgroundColor = UIColorHex(0x00C9B6);
                return;
            }
        }
    }
    self.editBtn.backgroundColor = UIColorHex(0xD8D8D8);
    self.editBtn.enabled = NO;
    self.editItem = nil;
}

#pragma mark - UITableViewDelegate|DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.spec_attr.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.datas.spec_attr.count == 0) {
        SRXGoodsSpecAddTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGoodsSpecAddTableCell" forIndexPath:indexPath];
        return cell;
    } else {
        if (indexPath.section == self.datas.spec_attr.count) {
            SRXGoodsSpecAdd1TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGoodsSpecAdd1TableCell" forIndexPath:indexPath];
            return cell;
        } else {
            SRXGoodsSpecTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGoodsSpecTableCell" forIndexPath:indexPath];
            cell.item = self.datas.spec_attr[indexPath.section];
            MJWeakSelf;
            cell.refreshBlock = ^{
                [weakSelf.tableView reloadData];
            };
            cell.selectBlock = ^{
                [weakSelf configSpec_sku_id];
            };
            cell.deleteBlock = ^{
                weakSelf.editBtn.backgroundColor = UIColorHex(0xD8D8D8);
                weakSelf.editBtn.enabled = NO;
                [weakSelf requestData];
            };
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.datas.spec_attr.count) {
        SRXTextFieldAlertVC *vc = [[SRXTextFieldAlertVC alloc] init];
        vc.placeholder = @"请输入规格名";
        MJWeakSelf;
        vc.block = ^(NSString * _Nonnull nickname) {
            [weakSelf addSpecKeyWithKey:nickname];
        };
        [[UIViewController jk_currentViewController] presentViewController:vc animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
@end
