//
//  SRXOrderRefundDetailsGoodsTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderRefundDetailsGoodsTableCell.h"
#import "SRXOrderDetailsGoodsListView.h"

@interface SRXOrderRefundDetailsGoodsTableCell ()
@property (weak, nonatomic) IBOutlet SRXOrderDetailsGoodsListView *tableView;

@end

@implementation SRXOrderRefundDetailsGoodsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGoods_info:(SRXOrderDGoods_infoItem *)goods_info {
    _goods_info= goods_info;
    if (goods_info) {
        self.tableView.datas = @[goods_info];
    } else {
        self.tableView.datas = @[];
    }
}

@end
