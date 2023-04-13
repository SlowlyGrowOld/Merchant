//
//  RootPresentViewController.h
//  SeaStarVoiceProject
//
//  Created by 薛静鹏 on 2020/1/10.
//  Copyright © 2020 薛静鹏. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RootPresentViewController : RootViewController
/** 是否点击收起 */
@property(nonatomic, assign) BOOL isBgClose;
/** 背景颜色 */
@property (nonatomic,strong) UIColor *bgColor;
@end

NS_ASSUME_NONNULL_END
