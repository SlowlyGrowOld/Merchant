//
//  SRXBasePopupVC.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/6/29.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXBasePopupVC : UIViewController
@property (nonatomic, strong) UIView    *bottomView;
@property (nonatomic, strong) UIView    *contentView;
@property (nonatomic, strong) UILabel   *titleLb;
@property (nonatomic, strong) UIButton  *closeBtn;
@property (nonatomic, assign) CGFloat   headHeight;
- (void)dismissVC;
@end

NS_ASSUME_NONNULL_END
