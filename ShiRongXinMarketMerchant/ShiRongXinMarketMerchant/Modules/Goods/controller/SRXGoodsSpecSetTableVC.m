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
#import "SRXGoodsEditQuitAlertVC.h"
#import "SRXGoodsSpecGroupTableVC.h"

@interface SRXGoodsSpecSetTableVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *quitBtn;
@property (nonatomic, strong) SRXGoodsSpecListData *datas;

@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong) NSArray *nextDatas;
@end

@implementation SRXGoodsSpecSetTableVC

- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog(@"%@",self.listArr);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置规格";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsSpecAddTableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsSpecAddTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsSpecTableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsSpecTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsSpecAdd1TableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsSpecAdd1TableCell"];
    [self requestData];
    [self addNavigationItemWithImageNames:@[@"back_black"] isLeft:YES target:self action:@selector(back1BtnClicked) tags:nil];
}

- (void)back1BtnClicked {
    SRXGoodsEditQuitAlertVC *vc = [SRXGoodsEditQuitAlertVC new];
    vc.alert_title = @"要退出规格编辑吗？";
    vc.alert_desc = @"退出编辑将不会保留已设置好内容";
    MJWeakSelf;
    vc.quitBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
}

- (void)requestData {
    [NetworkManager getGoodsSpecListWithGoods_id:self.goods_id success:^(SRXGoodsSpecListData * _Nonnull data) {
        self.datas = data;
        self.nextBtn.hidden = data.spec_attr.count==0?YES:NO;
        if (data.spec_attr.count == 0) {
            self.datas.spec_attr = @[];
        }
        [self.tableView reloadData];
    } failure:^(NSString *message) {
        
    }];
}

- (void)addSpecKeyWithKey:(NSString *)key {
    for (SRXGoodsSpecAttrItem *m in self.datas.spec_attr) {
        if ([m.group_name isEqualToString:key]) {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"规格\"%@\"已存在",key]];
            return;
        }
    }
    [NetworkManager addGoodsSpecKeyWithGoods_id:self.goods_id spec_name:key success:^(NSString *message) {
        self.nextDatas = nil;
        NSMutableArray *mArr = [NSMutableArray array];
        [mArr addObjectsFromArray:self.datas.spec_attr];
        SRXGoodsSpecAttrItem *item = [SRXGoodsSpecAttrItem new];
        item.group_id = message;
        item.group_name = key;
        item.spec_items = @[];
        [mArr addObject:item];
        self.datas.spec_attr = mArr.copy;
        [self isOpenNextBtnEnable];
        [self.tableView reloadData];
    } failure:^(NSString *message) {

    }];
}

- (IBAction)nextBtnClick:(id)sender {
    for (SRXGoodsSpecAttrItem *m in self.datas.spec_attr) {
        if (m.spec_items.count==0) {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"规格\"%@\"请添加规格值",m.group_name]];
            return;
        }
    }
    [self.listArr removeAllObjects];
    [self assembleDataWithI:0 ids:@[].mutableCopy specs:@[].mutableCopy models:self.listArr];
    
    if (self.nextDatas.count>0) {
        for (SRXGoodsSpecListItem *next in self.nextDatas) {
            for (SRXGoodsSpecListItem *item in self.listArr) {
                if ([item.spec_sku_id isEqualToString:next.spec_sku_id]) {
                    item.form = next.form;
                }
            }
        }
    } else if (self.datas.spec_list.count>0){
        for (SRXGoodsSpecListItem *list in self.self.datas.spec_list) {
            for (SRXGoodsSpecListItem *item in self.listArr) {
                if ([item.spec_sku_id isEqualToString:list.spec_sku_id]) {
                    item.form = list.form;
                }
            }
        }
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
    SRXGoodsSpecGroupTableVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsSpecGroupTableVC"];
    vc.goods_id = self.goods_id;
    vc.spec_attr = self.datas.spec_attr;
    vc.spec_list = self.listArr.copy;
    MJWeakSelf;
    vc.datasBlock = ^(NSArray * _Nonnull datas) {
        weakSelf.nextDatas = datas;
    };
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (void)assembleDataWithI:(NSInteger)i ids:(NSMutableArray *)ids specs:(NSMutableArray *)spec models:(NSMutableArray *)models{
    if (self.datas.spec_attr.count>i) {
        SRXGoodsSpecAttrItem *m = self.datas.spec_attr[i];
        i++;
        for (SRXGoodsSpecItemsItem *n in m.spec_items) {
            NSMutableArray *idsArr = [NSMutableArray arrayWithArray:ids];
            NSMutableArray *specsArr = [NSMutableArray arrayWithArray:spec];
            [idsArr addObject:n.item_id];
            [specsArr addObject:[NSString stringWithFormat:@"%@:%@",m.group_name,n.spec_value]];
            [self assembleDataWithI:i ids:idsArr specs:specsArr models:models];
        };
    }else {
        SRXGoodsSpecListItem *list = [SRXGoodsSpecListItem new];
        list.spec_sku_id = [ids componentsJoinedByString:@"_"];
        list.spec_key_name = [spec componentsJoinedByString:@","];
        [models addObject:list];
        DLog(@"%@,%@,%@",ids,spec,models);
    }
}

- (IBAction)quitBtnClick:(id)sender {
    [self back1BtnClicked];
}

- (void)isOpenNextBtnEnable {
    if (self.datas.spec_attr.count>0) {
        self.nextBtn.hidden = NO;
    }else {
        self.nextBtn.hidden = YES;
        return;
    }
    for (SRXGoodsSpecAttrItem *m in self.datas.spec_attr) {
        if (m.spec_items.count==0) {
            self.nextBtn.backgroundColor = UIColorHex(0xD8D8D8);
            return;
        }
    }
    self.nextBtn.backgroundColor = C43B8F6;
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
            cell.changeBlock = ^{
                [weakSelf isOpenNextBtnEnable];
            };
            cell.deleteBlock = ^{
                weakSelf.nextDatas = nil;
                NSMutableArray *mArr = [NSMutableArray array];
                [mArr addObjectsFromArray:self.datas.spec_attr];
                if (mArr.count>indexPath.section) {
                    [mArr removeObjectAtIndex:indexPath.section];
                }
                weakSelf.datas.spec_attr = mArr.copy;
                [weakSelf isOpenNextBtnEnable];
                [weakSelf.tableView reloadData];
            };
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.datas.spec_attr.count) {
        if (self.nextDatas.count>0) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"需要增加新的规格组吗？" message:@"如果增加新的规格组，已设置的规格参数将重置" preferredStyle:UIAlertControllerStyleAlert];
            [alertC addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertC addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self jumpTextFieldAlertVC];
            }]];
            [[UIViewController jk_currentNavigatonController] presentViewController:alertC animated:YES completion:nil];
        } else {
            [self jumpTextFieldAlertVC];
        }
    }
}

- (void)jumpTextFieldAlertVC{
    SRXTextFieldAlertVC *vc = [[SRXTextFieldAlertVC alloc] init];
    vc.placeholder = @"请输入规格名";
    MJWeakSelf;
    vc.block = ^(NSString * _Nonnull nickname) {
        [weakSelf addSpecKeyWithKey:nickname];
    };
    [[UIViewController jk_currentViewController] presentViewController:vc animated:YES completion:nil];
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
