//
//  SRXMsgRecommentGoodsTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatRecommentGoodsTableCell.h"

@interface SRXChatRecommentGoodsTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goods_img;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *goods_price;

@end

@implementation SRXChatRecommentGoodsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(SRXMsgGoodsInfoItem *)item {
    _item = item;
    [_goods_img sd_setImageWithURL:[NSURL URLWithString:item.image]];
    _goods_name.text = item.goods_name;
    _goods_price.text = item.price;
    _couponBtn.hidden = item.coupon?NO:YES;
}

@end
