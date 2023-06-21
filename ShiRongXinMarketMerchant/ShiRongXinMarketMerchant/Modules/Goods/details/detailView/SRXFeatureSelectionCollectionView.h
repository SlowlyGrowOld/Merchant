//
//  SRXFeatureSelectionCollectionView.h
//  ShiRongXinMarketMallProject
//
//  Created by 薛静鹏 on 2020/3/18.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"
#import "SRXSpecGoodsPriceModel.h"
#import "SRXAllTheGoodsModel.h"
#import "SRXFeatureFooterReusableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^FeatureSelectionBlock)(NSDictionary * _Nullable seleSpecDic);
typedef void(^FeatureSelectionHeightBlock)(CGFloat height);
@interface SRXFeatureSelectionCollectionView : UICollectionView
@property (nonatomic, strong) SRXFeatureFooterReusableView *numberView;
@property (nonatomic,strong) PPNumberButton *numberButton;
/** 数据返回 */
@property(nonatomic,copy) FeatureSelectionBlock block;
/** 高度数据返回 */
@property(nonatomic,copy) FeatureSelectionHeightBlock heightBlock;
/** 规格数组 */
@property (nonatomic,strong) NSMutableArray *specArray;

/** 规格商品数组 */
@property (nonatomic,strong) NSMutableArray *specGoods;

/* 选择属性 以id为key */
@property (strong , nonatomic)NSMutableDictionary *seleDic;

/** 为套餐商品时是否能够修改购买数量 */
@property(nonatomic, assign) BOOL  is_package_edit_num;

/** 是否隐藏购买数量 ，默认不隐藏*/
@property(nonatomic, assign) BOOL  is_hidden_num;

/** 当前选中规格可购买最大件数*/
@property(nonatomic, assign) NSInteger  max_number;
/** 当前选中规格已添加number*/
@property(nonatomic, assign) NSInteger  current_number;

@end

NS_ASSUME_NONNULL_END
