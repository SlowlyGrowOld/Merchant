//
//  SRXCreateTimeFilterView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXCreateTimeFilterView.h"

@interface SRXCreateTimeFilterView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end

@implementation SRXCreateTimeFilterView

- (IBAction)resetBtnClick:(id)sender {
    [self dismiss];
}

- (IBAction)sureBtnClick:(id)sender {
    [self dismiss];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.allObjects.lastObject;
    BOOL result = [touch.view isDescendantOfView:self.bgView];
    if (!result){
        [self dismiss];
    }
}

- (void)dismiss {
    [self removeFromSuperview];
    if (self.removeBlock) {
        self.removeBlock();
    }
}

@end
