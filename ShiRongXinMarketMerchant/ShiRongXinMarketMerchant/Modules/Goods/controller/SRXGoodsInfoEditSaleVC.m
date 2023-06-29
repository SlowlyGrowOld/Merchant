//
//  SRXGoodsInfoEditSaleVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/29.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsInfoEditSaleVC.h"
#import "SRXArrayTitlesAlertVC.h"

@interface SRXGoodsInfoEditSaleVC ()
@property (weak, nonatomic) IBOutlet UITextField *market_price;
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UITextField *refund_deadline;
@property (weak, nonatomic) IBOutlet UISwitch *is_free_shipping;
@property (weak, nonatomic) IBOutlet UIView *shippingView;
@property (weak, nonatomic) IBOutlet UITextField *shipping_name;

@end

@implementation SRXGoodsInfoEditSaleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CViewBgColor;
    MJWeakSelf;
    [self.shippingView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        SRXArrayTitlesAlertVC *vc = [[SRXArrayTitlesAlertVC alloc] init];
        vc.type = SRXArrayTitlesTypeDelivery;
        vc.selectBlock = ^(SRXArrayTitlesModel * _Nonnull model) {
            weakSelf.editInfo.delivery_id = model._id;
            weakSelf.editInfo.delivery_name = model.name;
            weakSelf.shipping_name.text = model.name;
        };
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }];
}

- (void)setEditInfo:(SRXGoodsEditInfoModel *)editInfo {
    if (!self.editInfo) {
        _editInfo = editInfo;
//        _market_price.text = [NSString stringWithNumber:@(editInfo.market_price) formatter:@"###.##"];
        _weight.text = editInfo.weight;
        _refund_deadline.text = editInfo.refund_deadline;
        _is_free_shipping.on = editInfo.is_free_shipping==1?YES:NO;
        if (editInfo.is_free_shipping == 1) {
            _shippingView.hidden = YES;
        } else {
            _shippingView.hidden = NO;
            _shipping_name.text = editInfo.delivery_name;
        }
    }
}

- (IBAction)is_free_shippingBtnClick:(id)sender {
    _shippingView.hidden = self.is_free_shipping.isOn;
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
    if (self.refund_deadline.text.length==0) {
        [SVProgressHUD showInfoWithStatus:@"请输入退款期限"];
        return;
    }
    if (!self.is_free_shipping.isOn && self.editInfo.delivery_id.length==0) {
        [SVProgressHUD showInfoWithStatus:@"请选择运费模版"];
        return;
    }
    [self configParameters];
    if (self.block) {
        self.block(2);
    }
}

- (void)configParameters {
    self.parameters = [NSMutableDictionary dictionary];
//    self.parameters[@"market_price"] = self.market_price.text;
    self.parameters[@"weight"] = self.weight.text;
    self.parameters[@"refund_deadline"] = self.refund_deadline.text;
    self.parameters[@"is_free_shipping"] = self.is_free_shipping.isOn?@"1":@"0";
    if (!self.is_free_shipping.isOn) {
        self.parameters[@"delivery_id"] = self.editInfo.delivery_id;
    }
    DLog(@"销售信息：%@",self.parameters);
}
@end
