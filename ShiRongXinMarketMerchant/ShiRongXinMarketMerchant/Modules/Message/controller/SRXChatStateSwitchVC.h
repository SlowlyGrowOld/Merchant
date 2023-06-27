//
//  SRXChatStateSwitchVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SRXChatStateSwitchBlock)(NSUInteger type);

@interface SRXChatStateSwitchVC : RootPresentViewController
@property (nonatomic, copy) SRXChatStateSwitchBlock stateBlock;
@property (nonatomic, copy) NSString *shop_id;
@end

NS_ASSUME_NONNULL_END
