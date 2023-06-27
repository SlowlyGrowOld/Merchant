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
    SRXChatFastTextTypePhrase,//短语
    SRXChatFastTextTypeWelcome,//欢迎语
    SRXChatFastTextTypeEvaluate,//评价
} SRXChatFastTextType;

@interface SRXChatFastTextVC : RootViewController
@property (nonatomic, assign) SRXChatFastTextType type;
@property (nonatomic, strong) SRXMsgReplysItem *replys;
@property (nonatomic, copy) NSString *group_id;
@property (nonatomic, copy) NSString *group_name;

@property (nonatomic, copy) NSString *shop_id;

@property (nonatomic, copy) dispatch_block_t refreshBlock;
@end

NS_ASSUME_NONNULL_END
