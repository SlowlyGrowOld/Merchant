//
//  SRXOrderCommonView.m
//  ShiRongXinMarketMerchant
//
//  Created by 薛静鹏 on 2020/3/31.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXOrderCommonView.h"

@implementation SRXOrderCommonView

-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self settingShadowOffset:CGSizeMake(3,5) shadowRadius:20 shadowColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor cornerRadius:10];
    }
    return self;
}

@end
