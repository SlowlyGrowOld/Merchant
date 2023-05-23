//
//  SRXOrderLogisticsDetailsVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/25.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderLogisticsDetailsVC.h"
#import "SRXOrderLogisticsDetailsTableCell.h"

#import "NetworkManager+Order.h"

@interface SRXOrderLogisticsDetailsVC ()
@property (nonatomic, strong) SRXDeliveryDetailsData *details;
@end

@implementation SRXOrderLogisticsDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"物流详情";
    
    self.tableView.backgroundColor = CViewBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(12, 0, 10, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderLogisticsDetailsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderLogisticsDetailsTableCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [self requestData];
}

- (void)requestData {
    [NetworkManager getOrderGoodsDeliveryDetailsWithOrderID:self.order_id express_sn:self.express_sn order_type:self.order_type order_return_id:self.order_return_id success:^(SRXDeliveryDetailsData * _Nonnull details) {
        [self.tableView.mj_header endRefreshing];
        self.details = details;
        [self.tableView reloadData];
    } failure:^(NSString *message) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.details.traces._signed.count;
    } else if (section==1) {
        return self.details.traces.in_delivery.count;
    } else  if (section==2) {
        return self.details.traces.in_transit.count;
    } else{
        return self.details.traces.contract.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrderLogisticsDetailsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderLogisticsDetailsTableCell" forIndexPath:indexPath];
    cell.imgView.hidden = indexPath.row==0?NO:YES;
    cell.statusLb.hidden = indexPath.row==0?NO:YES;
    SRXDeliveryDetailsTracesItem *item;
    if (indexPath.section==0) {
        
    } else if (indexPath.section==1) {
        item = self.details.traces.in_delivery[indexPath.row];
    } else  if (indexPath.section==2) {
        item = self.details.traces.in_transit[indexPath.row];
    } else{
        item = self.details.traces.contract[indexPath.row];
    }
    cell.infoLb.text = item.AcceptStation;
    cell.hourLb.text = [self transformTimeWith:item.AcceptTime formatter:@"HH-mm"];
    cell.monthLb.text = [self transformTimeWith:item.AcceptTime formatter:@"MM-dd"];
    if (indexPath.section==0) {
        if (indexPath.row == 0) {
            cell.headLine.hidden = YES;
            cell.bottomLine.hidden = NO;
            [cell.bgView settingRadius:5 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    //        cell.bottomLine.backgroundColor = UIColor.whiteColor;
    //        [cell.bottomLine jk_drawLineOfDashByCAShapeLayerLineWidth:1 withLineSpacing:2 withLineColor:CFont99 withLineDirection:NO];
            
            cell.statusLb.text = @"已签收";
        }
    } else if (indexPath.section==1) {
        cell.headLine.hidden = NO;
        cell.bottomLine.hidden = NO;
        cell.bgView.layer.cornerRadius = 0;
    } else if (indexPath.section==2) {
        cell.headLine.hidden = NO;
        cell.bottomLine.hidden = NO;
        cell.bgView.layer.cornerRadius = 0;
    } else{
        cell.headLine.hidden = NO;
        cell.bottomLine.hidden = YES;
        [cell.bgView settingRadius:5 corner:UIRectCornerBottomLeft|UIRectCornerBottomRight];
    }
    return cell;
}

- (NSString *)transformTimeWith:(NSString *)timeStr formatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //需要设置为和字符串相同的格式
    [dateFormatter setDateFormat:formatter];
    NSDate *localDate = [dateFormatter dateFromString:timeStr];
    NSString *string = [dateFormatter stringFromDate:localDate];
    return string;
}

@end
