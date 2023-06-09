//
//  SRXGoodsListTableVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "JHBaseTableViewController.h"
#import "SRXGoodsListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXGoodsListTableVC : JHBaseTableViewController
@property (nonatomic,assign) BOOL canScroll;
@property (nonatomic,assign) BOOL isPullDown;//父视图scrollview是否置顶，用来列表下拉操作问题
@property (nonatomic,assign) BOOL scrollTop;//切换菜单，列表置顶

@property (nonatomic,assign) BOOL isEdit;//编辑
@property (nonatomic,assign) BOOL isAllEdit;//全选编辑

/**默认1。1=出售中，2=编辑中，3=审核中，4=已下架*/
@property (nonatomic , copy) NSString              * goods_status;
/**搜索词*/
@property (nonatomic , copy) NSString              * search_word;

@property (nonatomic, strong) SRXGoodsListParameter *parameters;
@end

NS_ASSUME_NONNULL_END
