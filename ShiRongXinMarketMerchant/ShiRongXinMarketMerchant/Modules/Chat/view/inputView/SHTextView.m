//
//  SHTextView.m
//  Test
//
//  Created by CSH on 2018/6/12.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "SHTextView.h"

@interface SHTextView()

@end

@implementation SHTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //配置
        [self setup];
    }
    return self;
}

#pragma mark - 配置
- (void)setup{
    self.backgroundColor = [UIColor clearColor];
    self.textContainer.lineFragmentPadding = 0;
    self.textContainerInset = UIEdgeInsetsZero;
    self.dataDetectorTypes = UIDataDetectorTypePhoneNumber | UIDataDetectorTypeLink;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:@"换行" action:@selector(selfMenu:)];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    [menuController setMenuItems:[NSArray arrayWithObject:menuItem]];
   [menuController setMenuVisible:NO];
}
//
//#pragma mark 设置光标
//- (CGRect)caretRectForPosition:(UITextPosition *)position {
//    CGRect rect = [super caretRectForPosition:position];
//    CGFloat y = CGRectGetMidY(rect);
//    rect.size.height = self.font.lineHeight - 3;
//    rect.origin.y = y - 8;
//    return rect;
//}
//
- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset{
    CGFloat padding = self.textContainer.lineFragmentPadding;
    [super setTextContainerInset:UIEdgeInsetsMake(textContainerInset.top, textContainerInset.left - padding, textContainerInset.bottom, textContainerInset.right - padding)];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(selfMenu:)) {
        NSRange range = self.selectedRange;
        return range.length>0?NO:YES;
    } else if (action == @selector(copy:) || action == @selector(select:) || action == @selector(selectAll:) || action == @selector(cut:) || action == @selector(delete:) || action == @selector(paste:)) {
        BOOL isAppear = [super canPerformAction:action withSender:sender];
        return isAppear;
    }
    return NO;
}

- (void)selfMenu:(id)sender {
    NSRange range = self.selectedRange;
    NSMutableString *str = [[NSMutableString alloc] initWithString:self.text];
    [str insertString:@"\n" atIndex:range.location];
    self.text = str.copy;
    if ([self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:self];
    }
}

@end
