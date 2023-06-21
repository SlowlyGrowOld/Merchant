//
//  SRXGDEvaluationTableCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/30.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXGDEvaluationTableCell.h"
#import "SRXGEStarsRankView.h"
#import "NSMutableAttributedString+JHExt.h"

@interface SRXGDEvaluationTableCell ()
@property (weak, nonatomic) IBOutlet SRXGEStarsRankView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *referrerLb;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet UILabel *typeLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;

@end

@implementation SRXGDEvaluationTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.starView.score = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataItem:(SRXGELDataItem *)dataItem {
    _dataItem = dataItem;
    [self.image sd_setImageWithURL:[NSURL URLWithString:dataItem.avatar] placeholderImage:[UIImage imageNamed:@"icon4"]];
    self.referrerLb.hidden = dataItem.is_recommended==1?NO:YES;
    self.nameLb.text = dataItem.nickname;
    if (dataItem.identity_name.length>0) {
        self.typeView.hidden = NO;
        self.typeLb.text = dataItem.identity_name;
    }else {
        self.typeView.hidden = YES;
    }
    self.timeLb.text = dataItem.create_time;
    self.contentLb.attributedText = [NSMutableAttributedString attributedStingWithString:dataItem.content font:[UIFont systemFontOfSize:14] textColor:CFont3D lineSpacing:2];

}

@end
