//
//  SRXFeatureFooterReusableView.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2023/1/10.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXFeatureFooterReusableView.h"

@interface SRXFeatureFooterReusableView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *limit_number;
@end

@implementation SRXFeatureFooterReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.currentNumber = 1;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = UIColorHex(0xFAFAFA).CGColor;
    self.numberTF.delegate = self;
    [self.numberTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setMax_number:(NSInteger)max_number {
    _max_number = max_number;
    if (max_number==0) {
        _limit_number.text = @"缺货";
        self.currentNumber = 1;
        self.buy_number.text = @"1";
        self.subBtn.enabled = NO;
        self.addBtn.enabled = NO;
    }else {
        _limit_number.text = [NSString stringWithFormat:@"最多可购买%zd件",self.max_number];
        if (self.currentNumber > self.max_number) {
            self.currentNumber = 1;
            self.buy_number.text = @"1";
        }
        self.subBtn.enabled = self.currentNumber==1?NO:YES;
        self.addBtn.enabled = self.currentNumber==self.max_number?NO:YES;
    }
    self.numberTF.text = self.buy_number.text;
}

- (void)setCurrentNumber:(NSInteger)currentNumber {
    _currentNumber = currentNumber;
    self.buy_number.text = @(currentNumber).stringValue;
    self.numberTF.text = @(currentNumber).stringValue;
    self.subBtn.enabled = currentNumber==1?NO:YES;
    self.addBtn.enabled = currentNumber==self.max_number?NO:YES;
}

- (IBAction)subBtnClick:(UIButton *)sender {
    if (self.currentNumber > 1) {
        self.currentNumber--;
        self.addBtn.enabled = YES;
        self.buy_number.text = @(self.currentNumber).stringValue;
        self.subBtn.enabled = self.currentNumber==1?NO:YES;
    }else {
        self.subBtn.enabled = NO;
    }
    self.numberTF.text = self.buy_number.text;
}

- (IBAction)addBtnClick:(UIButton *)sender {
    if (self.currentNumber < self.max_number) {
        self.currentNumber++;
        self.subBtn.enabled = YES;
        self.buy_number.text = @(self.currentNumber).stringValue;
        self.addBtn.enabled = self.currentNumber==self.max_number?NO:YES;
    }else {
        self.addBtn.enabled = NO;
    }
    self.numberTF.text = self.buy_number.text;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.integerValue > self.max_number) {
        textField.text = @(self.max_number).stringValue;
    } else if (textField.text.integerValue < 1) {
        textField.text = @"1";
    }
    self.currentNumber = textField.text.integerValue;
    self.buy_number.text = textField.text;
    self.subBtn.enabled = self.currentNumber==1?NO:YES;
    self.addBtn.enabled = self.currentNumber==self.max_number?NO:YES;
}

-(void)textFieldDidChange:(UITextField*)textField{
    if (textField.text.integerValue > self.max_number) {
        textField.text = @(self.max_number).stringValue;
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"库存紧张，最多只能买%@件哦！",textField.text]];
    }
}

@end
