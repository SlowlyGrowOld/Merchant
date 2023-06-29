//
//  SRXGoodsInfoEditShowVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/29.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootViewController.h"
#import "SRXGoodsEditInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SRXGoodsInfoEditBlock)(NSInteger index);

@interface SRXGoodsInfoEditShowVC : RootViewController
@property (nonatomic, strong) SRXGoodsEditInfoModel *editInfo;
@property (nonatomic, copy) SRXGoodsInfoEditBlock block;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, strong) NSMutableDictionary *parameters;
@end

NS_ASSUME_NONNULL_END
