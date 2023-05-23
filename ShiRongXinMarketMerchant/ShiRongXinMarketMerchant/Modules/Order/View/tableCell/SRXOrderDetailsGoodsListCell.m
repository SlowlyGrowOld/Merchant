//
//  SRXOrderDetailsGoodsListCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderDetailsGoodsListCell.h"

@interface SRXOrderDetailsGoodsListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goods_img;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *ship_status;
@property (weak, nonatomic) IBOutlet UILabel *goods_spec;
@property (weak, nonatomic) IBOutlet UILabel *goods_num;
@property (weak, nonatomic) IBOutlet UILabel *shipping_amount;
@property (weak, nonatomic) IBOutlet UILabel *goods_amount;

@end

@implementation SRXOrderDetailsGoodsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(SRXOrderDGoods_infoItem *)item {
    _item = item;
    [_goods_img sd_setImageWithURL:[NSURL URLWithString:item.image]];
    _goods_name.text = item.goods_name;
    _goods_spec.text = item.spec_key_name;
    _goods_spec.superview.hidden = item.spec_key_name.length==0?YES:NO;
    _ship_status.hidden = item.order_delivery_id>0?NO:YES;
    _shipping_amount.text = [NSString stringWithNumber:@(item.shipping_amount) formatter:@"¥##.##"];
    _goods_amount.text = [NSString stringWithNumber:@(item.total_amount) formatter:@"¥##.##"];
}

@end
