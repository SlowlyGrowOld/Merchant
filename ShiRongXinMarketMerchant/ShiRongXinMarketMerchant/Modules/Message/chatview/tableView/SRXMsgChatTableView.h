//
//  SRXMsgChatTableView.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/20.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXMsgChatTableView : UITableView
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) NSString *shop_id;
@end

NS_ASSUME_NONNULL_END
