//
//  SRXMsgShopGoodsTableCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/18.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgShopGoodsTableCell.h"
#import "SRXGoodsDetailsVC.h"

@interface SRXMsgShopGoodsTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shop_icon;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *good_name;
@property (weak, nonatomic) IBOutlet UILabel *good_price;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation SRXMsgShopGoodsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bgView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [self jumpGoodsDetails];
    }];
}

- (void)jumpGoodsDetails {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
    SRXGoodsDetailsVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsDetailsVC"];
    vc.goods_id = self.model.goods_info.goods_id;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXMsgChatModel *)model {
    _model = model;
    [_shop_icon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _shop_name.text = model.nickname;
    [_good_image sd_setImageWithURL:[NSURL URLWithString:model.goods_info.image]];
    _good_name.attributedText = [NSMutableAttributedString attributedStingWithString:model.goods_info.goods_name font:[UIFont systemFontOfSize:12] textColor:UIColor.blackColor lineSpacing:4];
    _good_price.text = model.goods_info.price;
}

@end
