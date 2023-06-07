//
//  SRXCreateTimeFilterView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXGoodsListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXCreateTimeFilterView : UIView
@property (nonatomic, strong) SRXGoodsListParameter *parameters;
@property (nonatomic, copy) dispatch_block_t removeBlock;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
