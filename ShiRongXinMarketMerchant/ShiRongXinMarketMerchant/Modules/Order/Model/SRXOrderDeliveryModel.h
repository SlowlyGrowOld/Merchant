//
//  SRXOrderDeliveryModel.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRXOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderDeliveryModel : NSObject
@property (nonatomic , assign) NSInteger              delivery_id;
@property (nonatomic , assign) NSInteger              order_id;
@property (nonatomic , copy) NSString              * express_code;
@property (nonatomic , copy) NSString              * express_sn;
@property (nonatomic , copy) NSString              * express_name;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , strong) NSArray <SRXOrderGoodsItem *>              * goods;
@end

@interface SRXDeliveryDetailsTracesItem :NSObject
@property (nonatomic , copy) NSString              * Action;
@property (nonatomic , copy) NSString              * AcceptStation;
@property (nonatomic , copy) NSString              * AcceptTime;
@property (nonatomic , copy) NSString              * Location;

@end


@interface SRXDeliveryDetailsTraces :NSObject
@property (nonatomic , copy) NSString              * full_address;
@property (nonatomic , strong) NSArray <SRXDeliveryDetailsTracesItem *>              * traces;

@end
NS_ASSUME_NONNULL_END
