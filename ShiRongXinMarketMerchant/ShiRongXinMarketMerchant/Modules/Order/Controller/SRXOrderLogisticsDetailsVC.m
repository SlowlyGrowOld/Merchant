//
//  SRXOrderLogisticsDetailsVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/25.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderLogisticsDetailsVC.h"
#import "SRXOrderLogisticsDetailsTableCell.h"

@interface SRXOrderLogisticsDetailsVC ()

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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrderLogisticsDetailsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXOrderLogisticsDetailsTableCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.headLine.hidden = YES;
        cell.bottomLine.hidden = NO;
        [cell.bgView settingRadius:5 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
//        cell.bottomLine.backgroundColor = UIColor.whiteColor;
//        [cell.bottomLine jk_drawLineOfDashByCAShapeLayerLineWidth:1 withLineSpacing:2 withLineColor:CFont99 withLineDirection:NO];
    } else if (indexPath.row == 7) {
        cell.headLine.hidden = NO;
        cell.bottomLine.hidden = YES;
        [cell.bgView settingRadius:5 corner:UIRectCornerBottomLeft|UIRectCornerBottomRight];
    } else{
        cell.headLine.hidden = NO;
        cell.bottomLine.hidden = NO;
        cell.bgView.layer.cornerRadius = 0;
    }
//    if (indexPath.row == 1) {
//        cell.headLine.backgroundColor = UIColor.whiteColor;
//        [cell.headLine jk_drawLineOfDashByCAShapeLayerLineWidth:1 withLineSpacing:2 withLineColor:CFont99 withLineDirection:NO];
//    }
    return cell;
}



@end
