//
//  SRXLoginShopListTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/14.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXLoginShopListTableCell.h"

@interface SRXLoginShopListTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shop_image;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet UILabel *infoLb;

@end

@implementation SRXLoginShopListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.shadowColor = [UIColor colorWithRed:35/255.0 green:128/255.0 blue:254/255.0 alpha:0.1].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0,4);
    self.bgView.layer.shadowOpacity = 1;
    self.bgView.layer.shadowRadius = 10;
    self.bgView.clipsToBounds = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXShopDataItem *)model {
    _model = model;
    _shop_name.text = model.shop_name;
    [_shop_image sd_setImageWithURL:[NSURL URLWithString:model.shop_img]];
    _infoLb.text = [NSString stringWithFormat:@"在售商品：%zd    粉丝量：%zd",model.on_sale_num,model.fans_num];
}

@end
