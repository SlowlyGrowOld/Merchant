//
//  SRXShelfReviewAlertVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/7/3.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXShelfReviewAlertVC.h"

@interface SRXShelfReviewAlertVC ()
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation SRXShelfReviewAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isBgClose = YES;
    if (self.type == SRXShelfReviewAlertTypeAudit) {
        self.contentLb.text = @"审核通过是否直接上架？";
        [self.cancleBtn setTitle:@"仅提交审核" forState:UIControlStateNormal];
        [self.sureBtn setTitle:@"提交并上架" forState:UIControlStateNormal];
    } else {
        
    }
}

- (IBAction)sureBtnClick:(id)sender {
    if (self.block) {
        self.block(YES);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancleBtnClick:(id)sender {
    if (self.block) {
        self.block(NO);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
