//
//  SRXChatTagsTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/13.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatTagsTableCell.h"
#import "UIColor+JHExt.h"

@interface SRXChatTagsTableCell ()
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *star_image;
@property (weak, nonatomic) IBOutlet UILabel *tag_name;

@end

@implementation SRXChatTagsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectBtnClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.item.is_chose = sender.isSelected;
}

- (void)setItem:(SRXMsgLabelsItem *)item {
    _item = item;
    _tag_name.text = item.label_name;
    UIImage *image = [UIImage imageNamed:@"star_yellow"];
    self.star_image.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.star_image setTintColor:[UIColor colorWithHexString:item.label_color_number alpha:1]];
    self.selectBtn.selected = item.is_chose;
}

@end
