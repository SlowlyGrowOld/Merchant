//
//  SRXOrderShippedGroupVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/23.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderShippedGroupVC.h"
#import "SRXOrderShippedGoodsTableCell.h"
#import "SRXLogisticsCompanyAlertC.h"

@interface SRXOrderShippedGroupVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *companyView;
@property (weak, nonatomic) IBOutlet UITextField *express_name;
@property (weak, nonatomic) IBOutlet UITextField *express_sn;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) NSArray *express_datas;
@property (nonatomic, strong) NSArray *goods_datas;
@property (nonatomic, strong) SRXExpressListModel *express;
@end

@implementation SRXOrderShippedGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.type == SRXOrderShippedTypeGoods?@"商品分包裹发货":@"按订单发货";
    [self.companyView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        SRXLogisticsCompanyAlertC *vc = [[SRXLogisticsCompanyAlertC alloc] init];
        vc.datas = self.express_datas;
        vc.selectBlock = ^(SRXExpressListModel * _Nonnull model) {
            self.express = model;
            self.express_name.text = model.express_name;
        };
        [self presentViewController:vc animated:YES completion:nil];
    }];
    [self requestExpressData];
    self.tableView.rowHeight = 54;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.separatorColor = UIColorHex(0xD8D8D8);
    self.tableView.tableFooterView = self.bottomView;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderShippedGoodsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderShippedGoodsTableCell"];
    if (self.type == SRXOrderShippedTypeGoods) {
        [self requestGoodsData];
    }
}

- (void)requestExpressData {
    [NetworkManager get_express_listWithShop_id:self.shop_id success:^(NSArray *modelList) {
        self.express_datas = modelList;
    } failure:^(NSString *message) {
        
    }];
}

- (void)requestGoodsData {
    [NetworkManager getOrderDeliveryGoodsWithOrder_id:self.order_id shop_id:self.shop_id success:^(NSArray *modelList) {
        self.goods_datas = modelList;
        [self.tableView reloadData];
    } failure:^(NSString *message) {
    
    }];
}

- (IBAction)sendGoodsBtnClick:(id)sender {
    if (self.type == SRXOrderShippedTypeGoods) {
        NSMutableArray *mArr = [NSMutableArray array];
        for (SRXOrderGoodsItem *item in self.goods_datas) {
            if (item.isSelect) {
                [mArr addObject:item.order_goods_id];
            }
        }
        [NetworkManager sendOrderGoodsWithGoodsID:[mArr componentsJoinedByString:@","] shop_id:self.shop_id order_id:self.order_id express_sn:self.express_sn.text express_id:self.express.express_id success:^(NSString *message) {
            [SVProgressHUD showSuccessWithStatus:@"发货成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.closeBlock){self.closeBlock();}
                KPostNotificationInfo(KNotificationOrderStatusChange, nil, @"refresh");
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSString *message) {
            
        }];
    }else {
        [NetworkManager sendOrderGoodsWithOrderID:self.order_id shop_id:self.shop_id express_sn:self.express_sn.text express_id:self.express.express_id success:^(NSString *message) {
            [SVProgressHUD showSuccessWithStatus:@"发货成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.closeBlock){self.closeBlock();}
                KPostNotificationInfo(KNotificationOrderStatusChange, nil, @"refresh");
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSString *message) {
            
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goods_datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrderShippedGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderShippedGoodsTableCell" forIndexPath:indexPath];
    SRXOrderGoodsItem *item = self.goods_datas[indexPath.row];
    [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:item.image]];
    cell.goods_name.text = item.goods_name;
    cell.selectView.backgroundColor = item.isSelect?C43B8F6:UIColor.whiteColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrderGoodsItem *item = self.goods_datas[indexPath.row];
    item.isSelect = !item.isSelect;
    [self.tableView reloadData];
}

@end
