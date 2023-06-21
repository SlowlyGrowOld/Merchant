//
//  DCFeatureItemCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCFeatureList;
@interface DCFeatureItemCell : UICollectionViewCell
/* 属性 */
@property (strong , nonatomic)UILabel *attLabel;
/* 库存状态 */
@property (strong , nonatomic)UILabel *stockoutLb;

@end
