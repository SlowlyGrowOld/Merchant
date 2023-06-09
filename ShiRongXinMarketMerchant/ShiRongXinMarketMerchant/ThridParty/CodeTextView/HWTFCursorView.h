//
//  HWTFCursorView.h
//  CodeTextDemo
//
//  Created by 侯万 on 2018/12/13.
//  Copyright © 2018 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HWTFCursorViewBlock)(NSString *code);
/**
 基础版 - 下划线 - 有光标
 */
@interface HWTFCursorView : UIView


// ----------------------------Data----------------------------
/// 当前输入的内容
@property (nonatomic, copy, readonly) NSString *code;
/// 当前输入的内容等于count
@property (nonatomic, copy) HWTFCursorViewBlock block;

// ----------------------------Method----------------------------

- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (void)beganEditing;
@end




// ------------------------------------------------------------------------
// -----------------------------HWCursorLabel------------------------------
// ------------------------------------------------------------------------


@interface HWCursorLabel : UILabel

@property (nonatomic, weak, readonly) UIView *cursorView;

- (void)startAnimating;
- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
