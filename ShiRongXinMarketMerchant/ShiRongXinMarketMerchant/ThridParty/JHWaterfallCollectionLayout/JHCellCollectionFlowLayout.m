//
//  JHCellCollectionFlowLayout.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2022/8/31.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "JHCellCollectionFlowLayout.h"

@interface JHCellCollectionFlowLayout ()
/** 布局属性数组*/
@property (nonatomic,strong) NSMutableArray *attrsArray;

/** 存放所有列的当前高度*/
@property (nonatomic,strong) NSMutableArray *columnHeight;

/** 存放当前行的宽度*/
@property (nonatomic,assign) CGFloat *columnWidth;

@end

/**  列数*/
static const CGFloat columCount = 3;
/**  每一列间距*/
static const CGFloat columMargin = 8;
/**  每一列间距*/
static const CGFloat rowMargin = 8;
/**  边缘间距*/
static const UIEdgeInsets defaultEdgeInsets = {0,0,0,0};


@implementation JHCellCollectionFlowLayout

- (NSInteger)columCount{
    
    if ([self.delegate respondsToSelector:@selector(cloumnCountInWaterFlowLayout:)]) {
        return  [self.delegate cloumnCountInWaterFlowLayout:self];
    }
    else{
        return columCount;
    }
}

- (CGFloat)columMargin{
    
    if ([self.delegate respondsToSelector:@selector(columMarginInWaterFlowLayout:)]) {
        return  [self.delegate columMarginInWaterFlowLayout:self];
    }
    else{
        return columMargin;
    }
}

- (CGFloat)rowMargin{
    
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)]) {
        return  [self.delegate rowMarginInWaterFlowLayout:self];
    }
    else{
        return rowMargin;
    }
}

- (UIEdgeInsets)defaultEdgeInsets{
    
    if ([self.delegate respondsToSelector:@selector(edgeInsetInWaterFlowLayout:)]) {
        return  [self.delegate edgeInsetInWaterFlowLayout:self];
    }
    else{
        return defaultEdgeInsets;
    }
}

- (NSDictionary *)sectionHeightDic {
    if ([self.delegate respondsToSelector:@selector(setionHeightInWaterFlowLayout:)]) {
        return [self.delegate setionHeightInWaterFlowLayout:self];
    }
    else {
        return @{};
    }
}

//懒加载 attrsArray, columnHeight

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (NSMutableArray *)columnHeight
{
    if (!_columnHeight) {
        
        _columnHeight = [NSMutableArray array];
    }
    return _columnHeight;
}

//重写prepareLayout方法

/**  初始化*/
- (void)prepareLayout
{
    [super prepareLayout];
    
    //如果刷新布局就会重新调用prepareLayout这个方法,所以要先把高度数组清空
    [self.columnHeight removeAllObjects];
    for (int i = 0; i < self.columCount; i++) {
        
        [self.columnHeight addObject:@(self.defaultEdgeInsets.top)];
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    [self.attrsArray removeAllObjects];
    for (NSInteger i = 0; i < count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        //获取indexPath 对应cell 的布局属性
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attr];
    }
    for (NSString *row in self.sectionHeightDic.allKeys) {
        UICollectionViewLayoutAttributes *header = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:row.intValue]];
        header.frame = CGRectMake(0, 0, kScreenWidth, [self.sectionHeightDic[row] doubleValue]);
        [self.attrsArray addObject:header];
    }

}
//该方法返回对应cell上的布局属性.我们可以在这个方法中设置cell 的布局样式.在prepareLayout方法中,我们根据这个方法,传入对应的IndexPath从而获取到布局属性attr,然后添加到数组中.

/**
 *  返回indexPath 位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //使用for循环,找出高度最短的那一列
    //最短高度的列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeight[0] doubleValue];
    
    for (NSInteger i = 1; i < self.columCount; i++) {
        
        CGFloat columnHeight  =[self.columnHeight[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat w = 0.0;
    if ([self.delegate respondsToSelector:@selector(waterFlowLayout:widthForRowAtIndex:)]) {
        w = [self.delegate waterFlowLayout:self widthForRowAtIndex:indexPath.item];
    }else {
        w = (self.collectionView.frame.size.width - self.defaultEdgeInsets.left - self.defaultEdgeInsets.right - (self.columCount - 1) * self.columMargin )/self.columCount;
    }

    //(使用代理在外部决定cell 的高度,下面会介绍)
    CGFloat h = [self.delegate waterFlowLayout:self heightForRowAtIndex:indexPath.item itemWidth:w];
    
    CGFloat x = self.defaultEdgeInsets.left + destColumn*(w + self.columMargin);
    if ([self.delegate respondsToSelector:@selector(waterFlowLayout:typeForRowAtIndex:)]) {
        CellFlowLayoutStyle style = [self.delegate waterFlowLayout:self typeForRowAtIndex:indexPath.item];
        if (style == CellFlowLayoutStyleVideo && [self.delegate respondsToSelector:@selector(waterFlowLayout:widthForRowAtIndex:)] && indexPath.item !=0) {
            CGFloat l = [self.delegate waterFlowLayout:self widthForRowAtIndex:0];
            x = self.defaultEdgeInsets.left + l + self.columMargin + (destColumn-1)*(w + self.columMargin);
        }
    }
    
    CGFloat y = minColumnHeight ;
    
    if (y != self.defaultEdgeInsets.top) {
        
        y += self.rowMargin;
    }
    
    attr.frame = CGRectMake(x,y+[self.sectionHeightDic[@(indexPath.section).stringValue] doubleValue],w,h);
    
    self.columnHeight[destColumn] =  @(y+ h);
    return attr;
}
//重写layoutAttributesForElementsInRect:方法

/**
 *  决定cell 的排布
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}
//决定collectionView的可滚动范围

- (CGSize)collectionViewContentSize
{
    
    CGFloat maxHeight = [self.columnHeight[0] doubleValue];
    for (int i = 1; i < self.columCount; i++) {
        
        CGFloat value = [self.columnHeight[i] doubleValue];
        if (maxHeight < value) {
            
            maxHeight = value;
        }
    }
    return CGSizeMake(0, maxHeight+self.defaultEdgeInsets.bottom);
}



@end

