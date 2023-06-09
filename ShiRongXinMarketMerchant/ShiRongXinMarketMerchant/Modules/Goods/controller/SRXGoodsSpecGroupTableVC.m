//
//  SRXGoodsSpecGroupTableVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/7.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsSpecGroupTableVC.h"
#import "SRXGoodsSpecGroupCell.h"
#import "SRXGoodsSpecInfoEditVC.h"
#import "SRXGoodsSpecModel.h"
#import "NetworkManager+GoodUpdate.h"

@interface SRXGoodsSpecGroupTableVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SRXGoodsSpecGroupTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置参数";
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    [self addNavigationItemWithImageNames:@[@"back_black"] isLeft:YES target:self action:@selector(back1BtnClicked) tags:nil];
}

- (void)back1BtnClicked {
    if (self.datasBlock) {
        self.datasBlock(self.spec_list);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)lastBtnClick:(id)sender {
    [self back1BtnClicked];
}

- (IBAction)saveBtnClick:(id)sender {
    for (SRXGoodsSpecListItem *item in self.spec_list) {
        if(item.form.price.length==0 || item.form.score.length==0 || item.form.store_count.length==0){
            [SVProgressHUD showInfoWithStatus:@"参数不完整，无法保存"];
            return;
        }
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *attrArr = [NSMutableArray array];
    NSMutableArray *listArr = [NSMutableArray array];
    for (SRXGoodsSpecAttrItem *item in self.spec_attr) {
        [attrArr addObject:[item mj_keyValues]];
    }
    dic[@"spec_attr"] = attrArr.copy;
    for (SRXGoodsSpecListItem *item in self.spec_list) {
        [listArr addObject:[item mj_keyValues]];
    }
    dic[@"spec_list"] = listArr.copy;

    [NetworkManager saveGoodsSpecInfoWithGoods_id:self.goods_id parameters:dic.copy success:^(NSString *message) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功,商品已转至审核中列表"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            KPostNotification(KNotificationGoodsInfoChange, nil);
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    } failure:^(NSString *message) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.spec_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXGoodsSpecGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGoodsSpecGroupCell" forIndexPath:indexPath];
    SRXGoodsSpecListItem *item = self.spec_list[indexPath.row];
    if (indexPath.row==0) {
        [cell.bgView settingRadius:5 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    } else if (indexPath.row==4) {
        [cell.bgView settingRadius:5 corner:UIRectCornerBottomLeft|UIRectCornerBottomRight];
    } else {
        cell.bgView.layer.cornerRadius = 0;
    }
    cell.group_name.text = item.spec_key_name;
    if(item.form.price.length!=0 && item.form.score.length!=0 && item.form.store_count.length!=0){
        cell.hintLb.text = @"";
    }else {
        cell.hintLb.text = @"参数不完整";
    }
    MJWeakSelf;
    [cell.setBtn addCallBackAction:^(UIButton *button) {
        SRXGoodsSpecInfoEditVC *vc = [[SRXGoodsSpecInfoEditVC alloc] init];
        vc.item = item;
//        vc.saveBlock = ^(SRXGoodsSpecListItem * _Nonnull item) {
//            [weakSelf.tableView reloadData];
//        };
        vc.batchBlock = ^(SRXGoodsSpecFormBatch * _Nullable batch) {
            if (batch) {
                [weakSelf dealSpecData:batch];
            } else {
                [weakSelf.tableView reloadData];
            }
        };
        [weakSelf presentViewController:vc animated:YES completion:nil];
    }];
    return cell;
}
 

- (void)dealSpecData:(SRXGoodsSpecFormBatch *)batch {
    for (SRXGoodsSpecListItem *item in self.spec_list) {
        if (!item.form) {
            item.form = [SRXGoodsSpecForm new];
        }
        if (batch.is_price) {
            item.form.price = batch.value;
        } else if (batch.is_package_price) {
            item.form.package_price = batch.value;
        } else if (batch.is_market_price) {
            item.form.market_price = batch.value;
        } else if (batch.is_profit) {
            item.form.profit = batch.value;
        } else if (batch.is_score) {
            item.form.score = batch.value;
        } else if (batch.is_store_count) {
            item.form.store_count = batch.value;
        } else if (batch.is_weight) {
            item.form.weight = batch.value;
        } else if (batch.is_spec_img) {
            item.form.spec_img = batch.value;
        }
    }
    [self.tableView reloadData];
}

@end
