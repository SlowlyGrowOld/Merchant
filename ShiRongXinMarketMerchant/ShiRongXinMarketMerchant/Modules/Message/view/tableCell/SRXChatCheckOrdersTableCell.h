//
//  SRXMsgCheckOrdersTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXChatCheckOrdersTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *sendMsgBtn;
@property (nonatomic, strong) SRXOrderListModel *model;
@property (nonatomic, copy) NSString *shop_id;
@end

NS_ASSUME_NONNULL_END
