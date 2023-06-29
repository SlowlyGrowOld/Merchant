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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXOrderLogisticsDetailsTableCell" bundle:nil] forCellReuseIdentifier:@"SRXOrderLogisticsDetailsTableCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [self requestData];
}

- (void)requestData {
    [NetworkManager getOrderGoodsDeliveryDetailsWithOrderID:self.order_id shop_id:self.shop_id express_sn:self.express_sn order_type:self.order_type order_return_id:self.order_return_id success:^(SRXDeliveryDetailsData * _Nonnull details) {
        [self.tableView.mj_header endRefreshing];
        self.details = details;
        [self.tableView reloadData];
        if (details.traces) {
            [self removeNoDataImage];
        } else {
            [self showNoDataImageToView:self.tableView];
        }
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
        item = self.details.traces._signed[indexPath.row];
    } else if (indexPath.section==1) {
        item = self.details.traces.in_delivery[indexPath.row];
    } else  if (indexPath.section==2) {
        item = self.details.traces.in_transit[indexPath.row];
    } else{
        item = self.details.traces.contract[indexPath.row];
    }
    cell.infoLb.text = item.AcceptStation;
    NSDate *date = [self stringToDate:item.AcceptTime withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.hourLb.text = [self dateToString:date withDateFormat:@"HH:mm"];
    cell.monthLb.text = [self dateToString:date withDateFormat:@"MM-dd"];
    cell.imgView.hidden = NO;
    cell.safeView.hidden = YES;
    if (indexPath.section==0) {
        if (indexPath.row == 0) {
            cell.headLine.hidden = YES;
            cell.bottomLine.hidden = NO;
            [cell.bgView settingRadius:5 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    //        cell.bottomLine.backgroundColor = UIColor.whiteColor;
    //        [cell.bottomLine jk_drawLineOfDashByCAShapeLayerLineWidth:1 withLineSpacing:2 withLineColor:CFont99 withLineDirection:NO];
            
            cell.statusLb.text = @"已签收";
        }
        if (self.details.traces._signed.count==1) {
            cell.imgView.image = [UIImage imageNamed:@"ship_signed"];
        } else {
            cell.imgView.image = [UIImage imageNamed:indexPath.row==0?@"ship_signed_user":@"ship_signed"];
        }
    } else if (indexPath.section==1) {
        cell.headLine.hidden = NO;
        cell.bottomLine.hidden = NO;
        cell.bgView.layer.cornerRadius = 0;
        if(indexPath.row == 0){cell.statusLb.text = @"派送中";}
        if (self.details.traces.in_delivery.count==1) {
            cell.imgView.image = [UIImage imageNamed:self.details.traces._signed.count==0?@"ship_deliverying":@"ship_deliveryed"];
        } else {
            if (indexPath.row==0) {
                cell.imgView.image = [UIImage imageNamed:self.details.traces._signed.count==0?@"ship_deliverying":@"ship_deliveryed"];
            } else {
                cell.imgView.hidden = YES;
            }
        }
    } else if (indexPath.section==2) {
        cell.headLine.hidden = NO;
        cell.bottomLine.hidden = NO;
        cell.bgView.layer.cornerRadius = 0;
        if(indexPath.row == 0){cell.statusLb.text = @"运输中";}
        if (self.details.traces.in_transit.count==1) {
            cell.imgView.image = [UIImage imageNamed:self.details.traces.in_delivery.count==0?@"ship_transiting":@"ship_transited"];
        } else {
            if (indexPath.row==0) {
                cell.imgView.image = [UIImage imageNamed:self.details.traces.in_delivery.count==0?@"ship_transiting":@"ship_transited"];
            } else {
                cell.imgView.hidden = YES;
            }
        }
    } else{
        if (indexPath.row == self.details.traces.contract.count-1) {
            cell.headLine.hidden = NO;
            cell.bottomLine.hidden = YES;
            [cell.bgView settingRadius:5 corner:UIRectCornerBottomLeft|UIRectCornerBottomRight];
            cell.safeView.hidden = NO;
        }
        if(indexPath.row == 0){cell.statusLb.text = @"已揽件";}
        if (self.details.traces.contract.count==1) {
            cell.imgView.image = [UIImage imageNamed:self.details.traces.in_transit.count==0?@"ship_contracting":@"ship_contracted"];
        } else {
            if (indexPath.row==0) {
                cell.imgView.image = [UIImage imageNamed:self.details.traces.in_transit.count==0?@"ship_contracting":@"ship_contracted"];
            } else {
                cell.imgView.hidden = YES;
            }
        }
    }
    return cell;
}


//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}

//字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];

    NSDate *date = [dateFormatter dateFromString:dateString];
    return [self worldTimeToChinaTime:date];
}

//日期格式转字符串
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

@end
