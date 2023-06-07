//
//  SRXShopClassFilterView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXGoodsListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SRXShopClassFilterBlock)(SRXGoodsListParameter*__nullable parameters);
@interface SRXShopClassFilterView : UIView
@property (nonatomic, strong) SRXGoodsListParameter *parameters;
@property (nonatomic, copy) SRXShopClassFilterBlock closeBlock;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
