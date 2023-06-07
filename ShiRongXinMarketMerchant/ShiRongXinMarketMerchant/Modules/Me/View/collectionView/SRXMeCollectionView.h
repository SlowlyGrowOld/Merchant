//
//  SRXMeCollectionView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/17.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SRXMeCollectionTypeImage,
    SRXMeCollectionTypeText,
} SRXMeCollectionType;

typedef enum : NSUInteger {
    SRXMeCollectionJumpTypeMyOrder,
    SRXMeCollectionJumpTypeOther,
} SRXMeCollectionJumpType;
NS_ASSUME_NONNULL_BEGIN

@interface SRXMeCollectionModel : NSObject
@property (nonatomic, copy) NSString *title;//下半部标题
@property (nonatomic, copy) NSString *content;//图片或者文本
+ (SRXMeCollectionModel *)configWithTitle:(NSString *)title content:(NSString *)content;
@end

@interface SRXMeCollectionView : UICollectionView
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) SRXMeCollectionType type;
@property (nonatomic, assign) SRXMeCollectionJumpType jumpType;
@end

NS_ASSUME_NONNULL_END
