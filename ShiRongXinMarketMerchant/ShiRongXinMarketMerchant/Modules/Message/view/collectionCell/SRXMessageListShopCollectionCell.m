//
//  SRXMessageListShopCollectionCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMessageListShopCollectionCell.h"

@interface SRXMessageListShopCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shop_img;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end

@implementation SRXMessageListShopCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(SRXChatShopNumItem *)item {
    _item = item;
    [_shop_img sd_setImageWithURL:[NSURL URLWithString:item.shop_img]];
    _shop_name.text = item.shop_name;
    _number.superview.hidden = item.un_read_num==0?YES:NO;
    _number.text = item.un_read_num>99?@"99+":@(item.un_read_num).stringValue;
    _shop_img.superview.backgroundColor = item.is_select?[C43B8F6 colorWithAlphaComponent:0.3]:[UIColorHex(0xE0E0E0) colorWithAlphaComponent:0.3];
}

@end
