//
//  SRXMsgUserOrderTableCell.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/26.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXMsgChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXMsgUserOrderTableCell : UITableViewCell
@property (nonatomic,strong) SRXMsgChatModel *model;
@property (nonatomic, copy) NSString *shop_id;

@end

NS_ASSUME_NONNULL_END
