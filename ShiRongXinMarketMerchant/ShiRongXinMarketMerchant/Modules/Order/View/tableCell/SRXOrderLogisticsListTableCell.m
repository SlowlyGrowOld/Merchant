//
//  SRXOrderLogisticsListTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/23.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderLogisticsListTableCell.h"
#import "SRXOrderListGoodsTableView.h"
#import "SRXOrdersListGoodsTableCell.h"

@interface SRXOrderLogisticsListTableCell ()
@property (weak, nonatomic) IBOutlet SRXOrderListGoodsTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;

@end

@implementation SRXOrderLogisticsListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.datas = @[@"",@""];
    self.tableViewConsH.constant = 80 * 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
