//
//  SRXMsgEvaluateTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/16.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMsgEvaluateTableCell.h"
#import "SHActivityIndicatorView.h"

@interface SRXMsgEvaluateTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet SHActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIImageView *report_image;
@end

@implementation SRXMsgEvaluateTableCell

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
    
    _report_image.hidden = !model.is_report;
    _activityView.hidden = YES;
    _activityView.messageState = model.messageState;
}

@end
