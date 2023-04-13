//
//  GradientButton.m
//  ShiRongXinMarketMallProject
//
//  Created by 别天神 on 2021/9/4.
//  Copyright © 2021 Alucardulad. All rights reserved.
//

#import "GradientButton.h"

@implementation GradientButton

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    [self gradientButtonWithSize:self.size
                      colorArray:@[UIColorHex(#FA8C51), UIColorHex(#FA6764)]
                 percentageArray:@[@(0),@(1.0f)]
                    gradientType:GradientFromLeftToRight];
    [self setTitleColor:UIColorHex(#FFFFFF) forState:UIControlStateNormal];
    [self setTitleColor:UIColorHex(#C19250) forState:UIControlStateDisabled];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        [self gradientButtonWithSize:self.size
                          colorArray:@[UIColorHex(#F3CA83), UIColorHex(#D59C38)]
                     percentageArray:@[@(0),@(1.0f)]
                        gradientType:GradientFromTopToBottom];
    } else {
        [self gradientButtonWithSize:self.size
                          colorArray:@[UIColorHex(#E0C8A7), UIColorHex(#E0C8A7)]
                     percentageArray:@[@(0),@(1.0f)]
                        gradientType:GradientFromTopToBottom];
    }
}
@end
