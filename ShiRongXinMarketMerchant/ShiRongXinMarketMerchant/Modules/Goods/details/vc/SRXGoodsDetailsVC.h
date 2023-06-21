//
//  SRXGoodsDetailsVC.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/12/21.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "RootTableViewController.h"
#import "SRXGoodsListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXGoodsDetailsVC : RootTableViewController
/** 商品详情类型 */
@property(nonatomic, copy) NSString  *goods_id;

/**  */
@property (nonatomic,strong) SRXGoodsListModel *goodsListModel;
@end

NS_ASSUME_NONNULL_END
