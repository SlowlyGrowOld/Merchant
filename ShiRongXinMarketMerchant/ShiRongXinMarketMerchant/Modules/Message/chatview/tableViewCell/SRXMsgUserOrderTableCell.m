//
//  SRXMsgUserOrderTableCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/26.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgUserOrderTableCell.h"
#import "SRXMsgOrderGoodsTableView.h"
#import "SRXOrderDetailsVC.h"
#import "SHActivityIndicatorView.h"

@interface SRXMsgUserOrderTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *user_icon;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *order_status;
@property (weak, nonatomic) IBOutlet SRXMsgOrderGoodsTableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *good_price;
@property (weak, nonatomic) IBOutlet UILabel *rmbLb;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;
@property (weak, nonatomic) IBOutlet SHActivityIndicatorView *activityView;
@end

@implementation SRXMsgUserOrderTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.detailBtn setImagePosition:LXMImagePositionRight spacing:2];
    [_activityView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationMsgSendFail object:nil userInfo:@{@"info":self.model}];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)detailBtnClick:(id)sender {

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
    SRXOrderDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"SRXOrderDetailsVC"];
    vc.shop_id = self.shop_id;
    vc.order_id =self.model.order_info.order_id;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (void)setModel:(SRXMsgChatModel *)model {
    _model = model;
    [_user_icon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _user_name.text = model.nickname;
    _tableView.datas = model.order_info.goods_info;
    if (model.order_info.pay_amount) {
        _good_price.attributedText = [NSMutableAttributedString setPriceText:model.order_info.pay_amount frontFont:13 behindFont:11 textColor:UIColor.redColor];
        _rmbLb.hidden = NO;
    }else {
        _rmbLb.hidden = YES;
        _good_price.text = @"";
    }
    _tableViewConsH.constant = model.order_info.goods_info.count*45;
    
    _activityView.hidden = YES;
    _activityView.messageState = model.messageState;
}

@end
