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
@property (nonatomic , copy) NSString              * order_goods_id;
@property (nonatomic , assign) NSInteger              order_id;
@property (nonatomic , assign) NSInteger              goods_id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * spec_key_name;
@property (nonatomic , assign) NSInteger              order_delivery_id;

@property (nonatomic , assign) BOOL              isSelect;
@end

@interface SRXOrderListModel : NSObject
@property (nonatomic , copy) NSString              * order_id;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * order_sn;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , assign) CGFloat               shipping_amount;
@property (nonatomic , copy) NSString              * deduct_amount;
@property (nonatomic , assign) CGFloat               pay_amount;
@property (nonatomic , copy) NSString              * consignee;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * pay_status;
@property (nonatomic , copy) NSString              * shipping_status;
@property (nonatomic , assign) NSInteger              order_status;
@property (nonatomic , assign) NSInteger              goods_count;
@property (nonatomic , copy) NSString              * admin_note;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * full_address;
@property (nonatomic , strong) NSArray <SRXOrderGoodsItem *>              * order_goods;

@end

@interface SRXOrderAfterSaleListModel : NSObject
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , assign) CGFloat               shipping_amount;
@property (nonatomic , copy) NSString              * order_id;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , assign) CGFloat               pay_amount;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * order_return_id;
@property (nonatomic , assign) NSInteger              order_goods_id;
@property (nonatomic , copy) NSString              * reason;
/**退款类型 0=仅退款,1=退货退款,2=换货,3=仅退商品费,4=仅退运费*/
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * type_cn;
/**状态 0=售后中，-1=不同意，5=已退款*/
@property (nonatomic , assign) NSInteger              status;
/**退款积分*/
@property (nonatomic , assign) NSInteger              refund_integral;
/**退还微信，支付宝金额*/
@property (nonatomic , assign) CGFloat              refund_money;
/**退款余额*/
@property (nonatomic , assign) CGFloat              refund_deposit;
/**货物状态:0=未收到货,1=已收到货*/
@property (nonatomic , copy) NSString              * goods_status;
/**退还微信还是支付宝，wechat=微信,alipay=支付宝，其他不显示*/
@property (nonatomic , copy) NSString              * pay_type;

@property (nonatomic , strong) SRXOrderGoodsItem     * order_goods;
@end
NS_ASSUME_NONNULL_END
