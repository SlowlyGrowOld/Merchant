//
//  SRXMsgChatModel.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/18.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXMsgReferenceInfo : NSObject
@property (nonatomic , copy) NSString              * reference_type;
@property (nonatomic , copy) NSString              * reference_chat_id;
@property (nonatomic , copy) NSString              * reference_chat_content;
@end

@interface SRXMsgGoodsInfoItem :SRXBaseModel
@property (nonatomic , copy) NSString              * _id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * spec_key_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * price;
/**充值电话*/
@property (nonatomic , copy) NSString              * mobile;
/**充值时间*/
@property (nonatomic , copy) NSString              * create_time_text;
@property (nonatomic , copy) NSString              * order_id;
//自己添加参数
//common_goods、jx_goods、group_goods
@property (nonatomic , copy) NSString              * goods_type;
//团购
@property (nonatomic , assign) NSInteger              activity_id;
//咨询订单接口模型使用
@property (nonatomic , copy) NSString              * goods_id;
@end

@interface SRXMsgOrderInfo :NSObject
@property (nonatomic , copy) NSString              * order_id;
/**订单价格*/
@property (nonatomic , copy) NSString              * pay_amount;
/**是否确认地址:0=否,1=是*/
@property (nonatomic , assign) NSInteger              is_sure_address;
/**是否修改过地址:0=否,1=是：只能修改一次*/
@property (nonatomic , assign) NSInteger              is_change_address;
/**是否修改过地址:0=否,1=是：只能修改一次*/
@property (nonatomic , assign) NSInteger              can_change_address;
@property (nonatomic , copy) NSString              * consignee;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * order_sn;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , assign) NSInteger              order_status;
@property (nonatomic , assign) NSInteger              pay_status;
@property (nonatomic , assign) NSInteger              goods_count;
/**充值使用的积分*/
@property (nonatomic , assign) NSInteger              score;
@property (nonatomic , strong) NSArray <SRXMsgGoodsInfoItem *>              * goods_info;
@property (nonatomic , copy) NSString              * full_address;

@property (nonatomic , strong) NSArray <SRXMsgGoodsInfoItem *>              * order_goods_info;
/**msg_type=fulu_order，充值的订单;msg_type=user_order商品订单*/
@property (nonatomic , copy) NSString              * msg_type;

/**充值订单模型*/
//@property (nonatomic , copy) NSString              * order_id;
@property (nonatomic , copy) NSString              * pay_sn;
@property (nonatomic , copy) NSString              * goods_name;
//@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * recharge_status;
//@property (nonatomic , copy) NSString              * pay_amount;
//@property (nonatomic , copy) NSString              * score;
@property (nonatomic , copy) NSString              * recharge_type;
//@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * goods_image;
@end

@interface SRXMsgChatModel : SRXBaseModel
@property (nonatomic , copy) NSString              * _id;
/**发送时间*/
@property (nonatomic , copy) NSString              * send_time;
/**语音时长*/
@property (nonatomic , copy) NSString              * duration;//发送可传
/**类型*/
@property (nonatomic , copy) NSString              * msg_type;//发送必传
/**谁发送的，shop是商家，user是用户*/
@property (nonatomic , copy) NSString              * who_send;//发送必传
@property (nonatomic , copy) NSString              * params;//发送可传
@property (nonatomic , copy) NSString              * avatar;
/**发送者昵称*/
@property (nonatomic , copy) NSString              * nickname;
/**聊天内容，msg_type=text时*/
@property (nonatomic , copy) NSString              * content;//发送可传
/**是否举报了，0=否，1=是*/
@property (nonatomic , assign) NSInteger             is_report;
/**msg_type=order_address时有数据*/
@property (nonatomic , strong) SRXMsgOrderInfo              * order_address_info;
/**msg_type=user_order时有数据*/
@property (nonatomic , strong) SRXMsgOrderInfo              * order_info;
/**msg_type=goods_link时有数据*/
@property (nonatomic , strong) SRXMsgGoodsInfoItem          * goods_info;
/**msg_type=fulu_order时有数据*/
@property (nonatomic , strong) SRXMsgOrderInfo          * fulu_order_info;
/**msg_type=text并有引用时有数据*/
@property (nonatomic , strong) SRXMsgReferenceInfo          * reference_info;

/**--自己添加的参数--*/
//发送文本，引用的id
@property (nonatomic , copy) NSString              * reference_chat_id;
//发送文本，引用的文本
@property (nonatomic , copy) NSString              *reference_chat_content;
/**发送商品区别类型： common_goods、jx_goods、group_goods*/
@property (nonatomic , copy) NSString              * goods_type;
/**发送团购商品需要*/
@property (nonatomic , assign) NSInteger              activity_id;
//发送消息的唯一标识  用来失败重发
@property (nonatomic , copy) NSString              * messageKey;
//发送的本人id
@property (nonatomic , copy) NSString              * uid;
//发送的本地图片
@property (nonatomic , strong) UIImage              * image;
//发送的音频
@property (nonatomic , copy) NSString              * voice;
//发送的shop_id
@property (nonatomic , copy) NSString              * user_id;
//音频播放
@property (nonatomic , assign) BOOL              isPlaying;

//消息状态
@property (nonatomic, assign) SRXSendMessageStatus messageState;


+ (SRXMsgChatModel *)receiveMessageWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
