//
//  SRXMessage.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/28.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXMessage : NSObject
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * shop_id;
/***/
@property (nonatomic , copy) NSString              * msg_type;
/**参数，msg_type=user_order传订单id，msg_type=goods_link传商品id，msg_type=image或voice传图片路径，语音路径；msg_type=order_address传订单id*/
@property (nonatomic , copy) NSString              * params;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * duration;
@end

NS_ASSUME_NONNULL_END
