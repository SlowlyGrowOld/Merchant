//
//  SRXGDEvaluationTableCell.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/30.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXGoodsEvaluateListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXGDEvaluationTableCell : UITableViewCell
/** 数据 */
@property (nonatomic , strong) SRXGELDataItem              * dataItem;
@end

NS_ASSUME_NONNULL_END
