//
//  PXPayTypeCommonBtn.m
//  PinXianMarketMallProject
//
//  Created by 奇林刘 on 2020/5/18.
//  Copyright © 2020 小薛. All rights reserved.
//

#import "PXPayTypeCommonBtn.h"

@interface PXPayTypeCommonBtn ()

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *PXTitle;
@property (strong, nonatomic) UIImageView *rightCheck;

@end

@implementation PXPayTypeCommonBtn

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSelf];
}

- (void)initSelf {
    self.icon = ({
        UIImageView *thing = [[UIImageView alloc] init];
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(20));
            make.centerY.equalTo(self);
            make.left.offset(10);
        }];
        thing;
    });
    self.PXTitle = ({
        UILabel *thing = [[UILabel alloc] init];
        thing.textColor = UIColorHex(#0A0A0A);
        thing.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.icon.mas_right).offset(5);
        }];
        thing;
    });
    self.rightCheck = ({
        UIImageView *thing = [[UIImageView alloc] init];
        [self addSubview:thing];
        [thing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(16));
            make.centerY.equalTo(self);
            make.right.offset(-10);
        }];
        thing;
    });
    
    self.icon.image = [self imageForState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateNormal];
    self.PXTitle.text = [self titleForState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateNormal];
    
    [self setSelected:self.selected];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.rightCheck.image = selected ? IMAGE_NAMED(@"路径 43809") : IMAGE_NAMED(@"椭圆 880");
}

- (void)setHighlighted:(BOOL)highlighted {
    //重写这个方法，是为了关闭Highlighted，避免按住按钮时出现某个不希望的效果。
    //参考：https://www.jianshu.com/p/3d8c9f7d2fa5
}

@end
