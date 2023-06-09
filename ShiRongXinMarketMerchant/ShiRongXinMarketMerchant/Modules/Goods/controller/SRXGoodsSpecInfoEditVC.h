//
//  SRXGoodsSpecInfoEditVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"
#import "SRXGoodsSpecModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^SRXGoodsSpecInfoEditBlock)( SRXGoodsSpecFormBatch * _Nullable batch);

@interface SRXGoodsSpecInfoEditVC : RootPresentViewController
@property (nonatomic, strong) SRXGoodsSpecListItem *item;
@property (nonatomic, copy) SRXGoodsSpecInfoEditBlock batchBlock;
@end

NS_ASSUME_NONNULL_END
