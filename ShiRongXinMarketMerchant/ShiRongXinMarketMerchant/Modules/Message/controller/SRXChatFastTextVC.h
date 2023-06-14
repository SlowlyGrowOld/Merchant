//
//  SRXChatFastTextVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootViewController.h"
#import "SRXMessageSetModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SRXChatFastTextTypePhrase,
    SRXChatFastTextTypeWelcome,
    SRXChatFastTextTypeEvaluate,
} SRXChatFastTextType;

@interface SRXChatFastTextVC : RootViewController
@property (nonatomic, assign) SRXChatFastTextType type;
@property (nonatomic, strong) SRXMsgReplysItem *replys;
@property (nonatomic, copy) NSString *group_id;
@property (nonatomic, copy) NSString *group_name;

@property (nonatomic, copy) dispatch_block_t refreshBlock;
@end

NS_ASSUME_NONNULL_END
