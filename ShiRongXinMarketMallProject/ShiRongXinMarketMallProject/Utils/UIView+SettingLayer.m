//
//  UIView+SettingLayer.m
//  SeaStarVoiceProject
//
//  Created by 薛静鹏 on 2019/9/19.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import "UIView+SettingLayer.h"

@implementation UIView (SettingLayer)
/**
 视图设置阴影圆角渐变
 
 @param shadowOffset shadowOffset
 @param shadowRadius shadowRadius
 @param shadowColor shadowColor
 @param cornerRadius 圆角度数
 @param colors 渐变颜色
 @param locations locations
 @param startPoint 开始点
 @param endPoint 结束点
 */
-(void)settingShadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius shadowColor:(CGColorRef)shadowColor  cornerRadius:(CGFloat)cornerRadius colors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:gradientLayer atIndex:0];
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.cornerRadius = cornerRadius;
    self.layer.shadowColor = shadowColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOpacity = 1;
    self.layer.masksToBounds = NO;
}

/**
 视图设置阴影
 
 @param shadowOffset  shadowOffset
 @param shadowRadius shadowRadius
 @param shadowColor shadowColor
 @param cornerRadius cornerRadius
 */
-(void)settingShadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius shadowColor:(CGColorRef)shadowColor  cornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOpacity = 1;
    self.layer.cornerRadius = cornerRadius;
}
/**
 切视图圆角
 
 @param radius 角度
 @param corner 方向
 */
-(void)settingRadius:(CGFloat)radius corner:(UIRectCorner)corner{
    self.clipsToBounds = YES;
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = (CACornerMask)corner;
    } else {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
}
@end
