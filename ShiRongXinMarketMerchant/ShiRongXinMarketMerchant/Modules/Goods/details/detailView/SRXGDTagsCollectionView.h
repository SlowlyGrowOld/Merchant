//
//  SRXGDTagsCollectionView.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/30.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SRXGDTagsTypeNomal,
    SRXGDTagsTypeEvaluate,//评价标签
} SRXGDTagsType;

NS_ASSUME_NONNULL_BEGIN
typedef void(^SRXGDTagsCollectionViewBlock)(NSInteger index);
@interface SRXGDTagsCollectionView : UICollectionView
@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, copy) SRXGDTagsCollectionViewBlock selectBlock;
@property (nonatomic, assign) BOOL     isSelect;

@property (nonatomic, assign) SRXGDTagsType type;
/**字体大小*/
@property (nonatomic, assign) NSInteger tagFont;
@end

NS_ASSUME_NONNULL_END
