//
//  SRXGoodsInfoUpdateAlertVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/29.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsInfoUpdateAlertVC.h"

@interface SRXGoodsInfoUpdateAlertVC ()

@end

@implementation SRXGoodsInfoUpdateAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isBgClose = YES;
}

- (IBAction)sureBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
