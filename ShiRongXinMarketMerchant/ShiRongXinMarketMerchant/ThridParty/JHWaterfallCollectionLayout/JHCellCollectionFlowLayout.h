//
//  JHCellCollectionFlowLayout.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2022/8/31.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHCellCollectionFlowLayout;


typedef enum : NSUInteger {
    CellFlowLayoutStyleNomal,//正常
    CellFlowLayoutStyleVideo,//（两列）1大 2小
}  CellFlowLayoutStyle;

@protocol CellFlowLayoutDelegate <NSObject>

@required
//决定cell的高度,必须实现方法
- (CGFloat)waterFlowLayout:(JHCellCollectionFlowLayout *)waterFlowLayout heightForRowAtIndex:(NSInteger)index itemWidth:(CGFloat)width;

@optional
//决定cell的高度,必须实现方法
- (CGFloat)waterFlowLayout:(JHCellCollectionFlowLayout *)waterFlowLayout widthForRowAtIndex:(NSInteger)index;

//决定模板样式
- (CellFlowLayoutStyle)waterFlowLayout:(JHCellCollectionFlowLayout *)waterFlowLayout typeForRowAtIndex:(NSInteger)index;

//决定cell的列数
- (NSInteger)cloumnCountInWaterFlowLayout:(JHCellCollectionFlowLayout *)waterFlowLayout;

//决定cell 的列的距离
- (CGFloat)columMarginInWaterFlowLayout:(JHCellCollectionFlowLayout *)waterFlowLayout;

//决定cell 的行的距离
- (CGFloat)rowMarginInWaterFlowLayout:(JHCellCollectionFlowLayout *)waterFlowLayout;

//决定cell 的边缘距
- (UIEdgeInsets)edgeInsetInWaterFlowLayout:(JHCellCollectionFlowLayout *)waterFlowLayout;

//决定section的高度@{@"0":40,@"1":50,@"3":80}
- (NSDictionary *)setionHeightInWaterFlowLayout:(JHCellCollectionFlowLayout *)waterFlowLayout;

@end

@interface JHCellCollectionFlowLayout : UICollectionViewFlowLayout
/**代理*/
@property (nonatomic,assign) id <CellFlowLayoutDelegate>delegate;

- (NSInteger)columCount;
- (CGFloat)columMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)defaultEdgeInsets;
- (NSDictionary *)sectionHeightDic;

@end
