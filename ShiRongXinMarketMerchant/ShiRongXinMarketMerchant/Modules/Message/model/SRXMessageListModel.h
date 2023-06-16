//
//  SRXMessageListModel.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXBaseModel.h"
#import "SRXMessageSetModel.h"
NS_ASSUME_NONNULL_BEGIN
//聊天列表
@interface SRXMessageListModel : SRXBaseModel
@property (nonatomic , assign) NSInteger              _id;
@property (nonatomic , assign) NSInteger              unread;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * msg_type;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * send_time;
@property (nonatomic , assign) NSInteger              send_time_timestamp;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * nickname;
@end

//店铺未读
@interface SRXChatShopNumItem :NSObject
@property (nonatomic , copy) NSString              * shop_id;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * shop_img;
@property (nonatomic , assign) NSInteger              un_read_num;
@property (nonatomic , assign) BOOL              is_select;
@end

@interface SRXChatRecommentGoodsCoupon :NSObject
@property (nonatomic , assign) NSInteger              coupon_id;
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , assign) NSInteger              condition;
@property (nonatomic , copy) NSString              * use_end_time;
@property (nonatomic , assign) NSInteger              goods_id;

@end

//推荐商品
@interface SRXChatRecommentGoodsItem :NSObject
@property (nonatomic , copy) NSString              * goods_id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , strong) SRXChatRecommentGoodsCoupon              * coupon;

@end

@interface SRXChatOrderGoodsItem :NSObject
@property (nonatomic , assign) NSInteger              order_goods_id;
@property (nonatomic , assign) NSInteger              order_id;
@property (nonatomic , assign) NSInteger              goods_id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * spec_key_name;
@property (nonatomic , assign) NSInteger              order_delivery_id;

@end

//核对订单
@interface SRXChatOrderItem :SRXBaseModel
@property (nonatomic , assign) NSInteger              _id;
@property (nonatomic , copy) NSString              * order_sn;
@property (nonatomic , copy) NSString              * pay_status;
@property (nonatomic , copy) NSString              * shipping_amount;
@property (nonatomic , assign) NSInteger              deduct_score;
@property (nonatomic , copy) NSString              * pay_amount;
@property (nonatomic , copy) NSString              * consignee;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , assign) NSInteger              goods_count;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * full_address;
@property (nonatomic , strong) NSArray <SRXChatOrderGoodsItem *>              * order_goods;

@end

//客服转移
@interface SRXMsgChatServiceItem :NSObject
@property (nonatomic , copy) NSString              * shop_user_id;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , assign) NSInteger              chat_status;
/**聊天内容*/
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * shop_img;
@property (nonatomic , copy) NSString              * shop_id;
@end

@interface SRXMsgChatOrderNum :NSObject
@property (nonatomic , assign) NSInteger              to_be_pay_num;
@property (nonatomic , assign) NSInteger              to_be_delivery_num;
@property (nonatomic , assign) NSInteger              to_be_evaluate_num;

@end

//用户订单数量
@interface SRXMsgChatOther : NSObject
@property (nonatomic , strong) SRXMsgChatOrderNum              * order_num;
@property (nonatomic , strong) NSArray <SRXMsgLabelsItem *>              * user_labels;
@end


NS_ASSUME_NONNULL_END
