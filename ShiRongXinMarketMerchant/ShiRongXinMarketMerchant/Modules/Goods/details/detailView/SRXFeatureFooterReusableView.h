//
//  SRXFeatureFooterReusableView.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2023/1/10.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXFeatureFooterReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *buy_number;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (nonatomic, assign) NSInteger max_number;
@property (nonatomic, assign) NSInteger currentNumber;

@end

NS_ASSUME_NONNULL_END
