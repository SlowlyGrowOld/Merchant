//
//  SRXMsgUserChargeOrderTableCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2023/2/13.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMsgUserChargeOrderTableCell.h"
#import "SHActivityIndicatorView.h"

@interface SRXMsgUserChargeOrderTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *user_icon;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *order_sn;
@property (weak, nonatomic) IBOutlet UIImageView *type_image;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *mobileLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UILabel *scoreLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet SHActivityIndicatorView *activityView;
@end

@implementation SRXMsgUserChargeOrderTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_activityView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationMsgSendFail object:nil userInfo:@{@"info":self.model}];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXMsgChatModel *)model {
    _model = model;
    
    [_user_icon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _user_name.text = model.nickname;
    _order_sn.text = [NSString stringWithFormat:@"订单号:%@",model.fulu_order_info.pay_sn];
    if ([model.fulu_order_info.status isEqualToString:@"充值中"]) {
        _statusLb.text = @"充值中";
        _statusLb.textColor = UIColorHex(0x62B3FF);
    } else if ([model.fulu_order_info.status isEqualToString:@"已成功"]) {
        _statusLb.text = @"已成功";
        _statusLb.textColor = UIColorHex(0xC84D1D);
    } else if ([model.fulu_order_info.status isEqualToString:@"已退款"]) {
        _statusLb.text = @"已退款";
        _statusLb.textColor = UIColorHex(0x757575);
    }
    _titleLb.text = model.fulu_order_info.goods_name;
    _mobileLb.text = model.fulu_order_info.mobile;
    _timeLb.text = model.fulu_order_info.create_time;
    _priceLb.attributedText = [NSMutableAttributedString setPriceText:model.fulu_order_info.pay_amount frontFont:14 behindFont:8 textColor:UIColor.blackColor];
    
    [_type_image sd_setImageWithURL:[NSURL URLWithString:model.fulu_order_info.goods_image]];
    if (model.fulu_order_info.score == 0) {
        _scoreLb.superview.hidden = YES;
    }else {
        _scoreLb.superview.hidden = NO;
        _scoreLb.text = @(model.fulu_order_info.score).stringValue;
    }
    _activityView.hidden = YES;
    _activityView.messageState = model.messageState;
}

@end
