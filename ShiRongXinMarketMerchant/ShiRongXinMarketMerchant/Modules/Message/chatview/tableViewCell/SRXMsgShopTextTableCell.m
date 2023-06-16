//
//  SRXMsgShopTableCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/18.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgShopTextTableCell.h"
#import "JYTextView.h"
#import "JYBubbleMenuView.h"

@interface SRXMsgShopTextTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shop_icon;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet JYTextView *contentTV;
@property (weak, nonatomic) IBOutlet UIImageView *report_image;

@end

@implementation SRXMsgShopTextTableCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    _contentTV.fatherViewController = [UIViewController jk_currentViewController];
    _contentTV.uid = @"shop";
    [((AppDelegate*)([UIApplication sharedApplication].delegate)).window addSubview:[JYBubbleMenuView shareMenuView]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTextSelection) name:@"JKTextViewHideTextSelection" object:nil];
    MJWeakSelf;
    _contentTV.selectBlock = ^(NSString * _Nonnull selectedButtonTitle, NSString * _Nonnull selectedText, NSString * _Nonnull uid) {
        if ([uid isEqualToString:@"shop"]) {
            if ([selectedButtonTitle isEqualToString:@"复制"]) {
                [AppHandyMethods theCopyActionWith:selectedText];
            }else if ([selectedButtonTitle isEqualToString:@"删除"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:KNotiChatTextMenuAction object:nil userInfo:@{@"type":@"delete",@"id":weakSelf.model._id}];
            }else if ([selectedButtonTitle isEqualToString:@"举报"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:KNotiChatTextMenuAction object:nil userInfo:@{@"type":@"report",@"id":weakSelf.model._id,@"content":selectedText}];
            }else if ([selectedButtonTitle isEqualToString:@"引用"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:KNotiChatTextMenuAction object:nil userInfo:@{@"type":@"quote",@"id":weakSelf.model._id,@"content":selectedText}];
            }
        }
    };
}

- (void)hideTextSelection {
    [self.contentTV hideTextSelection];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXMsgChatModel *)model {
    _model = model;
    [_shop_icon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _shop_name.text = model.nickname;
    _content.text = model.content;
    _contentTV.text = model.content;
    _report_image.hidden = !model.is_report;
}

@end
