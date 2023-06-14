//
//  SRXMsgChatModel.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/18.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgChatModel.h"

@implementation SRXMsgReferenceInfo

@end

@implementation SRXMsgGoodsInfoItem

@end

@implementation SRXMsgOrderInfo
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goods_info":@"SRXMsgGoodsInfoItem",
             @"order_goods_info":@"SRXMsgGoodsInfoItem"
    };
}
- (NSArray<SRXMsgGoodsInfoItem *> *)goods_info {
    if (_goods_info) {
        return _goods_info;
    }
    return _order_goods_info;
}
@end

@implementation SRXMsgChatModel
+ (SRXMsgChatModel *)receiveMessageWithDic:(NSDictionary *)dic {
    SRXMsgChatModel *model = [SRXMsgChatModel mj_objectWithKeyValues:dic];
    model.who_send = @"shop";
    NSDictionary *data = dic[@"data"];
    model.order_address_info = [SRXMsgOrderInfo mj_objectWithKeyValues:data[@"order_address"]];
    model.goods_info = [SRXMsgGoodsInfoItem mj_objectWithKeyValues:data[@"goods_info"]];
    model.order_info = [SRXMsgOrderInfo mj_objectWithKeyValues:data[@"order_info"]];
    NSString *voice = data[@"voice"];
    NSString *image = data[@"image"];
    if (voice.length>0) {
        model.params = voice;
    }
    if (image.length>0) {
        model.params = image;
    }
    return model;
}
@end
