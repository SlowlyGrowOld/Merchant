//
//  SRXChatUserInfoHeadView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/19.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXMessageListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXChatUserInfoHeadView : UIView
@property (nonatomic, copy) NSString  *user_id;
@property (nonatomic, copy) NSString  *shop_id;
@property (nonatomic, strong) SRXMsgChatOther *other;
@property (nonatomic, copy) dispatch_block_t refreshBlock;
@end

NS_ASSUME_NONNULL_END
