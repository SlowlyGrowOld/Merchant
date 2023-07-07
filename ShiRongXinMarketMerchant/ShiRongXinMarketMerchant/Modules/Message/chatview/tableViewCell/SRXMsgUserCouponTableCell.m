//
//  SRXMsgUserCouponTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/15.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMsgUserCouponTableCell.h"
#import "SHActivityIndicatorView.h"

@interface SRXMsgUserCouponTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *user_icon;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *good_name;
@property (weak, nonatomic) IBOutlet UILabel *good_price;
@property (weak, nonatomic) IBOutlet SHActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *conditionLb;
@property (weak, nonatomic) IBOutlet UILabel *receiveLb;

@end

@implementation SRXMsgUserCouponTableCell

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
    _good_name.attributedText = [NSMutableAttributedString attributedStingWithString:model.coupon_info.goods_name font:[UIFont systemFontOfSize:12] textColor:UIColor.blackColor lineSpacing:4];
    _good_price.text = [NSString stringWithNumber:@(model.coupon_info.money) formatter:@"##.##"];
    [_good_image sd_setImageWithURL:[NSURL URLWithString:model.coupon_info.image]];
    _conditionLb.text = [NSString stringWithFormat:@"满%@可用",model.coupon_info.condition];
    _timeLb.text = [NSString stringWithFormat:@"有效期至：%@",model.coupon_info.end_date.length>0?model.coupon_info.end_date:@""];
    _receiveLb.text = model.coupon_info.is_coupon_receive?@"已领取":@"未领取";
    _activityView.hidden = YES;
    _activityView.messageState = model.messageState;
}

@end
