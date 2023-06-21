//
//  SRXPopFeatureSelectionVC.h
//  ShiRongXinMarketMallProject
//
//  Created by 薛静鹏 on 2020/3/18.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"
#import "SRXAllTheGoodsModel.h"


NS_ASSUME_NONNULL_BEGIN


typedef void(^SRXPopFeatureSelectionBlock)(NSString *str);
typedef void(^SelectionBlock)(SRXAllTheGoodsModel *model);

@interface SRXPopFeatureSelectionVC : RootPresentViewController
/** 规格弹窗类型 */
@property(nonatomic, assign) SRXPopFeatureSelectionType type;
/** 商品模型 */
@property (nonatomic,strong) SRXAllTheGoodsModel *goodsModel;


/** 数据回调 */
@property(nonatomic,copy) SRXPopFeatureSelectionBlock block;
/** 数据回调至详情 */
@property(nonatomic,copy) SelectionBlock selectBlock;

/** update数据回调 判断规格变化请用这个 */
@property(nonatomic,copy) SelectionBlock changeBlock;


/// 记录id
@property (nonatomic, assign) NSInteger record_id;

///** 订单来源:1=商城,2=精选推荐,3=服务 */
//@property(nonatomic,copy) NSString *source_type;

/// 是否是团购
@property (nonatomic, assign) BOOL isGroup;
/// 团购类型
@property (nonatomic, assign) NSInteger groupType;
/// 是否是团长
@property (nonatomic, assign) BOOL isHeader;
@end

NS_ASSUME_NONNULL_END
