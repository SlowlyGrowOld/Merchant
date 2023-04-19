//
//  SortButton.h
//  ShiRongXinMarketMerchant
//
//  Created by 别天神 on 2021/9/4.
//  Copyright © 2021 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SortBlock)(BOOL isUp);
@interface SortButton : UIView

/**
 按钮标题
 */
@property (nonatomic, copy) NSString *buttonTitle;

/**
 排序回调
 */
@property (nonatomic, copy) SortBlock sortBlock;

@end

NS_ASSUME_NONNULL_END
