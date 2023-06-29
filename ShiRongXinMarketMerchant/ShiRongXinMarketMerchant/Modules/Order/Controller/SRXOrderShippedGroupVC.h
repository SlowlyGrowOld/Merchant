//
//  SRXOrderShippedGroupVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/23.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SRXOrderShippedTypeAll,
    SRXOrderShippedTypeGoods,
} SRXOrderShippedType;

@interface SRXOrderShippedGroupVC : RootViewController
@property (nonatomic , copy) NSString *shop_id;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) dispatch_block_t closeBlock;
@property (nonatomic, assign) SRXOrderShippedType type;
@end

NS_ASSUME_NONNULL_END
