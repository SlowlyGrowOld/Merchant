//
//  SRXMessageListVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "JHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXMessageListVC : JHBaseTableViewController
@property (nonatomic, copy) NSString *search_word;
/**1=招待列表， 2=标记列表*/
@property (nonatomic, copy) NSString *chat_type;
@end

NS_ASSUME_NONNULL_END
