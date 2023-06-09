//
//  UIViewController+YCPopover.m
//  YCTransitionAnimation
//
//  Created by 蔡亚超 on 2018/5/17.
//  Copyright © 2018年 WellsCai. All rights reserved.
//

#import "UIViewController+YCPopover.h"
#import <objc/runtime.h>

static const char popoverAnimatorKey;

@implementation UIViewController (YCPopover)

- (YCPopoverAnimator *)popoverAnimator{
    return objc_getAssociatedObject(self, &popoverAnimatorKey);
}
- (void)setPopoverAnimator:(YCPopoverAnimator *)popoverAnimator{
    objc_setAssociatedObject(self, &popoverAnimatorKey, popoverAnimator, OBJC_ASSOCIATION_RETAIN) ;
}


- (void)yc_bottomPresentController:(UIViewController *)vc presentedHeight:(CGFloat)height isOnClickBackground:(BOOL)isOnClickBackground backgroundColor:(UIColor *)backgroundColor completeHandle:(YCCompleteHandle)completion{
    self.popoverAnimator = [YCPopoverAnimator popoverAnimatorWithStyle:YCPopoverTypeActionSheet isOnClickBackground:isOnClickBackground backgroundColor:backgroundColor completeHandle:completion];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self.popoverAnimator;
    vc.view.backgroundColor = [UIColor clearColor];
    [self.popoverAnimator setBottomViewHeight:height];

    [self presentViewController:vc animated:YES completion:nil];
}

- (void)yc_centerPresentController:(UIViewController *)vc presentedSize:(CGSize)size isOnClickBackground:(BOOL)isOnClickBackground backgroundColor:(UIColor *)backgroundColor completeHandle:(YCCompleteHandle)completion{
    self.popoverAnimator = [YCPopoverAnimator popoverAnimatorWithStyle:YCPopoverTypeAlert isOnClickBackground:isOnClickBackground backgroundColor:backgroundColor completeHandle:completion];
    [self.popoverAnimator setCenterViewSize:size];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self.popoverAnimator;
    vc.view.backgroundColor = [UIColor clearColor];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
