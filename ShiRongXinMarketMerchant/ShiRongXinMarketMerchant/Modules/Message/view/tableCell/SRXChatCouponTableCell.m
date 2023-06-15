//
//  SRXChatCouponTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/14.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatCouponTableCell.h"

@interface SRXChatCouponTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *select_image;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *conditionLb;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *validityLb;
@property (weak, nonatomic) IBOutlet UILabel *less_num;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;

@end

@implementation SRXChatCouponTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(SRXMsgChatCoupnItem *)item {
    _item = item;
    _priceLb.text = [NSString stringWithNumber:@(item.money) formatter:@"##.##"];
    _conditionLb.text = [NSString stringWithFormat:@"满%@可用",item.condition];
    _nameLb.text = item.name;
    _validityLb.text = [NSString stringWithFormat:@"有效期：%@",item.validity];
    _less_num.text = [NSString stringWithFormat:@"剩余数量：%@",item.less_num];
    _goods_name.text = [NSString stringWithFormat:@"可用商品：%@",item.goods_name];
    _select_image.image = [UIImage imageNamed:item.is_select?@"checkbox_blue_selected":@"checkbox_nomal"];
}

@end
