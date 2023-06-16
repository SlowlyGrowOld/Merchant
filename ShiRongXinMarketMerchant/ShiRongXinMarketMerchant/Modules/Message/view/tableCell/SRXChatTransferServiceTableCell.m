//
//  SRXChatTransferServiceTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/16.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatTransferServiceTableCell.h"

@interface SRXChatTransferServiceTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *service_image;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *statusLb;

@end

@implementation SRXChatTransferServiceTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setService:(SRXMsgChatServiceItem *)service {
    _service = service;
    [_service_image sd_setImageWithURL:[NSURL URLWithString:service.avatar]];
    _nameLb.text = service.nickname;
    _statusLb.text = service.chat_status==1?@"值守中":@"休息中";
    _statusLb.textColor = service.chat_status==1?UIColorHex(0x00D646):UIColorHex(0xCDAE00);
    _transferBtn.enabled = service.chat_status==1?YES:NO;
    _transferBtn.backgroundColor = service.chat_status==1?C43B8F6:UIColorHex(0xd7d7d7);
}

@end
