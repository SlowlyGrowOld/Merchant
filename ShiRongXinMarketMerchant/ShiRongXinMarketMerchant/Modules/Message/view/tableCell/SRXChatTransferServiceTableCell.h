//
//  SRXChatTransferServiceTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/16.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXMessageListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXChatTransferServiceTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *transferBtn;
@property (nonatomic, strong) SRXMsgChatServiceItem *service;
@end

NS_ASSUME_NONNULL_END
