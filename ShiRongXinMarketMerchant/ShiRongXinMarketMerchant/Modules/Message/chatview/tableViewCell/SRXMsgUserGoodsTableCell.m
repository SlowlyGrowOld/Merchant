//
//  SRXMsgUserGoodsTableCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/18.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgUserGoodsTableCell.h"
#import "SHActivityIndicatorView.h"
//#import "SRXGoodsDetailsVC.h"
//#import "HomeHotTeamGoodDetailVC.h"
//#import "HomeRecomendDetailVC.h"

@interface SRXMsgUserGoodsTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *user_icon;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *good_name;
@property (weak, nonatomic) IBOutlet UILabel *good_price;
@property (weak, nonatomic) IBOutlet SHActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation SRXMsgUserGoodsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.bgView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [self jumpGoodsDetails];
    }];
    [_activityView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationMsgSendFail object:nil userInfo:@{@"info":self.model}];
    }];
}

- (void)jumpGoodsDetails {
//    if ([self.model.goods_info.goods_type isEqualToString:@"group_goods"]) {
//        SRXGroupGoodsModel *group = [SRXGroupGoodsModel new];
//        group.activity_id = self.model.goods_info.activity_id;
//        group.goods_id = [self.model.goods_info._id integerValue];
//        group.goods_name = self.model.goods_info.goods_name;
//        HomeHotTeamGoodDetailVC *vc = [[HomeHotTeamGoodDetailVC alloc] initWithNibName:@"HomeHotTeamGoodDetailVC" bundle:nil];
//        vc.item = group;
//        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
//    }else if ([self.model.goods_info.goods_type isEqualToString:@"jx_goods"]) {
//        HomeRecomendDetailVC *vc = [[HomeRecomendDetailVC alloc] initWithNibName:@"HomeRecomendDetailVC" bundle:nil];
//        vc.goodId = self.model.goods_info._id;
//        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
//    }else {
//        SRXGoodsListModel *goods = [[SRXGoodsListModel alloc] init];
//        goods._id = self.model.goods_info._id;
//        goods.goods_name = self.model.goods_info.goods_name;
//        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
//        SRXGoodsDetailsVC *vc = [story instantiateViewControllerWithIdentifier:@"SRXGoodsDetailsVC"];
//        vc.goodsDetailType = GoodsDetailTypeNormal;
//        vc.goodsListModel = goods;
//        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXMsgChatModel *)model {
    _model = model;
    [_user_icon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _user_name.text = model.nickname;
    _good_name.attributedText = [NSMutableAttributedString attributedStingWithString:model.goods_info.goods_name font:[UIFont systemFontOfSize:12] textColor:UIColor.blackColor lineSpacing:4];
    _good_price.text = model.goods_info.price;
    [_good_image sd_setImageWithURL:[NSURL URLWithString:model.goods_info.image]];
    
    _activityView.hidden = YES;
    _activityView.messageState = model.messageState;
}

@end
