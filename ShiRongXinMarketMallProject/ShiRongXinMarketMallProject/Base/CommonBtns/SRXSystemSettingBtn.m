//
//  SRXSystemSettingBtn.m
//  ShiRongXinMarketMallProject
//
//  Created by 奇林刘 on 2020/3/18.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXSystemSettingBtn.h"

@interface SRXSystemSettingBtn ()

@property (strong, nonatomic) UIView *bottomLine;
@property (strong, nonatomic) UIImageView *rightIndex;

@end

@implementation SRXSystemSettingBtn

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSelf];
    }
    return self;
}

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
    self.SRXDetail = ({
        UILabel *thing = [[UILabel alloc] init];
        thing.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        thing.textColor = UIColorHex(#0A0A0A);
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightIndex.mas_left).offset(-5);
            make.centerY.equalTo(self);
        }];
        thing;
    });
    self.SRXGrayDetail = ({
        UILabel *thing = [[UILabel alloc] init];
        thing.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        thing.textColor = UIColorHex(#A0A0A0);
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightIndex.mas_left).offset(-5);
            make.centerY.equalTo(self);
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
}

@end
