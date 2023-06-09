//
//  SRXGoodsSpecGroupTableVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/7.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SRXGoodsSpecGroupBlock)(NSArray *datas);

@interface SRXGoodsSpecGroupTableVC : RootViewController
@property (nonatomic, copy) NSString *goods_id;//用来保存上传的
@property (nonatomic, strong) NSArray *spec_attr;//规格数组，用来保存上传的
@property (nonatomic, strong) NSArray *spec_list;//组合成的参数列表，显示
@property (nonatomic, copy) SRXGoodsSpecGroupBlock datasBlock;
@end

NS_ASSUME_NONNULL_END
