//
//  CodeTextDemo
//
//  Created by 小侯爷 on 2018/9/20.
//  Copyright © 2018年 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^HWTFCodeBViewBlock)(NSString *code);
/**
 * 基础版 - 方块
 */
@interface HWTFCodeBView : UIView

/// 当前输入的内容
@property (nonatomic, copy, readonly) NSString *code;

/// 当前输入的内容等于count
@property (nonatomic, copy) HWTFCodeBViewBlock codeBlock;

- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (void)beganEditing;
@end

NS_ASSUME_NONNULL_END
