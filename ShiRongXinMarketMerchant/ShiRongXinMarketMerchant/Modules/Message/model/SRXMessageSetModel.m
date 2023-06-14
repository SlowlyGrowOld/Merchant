//
//  SRXMessageSetModel.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMessageSetModel.h"

@implementation SRXMsgChatEvaluate

@end

@implementation SRXMsgChatWelcome

@end

@implementation SRXMsgLabelsItem

@end

@implementation SRXMsgReplysItem

@end

@implementation SRXMsgReplysGroupItem
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"replys":@"SRXMsgReplysItem"};
}
@end

@implementation SRXMessageSetModel

@end
