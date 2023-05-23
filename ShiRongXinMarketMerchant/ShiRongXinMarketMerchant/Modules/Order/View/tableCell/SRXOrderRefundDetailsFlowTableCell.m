//
//  SRXOrderRefundDetailsFlowTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderRefundDetailsFlowTableCell.h"

@interface SRXOrderRefundDetailsFlowTableCell ()
@property (weak, nonatomic) IBOutlet UIView *one_line;
@property (weak, nonatomic) IBOutlet UIImageView *one_img;
@property (weak, nonatomic) IBOutlet UILabel *one_title;
@property (weak, nonatomic) IBOutlet UIView *two_line;
@property (weak, nonatomic) IBOutlet UIImageView *two_img;
@property (weak, nonatomic) IBOutlet UILabel *two_title;
@property (weak, nonatomic) IBOutlet UIView *three_line;
@property (weak, nonatomic) IBOutlet UIImageView *three_img;
@property (weak, nonatomic) IBOutlet UILabel *three_title;

@end

@implementation SRXOrderRefundDetailsFlowTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProcessWithProcess_num:(NSInteger)process_num now_process:(NSInteger)now_process {
    if (process_num == 4) {
        _one_line.superview.hidden = NO;
        if (now_process==1) {
            _one_line.backgroundColor = UIColor.whiteColor;
            _one_title.alpha = 1;
            _one_img.hidden = NO;
        } else if (now_process==2) {
            _one_line.backgroundColor = UIColor.whiteColor;
            _one_title.alpha = 1;
            _one_img.hidden = NO;
            _two_line.backgroundColor = UIColor.whiteColor;
            _two_title.alpha = 1;
            _two_img.hidden = NO;
        } else if (now_process==3) {
            _one_line.backgroundColor = UIColor.whiteColor;
            _one_title.alpha = 1;
            _one_img.hidden = NO;
            _two_line.backgroundColor = UIColor.whiteColor;
            _two_title.alpha = 1;
            _two_img.hidden = NO;
            _three_line.backgroundColor = UIColor.whiteColor;
            _three_title.alpha = 1;
            _three_img.hidden = NO;
        } else {
        }
    } else {
        _one_line.superview.hidden = YES;
        if (now_process==1) {
            _two_line.backgroundColor = UIColor.whiteColor;
            _two_title.alpha = 1;
            _two_img.hidden = NO;
        } else if (now_process==2) {
            _two_line.backgroundColor = UIColor.whiteColor;
            _two_title.alpha = 1;
            _two_img.hidden = NO;
            _three_line.backgroundColor = UIColor.whiteColor;
            _three_title.alpha = 1;
            _three_img.hidden = NO;
        }
    }
}

@end
