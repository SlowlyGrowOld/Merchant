//
//  UILabel+Line.m
//  OneShoppingMallProject
//
//  Created by 薛静鹏 on 2020/11/4.
//

#import "UILabel+Line.h"

@implementation UILabel (Line)
-(void)setDeleteLine {
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.text]];
    [newStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newStr.length)];
    self.attributedText = newStr;
}

-(void)setUnderLine {
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.text]];
    [newStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, newStr.length)];
    self.attributedText = newStr;
}

@end
