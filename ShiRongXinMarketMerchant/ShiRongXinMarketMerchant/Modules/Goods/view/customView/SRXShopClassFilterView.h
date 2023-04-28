//
//  SRXShopClassFilterView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXShopClassFilterView : UIView
@property (nonatomic, copy) dispatch_block_t removeBlock;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
