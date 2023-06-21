//
//  SRXImageCollectionViewCell.h
//  ShiRongXinMarketMallProject
//
//  Created by 薛静鹏 on 2020/3/24.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIView *numView;
@property (weak, nonatomic) IBOutlet UILabel *numLb;

@end

NS_ASSUME_NONNULL_END
