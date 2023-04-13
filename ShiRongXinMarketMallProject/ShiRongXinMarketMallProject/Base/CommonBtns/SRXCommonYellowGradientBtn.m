//
//  SRXCommonYellowGradientBtn.m
//  ShiRongXinMarketMallProject
//
//  Created by 奇林刘 on 2020/3/11.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXCommonYellowGradientBtn.h"

@implementation SRXCommonYellowGradientBtn

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self gradientButtonWithSize:self.size
                          colorArray:@[UIColorHex(#F3CA83), UIColorHex(#D59C38)]
                     percentageArray:@[@(0),@(1.0f)]
                        gradientType:GradientFromTopToBottom];
        self.layer.cornerRadius = self.size.height * 0.5;
        self.clipsToBounds = YES;
        [self setTitleColor:UIColorHex(#FFFFFF) forState:UIControlStateNormal];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self gradientButtonWithSize:self.size
                          colorArray:@[UIColorHex(#F3CA83), UIColorHex(#D59C38)]
                     percentageArray:@[@(0),@(1.0f)]
                        gradientType:GradientFromTopToBottom];
        self.layer.cornerRadius = self.size.height * 0.5;
        self.clipsToBounds = YES;
        [self setTitleColor:UIColorHex(#FFFFFF) forState:UIControlStateNormal];
    }
    return self;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        [self gradientButtonWithSize:self.size
                          colorArray:@[UIColorHex(#F3CA83), UIColorHex(#D59C38)]
                     percentageArray:@[@(0),@(1.0f)]
                        gradientType:GradientFromTopToBottom];
        self.layer.cornerRadius = self.size.height * 0.5;
        self.clipsToBounds = YES;
        [self setTitleColor:UIColorHex(#FFFFFF) forState:UIControlStateNormal];
    }
    return self;
}
@end
