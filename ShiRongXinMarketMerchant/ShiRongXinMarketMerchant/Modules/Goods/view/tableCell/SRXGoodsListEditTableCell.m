//
//  SRXGoodsListEditTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsListEditTableCell.h"

@interface SRXGoodsListEditTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goods_img;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *sale_num;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation SRXGoodsListEditTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(SRXGoodsListModel *)model {
    _model = model;
    [_goods_img sd_setImageWithURL:[NSURL URLWithString:model.image]];
    _goods_name.text = model.goods_name;
    _sale_num.text = [NSString stringWithFormat:@"销量：%zd",model.sales_sum];
    _selectBtn.selected = model.is_select;
}

@end
