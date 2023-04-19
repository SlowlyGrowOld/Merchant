//
//  SRXDefaultPayWayCommonBtn.m
//  ShiRongXinMarketMerchant
//
//  Created by 奇林刘 on 2020/4/7.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXDefaultPayWayCommonBtn.h"

@interface SRXDefaultPayWayCommonBtn ()

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *SRXTitleLabel;
@property (strong, nonatomic) UIImageView *rightCheck;

@end

@implementation SRXDefaultPayWayCommonBtn

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSelf];
    }
    return self;
}

#pragma mark - Protocol


#pragma mark -Method
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.rightCheck.image = selected ? IMAGE_NAMED(@"路径 44058") : IMAGE_NAMED(@"椭圆 880");
}

#pragma mark - Init
- (void)initSelf {
    self.icon = ({
        UIImageView *thing = [[UIImageView alloc] init];
        thing.image = [self imageForState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(22));
            make.left.offset(10);
            make.centerY.offset(0);
        }];
        thing;
    });
    self.SRXTitleLabel = ({
        UILabel *thing = [[UILabel alloc] init];
        thing.textColor = UIColorHex(#0A0A0A);
        thing.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        thing.text = [self titleForState:UIControlStateNormal];
        [self setTitle:@"" forState:UIControlStateNormal];
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(self.icon.mas_right).offset(5);
        }];
        thing;
    });
    self.rightCheck = ({
        UIImageView *thing = [[UIImageView alloc] init];
        thing.image = IMAGE_NAMED(@"椭圆 880");
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(18));
            make.right.offset(-10);
            make.centerY.offset(0);
        }];
        thing;
    });
    self.bottomLine = ({
        UIView *thing = [[UIView alloc] init];
        thing.backgroundColor = UIColorHex(#EEEEEE);
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.bottom.offset(0);
            make.height.equalTo(@(1));
        }];
        thing;
    });
}

@end
