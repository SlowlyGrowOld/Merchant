//
//  SRXMsgUserTextTableCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/18.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgUserTextTableCell.h"
#import "SHActivityIndicatorView.h"
#import "JYTextView.h"
#import "JYBubbleMenuView.h"
#import "SRXMsgChatQuoteView.h"

@interface SRXMsgUserTextTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *user_icon;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet SHActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet JYTextView *contentTV;
@property (weak, nonatomic) IBOutlet UIImageView *report_image;
@property (weak, nonatomic) IBOutlet UILabel *quoteLb;
@property (nonatomic, strong) SRXMsgChatQuoteView *quoteView;
@end

@implementation SRXMsgUserTextTableCell

- (SRXMsgChatQuoteView *)quoteView {
    if (!_quoteView) {
        _quoteView = [[NSBundle mainBundle] loadNibNamed:@"SRXMsgChatQuoteView" owner:nil options:nil].firstObject;
        _quoteView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
    return _quoteView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_activityView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationMsgSendFail object:nil userInfo:@{@"info":self.model}];
    }];
//    _contentTV.fatherViewController = [UIViewController jk_currentViewController];
    _contentTV.uid = @"user";
    [((AppDelegate*)([UIApplication sharedApplication].delegate)).window addSubview:[JYBubbleMenuView shareMenuView]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTextSelection) name:@"JKTextViewHideTextSelection" object:nil];
    MJWeakSelf;
    _contentTV.selectBlock = ^(NSString * _Nonnull selectedButtonTitle, NSString * _Nonnull selectedText, NSString * _Nonnull uid) {
        if ([uid isEqualToString:@"user"]) {
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
    [_quoteLb.superview jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        weakSelf.quoteView.quote = weakSelf.model.reference_info.reference_chat_content;
        [weakSelf.quoteView show];
        [[UIViewController jk_currentViewController].view endEditing:YES];
        [[JYBubbleMenuView shareMenuView] removeFromSuperview] ;
    }];
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
    [_user_icon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _user_name.text = model.nickname;
    _content.text = model.content;
    _contentTV.text = model.content;
    _report_image.hidden = !model.is_report;
    if (model.reference_info) {
        _quoteLb.superview.hidden = NO;
        _quoteLb.text = model.reference_info.reference_chat_content;
    } else {
        _quoteLb.superview.hidden = YES;
    }
    
    _activityView.hidden = YES;
    _activityView.messageState = model.messageState;
}

@end
