//
//  CodeTextDemo
//
//  Created by 小侯爷 on 2018/9/20.
//  Copyright © 2018年 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HWTFCodeViewBlock)(NSString *code);
/**
 * 基础版 - 下划线
 */
@interface HWTFCodeView : UIView

/// 当前输入的内容
@property (nonatomic, copy, readonly) NSString *code;
/// 当前输入的内容等于count
@property (nonatomic, copy) HWTFCodeViewBlock codeBlock;
/// 是否弹出键盘
@property (nonatomic, assign) BOOL isEdit;

- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end



NS_ASSUME_NONNULL_END
