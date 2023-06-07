//
//  SRXGoodsEditQuitAlertVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/6.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXGoodsEditQuitAlertVC : RootPresentViewController
@property (nonatomic, copy) dispatch_block_t quitBlock;
@end

NS_ASSUME_NONNULL_END
