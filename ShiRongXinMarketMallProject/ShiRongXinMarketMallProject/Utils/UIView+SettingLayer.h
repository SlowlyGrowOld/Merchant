//
//  UIView+SettingLayer.h
//  SeaStarVoiceProject
//
//  Created by 薛静鹏 on 2019/9/19.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SettingLayer)

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
-(void)settingShadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius shadowColor:(CGColorRef)shadowColor  cornerRadius:(CGFloat)cornerRadius colors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
/**
 视图设置阴影
 
 @param shadowOffset  shadowOffset
 @param shadowRadius shadowRadius
 @param shadowColor shadowColor
 @param cornerRadius cornerRadius
 */
-(void)settingShadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius shadowColor:(CGColorRef)shadowColor  cornerRadius:(CGFloat)cornerRadius;

/**
 切视图圆角
 
 @param radius 角度
 @param corner 方向
 */
-(void)settingRadius:(CGFloat)radius corner:(UIRectCorner)corner;
@end

NS_ASSUME_NONNULL_END
