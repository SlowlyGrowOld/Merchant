//
//  SRXGoodsSpecUpdateVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsSpecUpdateVC.h"
#import "SRXGoodsSpecUpdateTableCell.h"
#import "NetworkManager+GoodUpdate.h"

@interface SRXGoodsSpecUpdateVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;

@end

@implementation SRXGoodsSpecUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.tableView.backgroundColor = CViewBgColor;
    [self.bgView settingRadius:10 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsSpecUpdateTableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsSpecUpdateTableCell"];
    
    CGFloat height = (self.isStore?self.datas.count*84:self.datas.count*128) + 5.01*(self.datas.count-1);
    if (height+100+BottomSafeHeight>kScreenHeight-100) {
        self.tableViewConsH.constant = kScreenHeight-200-BottomSafeHeight;
        self.tableView.scrollEnabled = YES;
    } else {
        self.tableViewConsH.constant = height;
        self.tableView.scrollEnabled = NO;
    }
//    [self requestSpecData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    kAppDelegate.mainTabBar.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    kAppDelegate.mainTabBar.tabBar.hidden = NO;
}

- (IBAction)saveBtnClick:(id)sender {
    NSMutableArray *goodsArray = [NSMutableArray array];
    for (int i=0; i<self.datas.count; i++) {
        SRXGoodsFastInfo *info = self.datas[i];
        SRXGoodsSpecUpdateTableCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        NSMutableDictionary *goodsM = [NSMutableDictionary dictionary];
        goodsM[@"spec_id"] = info.spec_id;
        if (self.isStore) {
            goodsM[@"store_count"] = cell.integralTF.text;
        } else {
            goodsM[@"price"] = cell.priceTF.text;
            goodsM[@"score"] = cell.integralTF.text;
        }
        
        [goodsArray addObject:goodsM];
    }
    if (self.isStore) {
        [NetworkManager changeGoodsStoreInfoWithGoods_id:self.goods_id spec:goodsArray success:^(NSString *message) {
            [SVProgressHUD showSuccessWithStatus:message];
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSString *message) {
            
        }];
    } else {
        [NetworkManager changeGoodsFateInfoWithGoods_id:self.goods_id spec:goodsArray success:^(NSString *message) {
            if (message.length==0) {
                [SVProgressHUD showSuccessWithStatus:message];
            }
//            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSString *message) {
            
        }];
    }
}

- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.allObjects.lastObject;
    BOOL isResult = [touch.view isDescendantOfView:self.bgView];
    if (!isResult) {[self dismissViewControllerAnimated:NO completion:nil];}
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self setTableViewHeight];
    [self.tableView reloadData];
}

- (void)setTableViewHeight {
    CGFloat height = (self.isStore?self.datas.count*84:self.datas.count*128) + 5.01*(self.datas.count-1);
    if (height+100+BottomSafeHeight>kScreenHeight-100) {
        self.tableViewConsH.constant = kScreenHeight-200-BottomSafeHeight;
        self.tableView.scrollEnabled = YES;
    } else {
        self.tableViewConsH.constant = height;
        self.tableView.scrollEnabled = NO;
    }
}

#pragma mark - tableview data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXGoodsSpecUpdateTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGoodsSpecUpdateTableCell" forIndexPath:indexPath];
    SRXGoodsFastInfo *info = self.datas[indexPath.section];
    cell.titleLb.text = [NSString stringWithFormat:@"规格%zd：%@",indexPath.section,info.key_name];
    cell.priceTF.superview.hidden = self.isStore;
    if (self.isStore) {
        cell.integral.text = @"库存";
        cell.integralTF.text = info.store_count;
    } else {
        cell.integral.text = @"积分抵扣";
        cell.priceTF.text = [NSString stringWithNumber:@(info.price) formatter:@"###.##"];
        cell.integralTF.text = info.score;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.isStore?84:128;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
@end
