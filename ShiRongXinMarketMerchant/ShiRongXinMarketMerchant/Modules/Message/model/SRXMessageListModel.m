//
//  SRXMessageListModel.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMessageListModel.h"

@implementation SRXMessageListModel

@end

@implementation SRXChatShopNumItem

@end

@implementation SRXChatRecommentGoodsCoupon

@end

@implementation SRXChatRecommentGoodsItem

@end

@implementation SRXChatOrderGoodsItem

@end

@implementation SRXChatOrderItem
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"order_goods":@"SRXChatOrderGoodsItem"};
}
@end

@implementation SRXMsgChatShopItem

@end

@implementation SRXMsgChatOrderNum

@end

@implementation SRXMsgChatOther

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"user_labels":@"SRXMsgLabelsItem"};
}

@end

@implementation SRXMsgChatCoupnItem

@end
