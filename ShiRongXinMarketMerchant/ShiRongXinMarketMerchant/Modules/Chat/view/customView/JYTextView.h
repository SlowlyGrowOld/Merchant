//
//  JYTextView.h
//  JYImageTextCombine
//
//  Created by JackYoung on 2022/3/31.
//  Copyright © 2022 Jack Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYTextView : UITextView

@property (nonatomic, copy)void (^selectBlock)(NSString *selectedButtonTitle,NSString * selectedText,NSString *uid);
@property (nonatomic, strong)UIViewController *fatherViewController;
/**标识符---用来区分一个页面多个JYTextView回调问题，因为JYBubbleMenuView是单列*/
@property (nonatomic, copy)NSString *uid;
//取消文本选中效果
- (void)hideTextSelection;

@end

NS_ASSUME_NONNULL_END
