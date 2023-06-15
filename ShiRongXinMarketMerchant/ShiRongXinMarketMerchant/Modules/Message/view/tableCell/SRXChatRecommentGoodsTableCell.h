//
//  SRXMsgRecommentGoodsTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXMsgChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXChatRecommentGoodsTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *couponBtn;
@property (weak, nonatomic) IBOutlet UIButton *goodsBtn;
@property (nonatomic, strong) SRXMsgGoodsInfoItem *item;
@end

NS_ASSUME_NONNULL_END
