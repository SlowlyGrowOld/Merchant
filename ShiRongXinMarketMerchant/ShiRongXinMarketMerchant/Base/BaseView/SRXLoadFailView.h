//
//  SRXLoadFailView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2022/9/22.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXLoadFailView : UIView

//初始化
+ (SRXLoadFailView *)initWithSuperView:(UIView *)superView btnBlock:(dispatch_block_t)block;
+ (SRXLoadFailView *)initWithSuperView:(UIView *)superView frame:(CGRect)frame  btnBlock:(dispatch_block_t)block;
- (instancetype)initWithFrame:(CGRect)frame btnBlock:(dispatch_block_t)block;
- (void)showWithSuperView:(UIView *)superView;

- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
