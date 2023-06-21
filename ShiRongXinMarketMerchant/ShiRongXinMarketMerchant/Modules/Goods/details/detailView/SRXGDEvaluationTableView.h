//
//  SRXGDEvaluationTableView.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/30.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXGoodsEvaluateListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^GetTagCollectionViewHeightBlock)(CGFloat height);
@interface SRXGDEvaluationTableView : UITableView
/** 数据 */
@property (nonatomic , strong) NSArray <SRXGELDataItem *>              * datas;
/**
 高度回调
 */
@property (nonatomic, copy) GetTagCollectionViewHeightBlock heightBlock;
@end

NS_ASSUME_NONNULL_END
