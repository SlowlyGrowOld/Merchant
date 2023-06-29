//
//  SRXChatTransferShopTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/29.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXChatTransferShopTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *service_image;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UIButton *transferBtn;
@end

NS_ASSUME_NONNULL_END
