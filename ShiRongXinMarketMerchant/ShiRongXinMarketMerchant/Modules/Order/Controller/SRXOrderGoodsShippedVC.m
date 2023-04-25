//
//  SRXOrderGoodsShippedVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderGoodsShippedVC.h"
#import "SRXOrderGoodsShippedTableCell.h"
#import "SRXOrderGoodsShippedModel.h"


@interface SRXOrderGoodsShippedVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SRXOrderGoodsShippedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发货";
    self.view.backgroundColor = CViewBgColor;

    SRXOrderGoodsShippedModel *model = [SRXOrderGoodsShippedModel new];
    model.title = @"按订单发货";
    model.is_select = NO;
    SRXOrderGoodsShippedModel *model1 = [SRXOrderGoodsShippedModel new];
    model1.title = @"商品分包裹发货";
    model1.is_select = NO;
    self.datas = @[model, model1];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderGoodsShippedTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderGoodsShippedTableCell"];
    if (@available(iOS 15.0, *)) {
       self.tableView.sectionHeaderTopPadding = 0;
    }
}

- (IBAction)shippedBtnClick:(id)sender {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrderGoodsShippedTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderGoodsShippedTableCell" forIndexPath:indexPath];
    cell.model = self.datas[indexPath.section];
    [cell.headView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        for (SRXOrderGoodsShippedModel *m in self.datas) {
            m.is_select = NO;
        }
        SRXOrderGoodsShippedModel *model = self.datas[indexPath.section];
        model.is_select = YES;
        [self.tableView reloadData];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
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
