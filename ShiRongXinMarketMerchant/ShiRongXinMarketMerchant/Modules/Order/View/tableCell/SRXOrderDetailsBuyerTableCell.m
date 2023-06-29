//
//  SRXOrderDetailsBuyerTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderDetailsBuyerTableCell.h"
#import "SRXMsgChatVC.h"

@interface SRXOrderDetailsBuyerTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *user_img;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *consignee;
@property (weak, nonatomic) IBOutlet UILabel *full_address;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UILabel *mobile;

@end

@implementation SRXOrderDetailsBuyerTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(SRXOrderDUser_info *)info {
    _info = info;
    _user_name.text = info.nickname;
    [_user_img sd_setImageWithURL:[NSURL URLWithString:info.avatar]];
    _consignee.text = info.consignee;
    _mobile.text = info.mobile;
    _full_address.text = info.full_address;
    _remark.text = info.remark;
}

- (IBAction)chantBuyerBtnClick:(id)sender {
    SRXMsgChatVC *vc = [[SRXMsgChatVC alloc] init];
    SRXMessageListModel *item = [SRXMessageListModel new];
    item.nickname = self.info.nickname;
    item.avatar =  self.info.avatar;
    item.user_id =  self.info.user_id;
    vc.item = item;
    vc.shop_id = self.shop_id;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (IBAction)copyFullAddressBtnClick:(id)sender {
    [AppHandyMethods theCopyActionWith:self.info.full_address];
}

@end
