//
//  DCFeatureItemCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCFeatureItemCell.h"

@interface DCFeatureItemCell ()


@end

@implementation DCFeatureItemCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    _attLabel = [[UILabel alloc] init];
    _attLabel.textAlignment = NSTextAlignmentCenter;
    _attLabel.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:_attLabel];
    _stockoutLb = [[UILabel alloc] init];
    _stockoutLb.textAlignment = NSTextAlignmentCenter;
    _stockoutLb.font = [UIFont systemFontOfSize:8.0];
    _stockoutLb.backgroundColor = CFont99;
    _stockoutLb.text = @"缺货";
    _stockoutLb.textColor = UIColor.whiteColor;
    [_stockoutLb settingRadius:5 corner:UIRectCornerTopLeft|UIRectCornerBottomRight];
    [self.contentView addSubview:_stockoutLb];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_attLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [_stockoutLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(5);
        make.top.mas_equalTo(-5);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(22);
    }];
}

@end
