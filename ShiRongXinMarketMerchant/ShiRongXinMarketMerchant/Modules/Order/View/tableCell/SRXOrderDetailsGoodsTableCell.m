//
//  SRXOrderDetailsGoodsTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderDetailsGoodsTableCell.h"
#import "SRXOrderDetailsGoodsListView.h"

@interface SRXOrderDetailsGoodsTableCell ()
@property (weak, nonatomic) IBOutlet SRXOrderDetailsGoodsListView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;

@end

@implementation SRXOrderDetailsGoodsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    self.tableViewConsH.constant = 115*datas.count;
    self.tableView.datas = datas;
}

@end
