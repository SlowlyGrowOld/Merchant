//
//  SRXMessageListTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMessageListTableCell.h"

@interface SRXMessageListTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *user_img;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_msg;
@property (weak, nonatomic) IBOutlet UILabel *create_time;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end

@implementation SRXMessageListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXMessageListModel *)model {
    _model = model;
    [_user_img sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    _user_name.text = model.nickname;
    _create_time.text = model.send_time;
    _user_msg.text = model.content;
    _number.hidden = model.unread==0?YES:NO;
    _number.text = model.unread>99?@"99+":@(model.unread).stringValue;
}

@end
