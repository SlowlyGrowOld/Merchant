//
//  UIColor+JHExt.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/19.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JHExt)
/// 字符串转颜色 比如#888888、0x888888
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
