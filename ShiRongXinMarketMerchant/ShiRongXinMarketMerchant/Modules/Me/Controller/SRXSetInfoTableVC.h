//
//  SRXSetInfoTableVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXSetInfoTableVC : RootTableViewController
@property (nonatomic, copy) dispatch_block_t refreshBlock;
@end

NS_ASSUME_NONNULL_END
