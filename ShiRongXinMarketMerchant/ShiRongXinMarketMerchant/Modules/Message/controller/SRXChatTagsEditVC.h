//
//  SRXChatTagsEditVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/13.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootViewController.h"
#import "SRXMessageSetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXChatTagsEditVC : RootViewController
@property (nonatomic, strong) SRXMsgLabelsItem *item;
@property (nonatomic, copy) dispatch_block_t refreshBlock;
@property (nonatomic, copy) NSString *shop_id;
@end

NS_ASSUME_NONNULL_END
