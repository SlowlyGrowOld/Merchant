//
//  SRXGoodsInfoEditExpandVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/29.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsInfoEditExpandVC.h"

@interface SRXGoodsInfoEditExpandVC ()
@property (weak, nonatomic) IBOutlet UISwitch *evaluate_integral;
@property (weak, nonatomic) IBOutlet UISwitch *is_recommend;
@property (weak, nonatomic) IBOutlet UISwitch *is_new;
@property (weak, nonatomic) IBOutlet UISwitch *is_hot;
@property (weak, nonatomic) IBOutlet UITextField *weigh;

@end

@implementation SRXGoodsInfoEditExpandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CViewBgColor;
}

- (void)setEditInfo:(SRXGoodsEditInfoModel *)editInfo {
    if (!self.editInfo) {
        _editInfo = editInfo;
        _evaluate_integral.on = editInfo.evaluate_integral==1?YES:NO;
        _is_recommend.on = editInfo.is_recommend==1?YES:NO;
        _is_new.on = editInfo.is_new==1?YES:NO;
        _is_hot.on = editInfo.is_hot==1?YES:NO;
        _weigh.text = editInfo.weigh;
    }
}

- (IBAction)lastStepBtnClick:(id)sender {
    if (self.block) {
        self.block(0);
    }
}
- (IBAction)saveBtnClick:(id)sender {
    [self configParameters];
    if (self.block) {
        self.block(1);
    }
}
- (IBAction)nextStepBtnClick:(id)sender {
    [self configParameters];
    if (self.block) {
        self.block(2);
    }
}

- (void)configParameters {
    self.parameters = [NSMutableDictionary dictionary];
    self.parameters[@"evaluate_integral"] = self.evaluate_integral.isOn?@"1":@"0";
    self.parameters[@"is_new"] = self.is_new.isOn?@"1":@"0";
    self.parameters[@"is_hot"] = self.is_hot.isOn?@"1":@"0";
    self.parameters[@"is_recommend"] = self.is_recommend.isOn?@"1":@"0";
    self.parameters[@"weigh"] = self.weigh.text;

    DLog(@"销售信息：%@",self.parameters);
}
@end
