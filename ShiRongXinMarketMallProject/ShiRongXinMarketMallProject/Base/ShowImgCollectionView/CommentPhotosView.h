//
//  CommentPhotosView.h
//  ShengBaiClientProject
//
//  Created by 别天神 on 2021/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CommentPhotosViewTypeNormal,
    CommentPhotosViewTypeFourImage,
    CommentPhotosViewTypeFiveImage,
    CommentPhotosViewTypeFiveAny // 任何数量
} CommentPhotosViewType;
@interface CommentPhotosView : UICollectionView

/**
 数据
 */
@property (nonatomic, strong) NSArray *datas;

/**
 类型
 */
@property (nonatomic, assign) CommentPhotosViewType type;

/**
 最多显示数
 */
@property (nonatomic, assign) NSInteger maxCount;


/**
 最少显示数 => 任意图片
 */
@property (nonatomic, assign) NSInteger minCount;

/// 添加人员的block
@property (nonatomic, copy) dispatch_block_t addMemberBlock;
/// 是否未完成
@property (nonatomic, assign) BOOL isNoComplete;
@end

NS_ASSUME_NONNULL_END
