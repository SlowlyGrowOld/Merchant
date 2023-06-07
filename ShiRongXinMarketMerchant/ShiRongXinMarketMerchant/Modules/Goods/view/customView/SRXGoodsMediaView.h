//
//  SRXGoodsMediaView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/30.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SRXGoodsMediaBlock)(NSInteger count);

@interface SRXGoodsMediaView : UICollectionView
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
/**图片视频集*/
@property (nonatomic, strong) NSMutableArray *datas;
/** 上传限制个数,默认1*/
@property (nonatomic,assign) NSInteger limit_num;
/** 是图片还是视频*/
@property (nonatomic,assign) BOOL  is_video;
/** 是图片还是视频*/
@property (nonatomic,assign) BOOL  is_gif;

@property (nonatomic, copy) SRXGoodsMediaBlock block;
@end

NS_ASSUME_NONNULL_END
