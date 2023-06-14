//
//  SRXMsgShopOrderUpdatesTableCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/18.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgShopOrderTableCell.h"
#import "SRXMsgOrderGoodsTableView.h"
#import "SRXOrderDetailsVC.h"

@interface SRXMsgShopOrderTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shop_icon;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet UILabel *order_status;
@property (weak, nonatomic) IBOutlet SRXMsgOrderGoodsTableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *good_price;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;

@end

@implementation SRXMsgShopOrderTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.detailBtn setImagePosition:LXMImagePositionRight spacing:2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)detailBtnClick:(id)sender {

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
    SRXOrderDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"SRXOrderDetailsVC"];
    vc.order_id = self.model.order_info.order_id;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (void)setModel:(SRXMsgChatModel *)model {
    _model = model;
    [_shop_icon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _shop_name.text = model.nickname;
    _tableView.datas = model.order_info.goods_info;
    _good_price.attributedText = [NSMutableAttributedString setPriceText:model.order_info.pay_amount frontFont:13 behindFont:11 textColor:UIColor.redColor];
    _tableViewConsH.constant = model.order_info.goods_info.count*45;
}

@end
