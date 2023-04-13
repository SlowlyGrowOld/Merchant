//
//  NSMutableAttributedString+JHExt.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/5/26.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "NSMutableAttributedString+JHExt.h"

@implementation NSMutableAttributedString (JHExt)
+(NSMutableAttributedString *)setPriceText:(NSString *)Text frontFont:(CGFloat)frontFont behindFont:(CGFloat)behindFont textColor:(UIColor *)textColor{
    
    Text = [NSString stringWithNumber:@(Text.floatValue) formatter:@"#.##"];
    //分隔字符串
    NSString *lastStr;
    NSString *firstStr;
    
    if ([Text containsString:@"."]) {
        NSRange range = [Text rangeOfString:@"."];
        lastStr = [Text substringFromIndex:range.location];
        firstStr = [Text substringToIndex:range.location];
    }

    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:Text];
    
    //小数点前面的字体大小
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont boldSystemFontOfSize:frontFont]
                          range:NSMakeRange(0, firstStr.length)];
    
    //小数点后面的字体大小
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont boldSystemFontOfSize:behindFont]
                          range:NSMakeRange(firstStr.length, lastStr.length)];
    //字符串的颜色
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:textColor
                          range:NSMakeRange(0, Text.length)];
    
    return AttributedStr;
}

+ (NSMutableAttributedString *)attributedStingWithString:(NSString *)string font:(UIFont *)font textColor:(UIColor *)color lineSpacing:(CGFloat)lineSpacing {
    
    return [self attributedStingWithString:string font:font textColor:color lineSpacing:lineSpacing alignment:NSTextAlignmentLeft];
}

+ (NSMutableAttributedString *)attributedStingWithString:(NSString *)string font:(UIFont *)font textColor:(UIColor *)color lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment)alignment{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    [style setAlignment:alignment];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:style}];
    return attStr;
}

+ (NSMutableAttributedString *)attributedStingWithString:(NSString *)string tag:(NSString *)tag{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5; //字体的行间距
    //创建  NSMutableAttributedString 富文本对象
    NSMutableAttributedString *maTitleString = [[NSMutableAttributedString alloc] initWithString:string];

    //创建一个小标签的Label
    NSInteger width = tag.length*12+8;
    UILabel *aaL = [UILabel new];
    aaL.frame = CGRectMake(0, 0, width, 15);
    aaL.text = tag;
    aaL.font = [UIFont boldSystemFontOfSize:12];
    aaL.textColor = [UIColor whiteColor];
    aaL.backgroundColor = UIColorHex(0xF75847);
    aaL.clipsToBounds = YES;
    aaL.layer.cornerRadius = 3;
    aaL.textAlignment = NSTextAlignmentCenter;
    
    UIView *tagView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width+2, 15)];
    tagView.backgroundColor = UIColor.whiteColor;
    [tagView addSubview:aaL];
    //调用方法，转化成Image
    UIImage *image = [UIImage imageWithUIView:tagView];
    //创建Image的富文本格式
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.bounds = CGRectMake(0, -2.5, width+2, 15); //这个-2.5是为了调整下标签跟文字的位置
    attach.image = image;
    //添加到富文本对象里
    NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:attach];
    [maTitleString insertAttributedString:imageStr atIndex:0];//加入文字前面
    [maTitleString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, maTitleString.length)];
    
    return maTitleString;
}
@end
