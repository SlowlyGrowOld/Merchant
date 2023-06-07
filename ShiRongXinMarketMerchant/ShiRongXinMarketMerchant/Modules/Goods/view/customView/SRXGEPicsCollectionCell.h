//
//  SRXGEPicsCollectionCell.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/29.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXGEPicsCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, copy) NSString  *video_url;
@property (nonatomic, copy) NSString  *image_url;
@end

NS_ASSUME_NONNULL_END
