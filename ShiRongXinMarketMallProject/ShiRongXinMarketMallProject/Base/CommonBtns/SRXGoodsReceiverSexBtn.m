//
//  SRXGoodsReceiverSexBtn.m
//  ShiRongXinMarketMallProject
//
//  Created by 奇林刘 on 2020/3/12.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXGoodsReceiverSexBtn.h"

@implementation SRXGoodsReceiverSexBtn

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self setTitleColor:UIColorHex(#FFFFFF) forState:UIControlStateSelected];
        [self setTitleColor:UIColorHex(#A0A0A0) forState:UIControlStateNormal];
        self.selected = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self gradientButtonWithSize:self.size
                      colorArray:selected ? @[UIColorHex(#FAD38E), UIColorHex(#DDA239)] : @[UIColorHex(#EEEEEE), UIColorHex(#A0A0A0)]
                 percentageArray:@[@(0),@(1.0f)]
                    gradientType:GradientFromLeftToRight];
}

- (void)setHighlighted:(BOOL)highlighted {
    //重写这个方法，是为了关闭Highlighted，避免按住按钮时出现某个不希望的效果。
    //参考：https://www.jianshu.com/p/3d8c9f7d2fa5
}

@end
