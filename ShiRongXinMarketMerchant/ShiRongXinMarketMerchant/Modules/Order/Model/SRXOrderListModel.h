//
//  SRXOrderListModel.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderGoodsItem :NSObject
@property (nonatomic , assign) NSInteger              order_goods_id;
@property (nonatomic , assign) NSInteger              order_id;
@property (nonatomic , assign) NSInteger              goods_id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * spec_key_name;
@property (nonatomic , assign) NSInteger              order_delivery_id;

@end

@interface SRXOrderListModel : NSObject
@property (nonatomic , copy) NSString              * order_id;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * shipping_amount;
@property (nonatomic , copy) NSString              * deduct_amount;
@property (nonatomic , copy) NSString              * pay_amount;
@property (nonatomic , copy) NSString              * consignee;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * pay_status;
@property (nonatomic , copy) NSString              * shipping_status;
@property (nonatomic , copy) NSString              * order_status;
@property (nonatomic , assign) NSInteger              goods_count;
@property (nonatomic , copy) NSString              * admin_note;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * full_address;
@property (nonatomic , strong) NSArray <SRXOrderGoodsItem *>              * order_goods;

@end

@interface SRXOrderAfterSaleListModel : SRXOrderListModel
@property (nonatomic , assign) NSInteger              order_return_id;
@property (nonatomic , assign) NSInteger              order_goods_id;
@property (nonatomic , copy) NSString              * reason;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              refund_integral;
@property (nonatomic , copy) NSString              * refund_money;
@property (nonatomic , copy) NSString              * refund_deposit;
@property (nonatomic , copy) NSString              * goods_status;
@property (nonatomic , copy) NSString              * pay_type;
@end
NS_ASSUME_NONNULL_END
