//
//  SRXGoodsListTableVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "JHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXGoodsListTableVC : JHBaseTableViewController
@property (nonatomic,assign) BOOL canScroll;
@property (nonatomic,assign) BOOL isPullDown;//父视图scrollview是否置顶，用来列表下拉操作问题
@property (nonatomic,assign) BOOL scrollTop;//切换菜单，列表置顶

@property (nonatomic,assign) BOOL isEdit;//编辑
@end

NS_ASSUME_NONNULL_END
