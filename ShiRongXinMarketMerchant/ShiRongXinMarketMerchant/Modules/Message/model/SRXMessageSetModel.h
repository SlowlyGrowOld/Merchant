//
//  SRXMessageSetModel.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXMsgChatEvaluate:NSObject
@property (nonatomic , assign) NSInteger              is_auto_invite;
@property (nonatomic , copy) NSString              * invite_content;

@end

@interface SRXMsgChatWelcome :NSObject
@property (nonatomic , assign) NSInteger              is_auto_welcome;
@property (nonatomic , copy) NSString              * welcome_content;
@property (nonatomic , copy) NSString              * welcome_img;

@end

@interface  SRXMsgLabelsItem :NSObject
@property (nonatomic , copy) NSString              * label_id;
@property (nonatomic , copy) NSString              * label_name;
@property (nonatomic , copy) NSString              * label_color_number;

@property (nonatomic , assign) BOOL              is_select;

@end

@interface SRXMsgReplysItem :NSObject
@property (nonatomic , copy) NSString              * reply_id;
@property (nonatomic , copy) NSString              * reply_content;
@property (nonatomic , copy) NSString              * group_id;
@property (nonatomic , copy) NSString              * group_name;
@property (nonatomic , copy) NSString              * reply_img;

@end


@interface SRXMsgReplysGroupItem :NSObject
@property (nonatomic , copy) NSString              * group_id;
@property (nonatomic , copy) NSString              * group_name;
@property (nonatomic , strong) NSArray <SRXMsgReplysItem *>              * replys;
@property (nonatomic , assign) BOOL              is_select;
@end

@interface SRXMessageSetModel : NSObject

@end

NS_ASSUME_NONNULL_END
