//
//  SRXCreateTimeFilterView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXCreateTimeFilterView.h"
#import "SRXCalendarPickerView.h"

@interface SRXCreateTimeFilterView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewConsH;
@property (nonatomic, strong) SRXCalendarPickerView *pickerView;
@end

@implementation SRXCreateTimeFilterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentViewConsH.constant = 6*kRealValue(44)+100;
    [self.contentView addSubview:self.pickerView];
}

- (IBAction)resetBtnClick:(id)sender {
    self.parameters.start_time = nil;
    self.parameters.end_time = nil;
    [self.pickerView reset];
    [self dismiss];
}

- (IBAction)sureBtnClick:(id)sender {
    self.parameters.start_time = self.pickerView.lastTime;
    self.parameters.end_time = self.pickerView.nextTime;
    [self dismiss];
}

- (void)setParameters:(SRXGoodsListParameter *)parameters {
    _parameters = parameters;
    if (parameters.start_time.length>0) {
        [self.pickerView initStartTime:parameters.start_time endTime:parameters.end_time];
    }else {
        [self.pickerView reset];
    }
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
    if (self.closeBlock) {
        self.closeBlock(self.parameters);
    }
}

- (SRXCalendarPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[SRXCalendarPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 6*kRealValue(44)+100)];
    }
    return _pickerView;
}

@end
