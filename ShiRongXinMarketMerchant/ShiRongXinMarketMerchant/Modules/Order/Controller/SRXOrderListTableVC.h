//
//  SRXOrderListTableVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/20.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "JHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXOrderListTableVC : JHBaseTableViewController
@property (nonatomic,assign) BOOL canScroll;
@property (nonatomic,assign) BOOL isPullDown;//父视图scrollview是否置顶，用来列表下拉操作问题
@property (nonatomic,assign) BOOL scrollTop;//切换菜单，列表置顶

/**1=待发货 2=待付款 3=待收货 4=已完成*/
@property (nonatomic, copy) NSString *order_type;
@property (nonatomic, copy) NSString *search_word;
@end

NS_ASSUME_NONNULL_END
