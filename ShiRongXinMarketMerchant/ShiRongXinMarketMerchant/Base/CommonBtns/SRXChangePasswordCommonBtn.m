//
//  SRXChangePasswordCommonBtn.m
//  ShiRongXinMarketMerchant
//
//  Created by 奇林刘 on 2020/4/3.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXChangePasswordCommonBtn.h"

@implementation SRXChangePasswordCommonBtn

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSelf];
    }
    return self;
}

#pragma mark - Protocol


#pragma mark -Method


#pragma mark - Init
- (void)initSelf {
    self.layer.borderColor = [UIColorHex(#9F9F9F) colorWithAlphaComponent:0.5].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = self.height * 0.5;
    [self setTitle:@"" forState:UIControlStateNormal];
    self.rightBtn = ({
        UIButton *thing = [[UIButton alloc] init];
        thing.layer.borderColor = UIColorHex(#DDA239).CGColor;
        thing.layer.borderWidth = 1;
        thing.layer.cornerRadius = 12;
        thing.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        [thing setTitleColor:UIColorHex(#DDA239) forState:UIControlStateNormal];
        
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.offset(-self.height * 0.5);
            make.width.equalTo(@(104));
            make.height.equalTo(@(24));
        }];
        thing;
    });
    self.leftField = ({
        UITextField *thing = [[UITextField alloc] init];
        thing.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        thing.tintColor = UIColorHex(#DDA239);
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.offset(self.height * 0.5);
            make.top.bottom.offset(0);
            make.right.equalTo(self.rightBtn.mas_left).offset(10);
        }];
        thing;
    });
}

@end
