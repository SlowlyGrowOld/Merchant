//
//  NSMutableAttributedString+JHExt.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/5/26.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (JHExt)

//价格99.88  小数点前后字体大小不一
+(NSMutableAttributedString *)setPriceText:(NSString *)Text frontFont:(CGFloat)frontFont behindFont:(CGFloat)behindFont textColor:(UIColor *)textColor;

+ (NSMutableAttributedString *)attributedStingWithString:(NSString *)string font:(UIFont *)font textColor:(UIColor *)color lineSpacing:(CGFloat)lineSpacing;

+ (NSMutableAttributedString *)attributedStingWithString:(NSString *)string font:(UIFont *)font textColor:(UIColor *)color lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment)alignment;
+ (NSMutableAttributedString *)attributedStingWithString:(NSString *)string tag:(NSString *)tag;
@end

NS_ASSUME_NONNULL_END
