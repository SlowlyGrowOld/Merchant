//
//  SRXGoodsMoreFilterView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsMoreFilterView.h"

@interface SRXGoodsMoreFilterView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *min_sale;
@property (weak, nonatomic) IBOutlet UITextField *max_sale;
@property (weak, nonatomic) IBOutlet UITextField *min_price;
@property (weak, nonatomic) IBOutlet UITextField *max_price;
@property (weak, nonatomic) IBOutlet UITextField *min_store;
@property (weak, nonatomic) IBOutlet UITextField *max_store;
@property (weak, nonatomic) IBOutlet UITextField *min_profit;
@property (weak, nonatomic) IBOutlet UITextField *max_profit;

@end

@implementation SRXGoodsMoreFilterView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.allObjects.lastObject;
    BOOL result = [touch.view isDescendantOfView:self.bgView];
    if (!result){
        [self dismiss];
    }
}

- (IBAction)resetBtnClick:(id)sender {
    [self dismiss];
}

- (IBAction)sureBtnClick:(id)sender {
    [self dismiss];
}

- (void)dismiss {
    [self removeFromSuperview];
    if (self.removeBlock) {
        self.removeBlock();
    }
}
@end
