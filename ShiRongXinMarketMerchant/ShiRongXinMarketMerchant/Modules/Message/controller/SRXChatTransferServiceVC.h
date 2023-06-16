//
//  SRXChatTransferServiceVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/16.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"
#import "NetworkManager+Message.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SRXChatTransferServiceBlock)(SRXMsgChatServiceItem *item);

@interface SRXChatTransferServiceVC : RootPresentViewController
@property (nonatomic, copy) SRXChatTransferServiceBlock serviceBlock;
@end

NS_ASSUME_NONNULL_END
