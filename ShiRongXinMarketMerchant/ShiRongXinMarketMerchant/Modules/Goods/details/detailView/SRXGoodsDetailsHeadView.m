//
//  SRXGoodsDetailsHeadView.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/12/22.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXGoodsDetailsHeadView.h"

@implementation SRXGoodsDetailsHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.alpha = 0;
    self.backBtn.hidden = self.menuBtn.hidden = YES;
    
    [self.backBtn addCallBackAction:^(UIButton *button) {
        [[UIViewController jk_currentNavigatonController] popViewControllerAnimated:YES];
    }];
    
//    [self.shareBtn addCallBackAction:^(UIButton *button) {
//
//    }];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    [UIView animateWithDuration:0.2 animations:^{
        if (currentIndex == 1) {
            self.goodBtn.selected = YES;
            self.goodBtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            self.evaluateBtn.selected = NO;
            self.evaluateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            self.detailsBtn.selected = NO;
            self.detailsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            self.lineView.centerX = self.goodBtn.centerX;
        }else if (currentIndex == 2) {
            self.evaluateBtn.selected = YES;
            self.evaluateBtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            self.goodBtn.selected = NO;
            self.goodBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            self.detailsBtn.selected = NO;
            self.detailsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            self.lineView.centerX = self.evaluateBtn.centerX;
        }else if (currentIndex == 3) {
            self.detailsBtn.selected = YES;
            self.detailsBtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            self.evaluateBtn.selected = NO;
            self.evaluateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            self.goodBtn.selected = NO;
            self.goodBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            self.lineView.centerX = self.detailsBtn.centerX;
        }
    }];
}

@end
