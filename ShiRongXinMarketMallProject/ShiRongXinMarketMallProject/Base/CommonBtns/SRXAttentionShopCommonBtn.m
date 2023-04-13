//
//  SRXAttentionShopCommonBtn.m
//  ShiRongXinMarketMallProject
//
//  Created by 奇林刘 on 2020/4/8.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXAttentionShopCommonBtn.h"

@implementation SRXAttentionShopCommonBtn

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
    self.layer.cornerRadius = self.height * 0.5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    UIImage *normalBg = [[UIImage alloc] createImageWithSize:self.size
                                              gradientColors:@[UIColorHex(#F4CA83), UIColorHex(#D59C38)]
                                                  percentage:@[@(0.0f), @(1.0f)]
                                                gradientType:GradientFromTopToBottom];
    UIImage *selectedBg = [UIImage imageWithColor:[UIColorHex(#D8D6D6) colorWithAlphaComponent:0.59] size:self.size];
    [self setBackgroundImage:normalBg forState:UIControlStateNormal];
    [self setBackgroundImage:selectedBg forState:UIControlStateSelected];
}

@end
