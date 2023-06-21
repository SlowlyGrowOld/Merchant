//
//  SRXGDShopGoodsCollectionView.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/12/21.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXGDShopGoodsCollectionView : UICollectionView
/** 数据 */
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,assign) BOOL isMember;
@end

NS_ASSUME_NONNULL_END
