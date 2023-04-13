//
//  SRXMsgCenterCommonBtn.m
//  ShiRongXinMarketMallProject
//
//  Created by 奇林刘 on 2020/3/24.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXMsgCenterCommonBtn.h"

@interface SRXMsgCenterCommonBtn ()

@property (strong, nonatomic) UILabel *SRXTitleLabel;
@property (strong, nonatomic) UIImageView *SRXIcon;
@property (strong, nonatomic) UIImageView *SRXRightIndex;
@property (strong, nonatomic) UIView *bottomLine;
@property (strong, nonatomic) UILabel *badge;

@end

@implementation SRXMsgCenterCommonBtn

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
    self.SRXIcon = ({
        UIImageView *thing = [[UIImageView alloc] init];
        thing.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(24));
            make.left.centerY.equalTo(self);
        }];
        thing;
    });
    self.SRXTitleLabel = ({
        UILabel *thing = [[UILabel alloc] init];
        thing.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        thing.textColor = UIColorHex(#0A0A0A);
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.SRXIcon.mas_right).offset(10);
            make.top.equalTo(self.SRXIcon.mas_top).offset(-10);
        }];
        thing;
    });
    self.SRXDetailLabel = ({
        UILabel *thing = [[UILabel alloc] init];
        thing.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        thing.textColor = UIColorHex(#A0A0A0);
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.SRXIcon.mas_right).offset(10);
            make.top.equalTo(self.SRXIcon.mas_bottom).offset(-10);
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
    self.SRXRightIndex = ({
        UIImageView *thing = [[UIImageView alloc] init];
        thing.image = IMAGE_NAMED(@"路径 43750");
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.equalTo(self);
        }];
        thing;
    });
    self.badge = ({
        UILabel *thing = [[UILabel alloc] init];
        thing.backgroundColor = UIColorHex(#EA5529);
        thing.textColor = [UIColor whiteColor];
        thing.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        thing.layer.cornerRadius = 10;
        thing.clipsToBounds = YES;
        thing.textAlignment = NSTextAlignmentCenter;
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.SRXRightIndex.mas_left).offset(-6);
            make.width.height.equalTo(@(20));
            make.centerY.equalTo(self);
        }];
        thing;
    });
    
    self.SRXIcon.image = [self imageForState:UIControlStateNormal];
    self.SRXTitleLabel.text = [self titleForState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateNormal];
    self.badgeCount = 0;
}

- (void)setBadgeCount:(NSInteger)badgeCount {
    _badgeCount = badgeCount;
    self.badge.hidden = (badgeCount <= 0);
    self.badge.text = @(badgeCount).stringValue;
}

@end
