//
//  UIView+TouchExtend.m
//  FrontRow
//
//  Created by Neil on 2017/5/18.
//  Copyright © 2017年 UBNT. All rights reserved.
//

#import "UIView+TouchExtend.h"
#import <objc/runtime.h>

@implementation UIView (TouchExtend)

static char _extendTouchInsetKey;

- (UIEdgeInsets)fr_extendTouchInset {
    NSValue *value = objc_getAssociatedObject(self, &_extendTouchInsetKey);
    if (value) {
        return [value UIEdgeInsetsValue];
    } else {
        return UIEdgeInsetsZero;
    }
}

- (void)setFr_extendTouchInset:(UIEdgeInsets)fr_extendTouchInset {
    objc_setAssociatedObject(self, &_extendTouchInsetKey, [NSValue valueWithUIEdgeInsets:fr_extendTouchInset], OBJC_ASSOCIATION_RETAIN);
}

+ (void)load {
    SEL original = @selector(pointInside:withEvent:);
    SEL now = @selector(fr_pointInside:withEvent:);
    Method originalMethod = class_getInstanceMethod(self, original);
    Method nowMethod = class_getInstanceMethod(self, now);
    
    method_exchangeImplementations(originalMethod, nowMethod);
}

- (BOOL)fr_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    NSValue *value = objc_getAssociatedObject(self, &_extendTouchInsetKey);
    if (value) {
        UIEdgeInsets extendTouchInset = [value UIEdgeInsetsValue];
        bounds.origin.x -= extendTouchInset.left;
        bounds.origin.y -= extendTouchInset.top;
        bounds.size.width += extendTouchInset.left + extendTouchInset.right;
        bounds.size.height += extendTouchInset.top + extendTouchInset.bottom;
      
        if (CGRectContainsPoint(bounds, point)) {
            return YES;
        }
        return NO;
    } else {
        return [self fr_pointInside:point withEvent:event];
    }
}

@end
