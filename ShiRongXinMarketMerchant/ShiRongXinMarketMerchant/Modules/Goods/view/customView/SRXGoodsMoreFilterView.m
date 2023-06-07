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
    self.min_sale.text = nil;
    self.max_sale.text = nil;
    self.min_price.text = nil;
    self.max_price.text = nil;
    self.min_store.text = nil;
    self.max_store.text = nil;
    self.min_profit.text = nil;
    self.max_profit.text = nil;
    self.parameters.sale_num_low = nil;
    self.parameters.sale_num_high = nil;
    self.parameters.price_low = nil;
    self.parameters.price_high = nil;
    self.parameters.profit_low = nil;
    self.parameters.profit_high = nil;
    self.parameters.store_count_low = nil;
    self.parameters.store_count_high = nil;
    [self removeFromSuperview];
    if (self.closeBlock) {
        self.closeBlock(self.parameters);
    }
}

- (IBAction)sureBtnClick:(id)sender {
    self.parameters.sale_num_low = self.min_sale.text;
    self.parameters.sale_num_high = self.max_sale.text;
    self.parameters.price_low = self.min_price.text;
    self.parameters.price_high = self.max_price.text;
    self.parameters.profit_low = self.min_profit.text;
    self.parameters.profit_high = self.max_profit.text;
    self.parameters.store_count_low = self.min_store.text;
    self.parameters.store_count_high = self.max_store.text;
    [self removeFromSuperview];
    if (self.closeBlock) {
        self.closeBlock(self.parameters);
    }
}

- (void)setParameters:(SRXGoodsListParameter *)parameters {
    _parameters = parameters;
    self.min_sale.text = self.parameters.sale_num_low;
    self.max_sale.text = self.parameters.sale_num_high;
    self.min_price.text = self.parameters.price_low;
    self.max_price.text = self.parameters.price_high;
    self.min_store.text = self.parameters.store_count_low;
    self.max_store.text = self.parameters.store_count_high;
    self.min_profit.text = self.parameters.profit_low;
    self.max_profit.text = self.parameters.profit_high;
}

- (void)dismiss {
    [self removeFromSuperview];
    if (self.closeBlock) {
        self.closeBlock(nil);
    }
}
@end
