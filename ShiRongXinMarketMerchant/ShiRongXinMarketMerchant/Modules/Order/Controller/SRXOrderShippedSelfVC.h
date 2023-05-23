//
//  SRXOrderShippedSelfVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/22.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderShippedSelfVC : RootPresentViewController
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) dispatch_block_t closeBlock;
@end

NS_ASSUME_NONNULL_END
