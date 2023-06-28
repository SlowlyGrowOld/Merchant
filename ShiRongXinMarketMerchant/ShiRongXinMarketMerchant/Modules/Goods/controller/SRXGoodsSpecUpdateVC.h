//
//  SRXGoodsSpecUpdateVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXGoodsSpecUpdateVC : RootPresentViewController
@property (nonatomic, assign) BOOL isStore;//是否是更改库存
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, strong) NSArray *datas;
@end

NS_ASSUME_NONNULL_END
