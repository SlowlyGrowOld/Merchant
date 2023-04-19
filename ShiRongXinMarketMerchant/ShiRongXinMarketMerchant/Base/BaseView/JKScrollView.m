//
//  JKScrollView.m
//  liandong
//
//  Created by 王先生 on 2022/9/20.
//

#import "JKScrollView.h"

@implementation JKScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (point.y>self.topOffset) {
        return [super hitTest:point withEvent:event];
    }
    return nil;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
@end
