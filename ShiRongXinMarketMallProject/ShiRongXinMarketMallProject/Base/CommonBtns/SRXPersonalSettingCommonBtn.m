//
//  SRXPersonalSettingCommonBtn.m
//  ShiRongXinMarketMallProject
//
//  Created by 奇林刘 on 2020/4/2.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXPersonalSettingCommonBtn.h"

@interface SRXPersonalSettingCommonBtn ()

@property (strong, nonatomic) UILabel *SRXTitle;
@property (strong, nonatomic) UIView *bottomLine;
@property (strong, nonatomic) UIImageView *rightIndex;

@end

@implementation SRXPersonalSettingCommonBtn

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
    self.SRXTitle = ({
        UILabel *thing = [[UILabel alloc] init];
        thing.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        thing.textColor = UIColorHex(#0A0A0A);
        thing.text = [self titleForState:UIControlStateNormal];
        [self setTitle:@"" forState:UIControlStateNormal];
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(self);
        }];
        thing;
    });
    self.rightIndex = ({
        UIImageView *thing = [[UIImageView alloc] init];
        thing.contentMode = UIViewContentModeScaleToFill;
        thing.image = IMAGE_NAMED(@"路径 43750");
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.equalTo(self);
            make.width.equalTo(@(5.41));
            make.height.equalTo(@(10));
        }];
        thing;
    });
    self.bottomLine = ({
        UIView *thing = [[UIView alloc] init];
        thing.backgroundColor = UIColorHex(#EEEEEE);
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@(1));
        }];
        thing;
    });
    self.SRXTextField = ({
        UITextField *thing = [[UITextField alloc] init];
        thing.textAlignment = NSTextAlignmentRight;
        thing.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(100);
            make.centerY.equalTo(self.SRXTitle);
            make.right.equalTo(self.rightIndex.mas_left).offset(-10);
            make.bottom.equalTo(self.bottomLine.mas_top);
        }];
        thing;
    });
}
@end
