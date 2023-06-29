//
//  SRXOrderDetailsVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderDetailsVC.h"
#import "SRXOrderDetailsBuyerTableCell.h"
#import "SRXOrderDetailsGoodsTableCell.h"
#import "SRXOrderDetailsInfoTableCell.h"
#import "SRXOrderDetailsPayInfoTableCell.h"

#import "SRXOrderLogisticsListVC.h"
#import "SRXOrderGoodsShippedVC.h"

#import "NetworkManager+Order.h"

@interface SRXOrderDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *one_title;
@property (weak, nonatomic) IBOutlet UIImageView *one_img;
@property (weak, nonatomic) IBOutlet UILabel *two_title;
@property (weak, nonatomic) IBOutlet UIImageView *two_img;
@property (weak, nonatomic) IBOutlet UILabel *three_title;
@property (weak, nonatomic) IBOutlet UIImageView *three_img;
@property (weak, nonatomic) IBOutlet UILabel *four_title;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *logisticsBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *erpBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConsH;
@property (nonatomic, strong) SRXOrderDetailsModel *details;
@end

@implementation SRXOrderDetailsVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    self.view.backgroundColor = CViewBgColor;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderDetailsBuyerTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderDetailsBuyerTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderDetailsGoodsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderDetailsGoodsTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderDetailsInfoTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderDetailsInfoTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderDetailsPayInfoTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderDetailsPayInfoTableCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderChange:) name:KNotificationOrderStatusChange object:nil];
    [self requestData];
}

- (void)orderChange:(NSNotification *)noti {
    [self requestData];
}

- (IBAction)logisticsBtnClick:(id)sender {
    SRXOrderLogisticsListVC *vc = [[SRXOrderLogisticsListVC alloc] init];
    vc.order_id = self.order_id;
    vc.shop_id = self.shop_id;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)sendGoodsBtnClick:(id)sender {
    UIStoryboard *order = [UIStoryboard storyboardWithName:@"Order" bundle:Nil];
    SRXOrderGoodsShippedVC *vc = [order instantiateViewControllerWithIdentifier:@"SRXOrderGoodsShippedVC"];
    vc.order_id = self.order_id;
    vc.shop_id = self.shop_id;
    for (SRXOrderDGoods_infoItem *item in self.details.goods_info) {
        if (item.order_delivery_id>0){
            vc.is_distribute = YES;
        }
    }
    vc.is_single = self.details.goods_count==1?YES:NO;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (void)requestData {
    [NetworkManager getOrderDetailsWithOrderID:self.order_id shop_id:self.shop_id success:^(SRXOrderDetailsModel * _Nonnull model) {
        self.details = model;
        [self setprogressStatus];
        [self.tableView reloadData];
    } failure:^(NSString *message) {
        
    }];
}

- (void)setprogressStatus {
    self.bottomViewConsH.constant = self.details.progress_num>0?66:0;
    self.erpBtn.hidden = self.details.progress_num==1?NO:YES;
    if (self.details.progress_num>=2) {
        self.logisticsBtn.hidden = NO;
    } else {
        self.logisticsBtn.hidden = YES;
        for (SRXOrderDGoods_infoItem *item in self.details.goods_info) {
            if (item.order_delivery_id>0){
                self.logisticsBtn.hidden = NO;
            }
        }
    }
    self.sendBtn.hidden = self.details.progress_num==1?NO:YES;
    switch (self.details.progress_num) {
        case 1:
        {
            _one_title.textColor = C43B8F6;
            _one_img.image = [UIImage imageNamed:@"order_d_progressed"];
        }
            break;
        case 2:
        {
            _one_title.textColor = C43B8F6;
            _one_img.image = [UIImage imageNamed:@"order_d_progressed"];
            _two_title.textColor = C43B8F6;
            _two_img.image = [UIImage imageNamed:@"order_d_progressed"];
        }
            break;
        case 3:
        {
            _one_title.textColor = C43B8F6;
            _one_img.image = [UIImage imageNamed:@"order_d_progressed"];
            _two_title.textColor = C43B8F6;
            _two_img.image = [UIImage imageNamed:@"order_d_progressed"];
            _three_title.textColor = C43B8F6;
            _three_img.image = [UIImage imageNamed:@"order_d_progressed"];
        }
            break;
        case 4:
        {
            _one_title.textColor = C43B8F6;
            _one_img.image = [UIImage imageNamed:@"order_d_progressed"];
            _two_title.textColor = C43B8F6;
            _two_img.image = [UIImage imageNamed:@"order_d_progressed"];
            _three_title.textColor = C43B8F6;
            _three_img.image = [UIImage imageNamed:@"order_d_progressed"];
            _four_title.textColor = C43B8F6;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - table data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        SRXOrderDetailsBuyerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderDetailsBuyerTableCell" forIndexPath:indexPath];
        cell.shop_id = self.shop_id;
        cell.info = self.details.user_info;
        return cell;
    } else if (indexPath.section==1) {
        SRXOrderDetailsGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderDetailsGoodsTableCell" forIndexPath:indexPath];
        cell.datas = self.details.goods_info;
        return cell;
    } else if (indexPath.section==2) {
        SRXOrderDetailsInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderDetailsInfoTableCell" forIndexPath:indexPath];
        cell.info = self.details.order_info;
        return cell;
    } else {
        SRXOrderDetailsPayInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderDetailsPayInfoTableCell" forIndexPath:indexPath];
        cell.info = self.details.pay_info;
        return cell;
    }
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
    return section==3?10:1;
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
