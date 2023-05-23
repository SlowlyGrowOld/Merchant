//
//  SRXOrdersListGoodsTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrdersListGoodsTableCell.h"

@interface SRXOrdersListGoodsTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goods_img;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *goods_spec;
@property (weak, nonatomic) IBOutlet UILabel *goods_num;
@property (weak, nonatomic) IBOutlet UILabel *goods_status;

@end

@implementation SRXOrdersListGoodsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(SRXOrderGoodsItem *)item {
    _item = item;
    [_goods_img sd_setImageWithURL:[NSURL URLWithString:item.image]];
    _goods_name.text = item.goods_name;
    _goods_spec.text = item.spec_key_name;
    _goods_spec.superview.hidden = item.spec_key_name.length==0?YES:NO;
    _goods_status.hidden = item.order_delivery_id>0?NO:YES;
}

- (void)setGoods_count:(NSInteger)goods_count {
    _goods_count = goods_count;
    if (goods_count==0) {
        _goods_num.hidden = YES;
    } else {
        _goods_num.hidden = NO;
        _goods_num.text = [NSString stringWithFormat:@"共%zd件",goods_count];
    }
}

@end
