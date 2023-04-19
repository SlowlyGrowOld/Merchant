//
//  SRXCommonBtnBalanceDetail.m
//  ShiRongXinMarketMerchant
//
//  Created by 奇林刘 on 2020/4/22.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXCommonBtnBalanceDetail.h"

@interface SRXCommonBtnBalanceDetail ()

@property (strong, nonatomic) UIView *bottomLine;

@end

@implementation SRXCommonBtnBalanceDetail

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.bottomLine.hidden = !selected;
}

#pragma mark - Protocol


#pragma mark -Method


#pragma mark - Init
- (void)initSelf {
    [self setTitleColor:UIColorHex(#333333) forState:UIControlStateSelected];
    [self setTitleColor:UIColorHex(#A0A0A0) forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.tintColor = [UIColor clearColor];
    self.bottomLine = ({
        UIView *thing = [[UIView alloc] init];
        thing.backgroundColor = UIColorHex(#C8A062);
        thing.layer.cornerRadius = 1;
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(30));
            make.height.equalTo(@(2));
            make.bottom.centerX.equalTo(self);
        }];
        thing;
    });
}

@end
