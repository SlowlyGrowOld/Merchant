//
//  SRXGDShopGoodsCollectionCell.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/12/21.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXGDShopGoodsCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *good_name;
@property (weak, nonatomic) IBOutlet UILabel *good_price;
@property (weak, nonatomic) IBOutlet UILabel *tagLb;
@property (weak, nonatomic) IBOutlet UILabel *original_price;

@end

NS_ASSUME_NONNULL_END
