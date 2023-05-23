//
//  SRXOrderDetailsModel.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderDUser_info :NSObject
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * consignee;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * full_address;
@property (nonatomic , copy) NSString              * remark;

@end


@interface SRXOrderDGoods_infoItem :NSObject
@property (nonatomic , assign) NSInteger              order_goods_id;
@property (nonatomic , assign) NSInteger              goods_id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              goods_num;
@property (nonatomic , copy) NSString              * spec_key_name;
@property (nonatomic , assign) CGFloat              shipping_amount;
@property (nonatomic , assign) CGFloat              total_amount;
@property (nonatomic , assign) NSInteger              order_delivery_id;
@end


@interface SRXOrderDOrder_info :NSObject
@property (nonatomic , copy) NSString              * order_sn;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * pay_type;
@property (nonatomic , copy) NSString              * pay_time;

@end


@interface SRXOrderDPay_info :NSObject
@property (nonatomic , copy) NSString              * goods_amount;
@property (nonatomic , copy) NSString              * shipping_amount;
@property (nonatomic , copy) NSString              * discount_money;
@property (nonatomic , copy) NSString              * deduct_amount;
@property (nonatomic , copy) NSString              * pay_amount;

@end


@interface SRXOrderDetailsModel :NSObject
/**1=待发货 2=待付款 3=待收货 4=已完成*/
@property (nonatomic , assign) NSInteger              progress_num;
@property (nonatomic , strong) SRXOrderDUser_info              * user_info;
@property (nonatomic , strong) NSArray <SRXOrderDGoods_infoItem *>              * goods_info;
@property (nonatomic , strong) SRXOrderDOrder_info              * order_info;
@property (nonatomic , strong) SRXOrderDPay_info              * pay_info;

@end


@interface SRXOrderDReturn_info : NSObject
@property (nonatomic , assign) NSInteger              refund_integral;
@property (nonatomic , copy) NSString              * pay_type;
@property (nonatomic , assign) CGFloat               pay_amount;
@property (nonatomic , copy) NSString              * shipping_amount;
@property (nonatomic , assign) NSInteger              refund_type;
@property (nonatomic , assign) NSInteger              refund_goods_status;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * reason;
@end

@interface SRXOrderAfterSaleDetails : NSObject
@property (nonatomic , assign) NSInteger              process_num;
@property (nonatomic , assign) NSInteger              now_process;
@property (nonatomic , strong) SRXOrderDGoods_infoItem              * goods_info;
@property (nonatomic , strong) SRXOrderDUser_info              * user_info;
@property (nonatomic , strong) SRXOrderDReturn_info              * return_info;
@property (nonatomic , strong) NSArray <NSString *>              * refund_images;
@end

NS_ASSUME_NONNULL_END
