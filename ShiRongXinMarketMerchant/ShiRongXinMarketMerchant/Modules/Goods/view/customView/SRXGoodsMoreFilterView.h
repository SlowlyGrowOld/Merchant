//
//  SRXGoodsMoreFilterView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXGoodsListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SRXGoodsMoreFilterBlock)(SRXGoodsListParameter*__nullable parameters);
@interface SRXGoodsMoreFilterView : UIView
@property (nonatomic, strong) SRXGoodsListParameter *parameters;
@property (nonatomic, copy) SRXGoodsMoreFilterBlock closeBlock;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
