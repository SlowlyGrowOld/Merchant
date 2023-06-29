//
//  SRXChatTransferShopVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/29.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"
#import "NetworkManager+Message.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SRXChatTransferShopBlock)(SRXChatShopNumItem *shop);
@interface SRXChatTransferShopVC : RootPresentViewController
@property (nonatomic, copy) SRXChatTransferShopBlock serviceBlock;
@end

NS_ASSUME_NONNULL_END
