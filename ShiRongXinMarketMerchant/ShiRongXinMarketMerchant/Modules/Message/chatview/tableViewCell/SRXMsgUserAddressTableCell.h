//
//  SRXMsgShopAddressTableCell.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/18.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXMsgChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXMsgUserAddressTableCell : UITableViewCell
@property (nonatomic,strong) SRXMsgChatModel *model;
@property (nonatomic, copy) dispatch_block_t updateBlock;
@end

NS_ASSUME_NONNULL_END
