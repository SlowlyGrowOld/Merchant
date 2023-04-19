//
//  SRXPullTableView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2022/5/16.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXPullTableView.h"

@implementation SRXPullTableView

//设置内边距外区域的点击不响应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (point.y < 0)
    {
        return nil;
    }
    return [super hitTest:point withEvent:event];;
}

@end
