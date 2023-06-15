//
//  SRXMsgRecommentGoodsVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "JHBaseTableViewController.h"
#import "SRXMsgChatModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^SRXChatRecommentGoodsBlock)(SRXMsgGoodsInfoItem *goods,BOOL isSendGoods);

@interface SRXChatRecommentGoodsVC : JHBaseTableViewController
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) SRXChatRecommentGoodsBlock clickBlock;
@end

NS_ASSUME_NONNULL_END
