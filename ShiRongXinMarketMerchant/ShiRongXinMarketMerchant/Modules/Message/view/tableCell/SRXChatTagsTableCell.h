//
//  SRXChatTagsTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/13.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXMessageSetModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXChatTagsTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (nonatomic, strong) SRXMsgLabelsItem *item;
@end

NS_ASSUME_NONNULL_END
