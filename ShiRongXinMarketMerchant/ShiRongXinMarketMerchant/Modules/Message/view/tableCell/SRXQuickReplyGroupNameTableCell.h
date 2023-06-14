//
//  SRXQuickReplyGroupNameTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/13.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXQuickReplyGroupNameTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIView *imgView;

@end

NS_ASSUME_NONNULL_END
