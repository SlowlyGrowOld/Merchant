//
//  SRXPhoneBindVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXPhoneBindVC.h"
#import "SRXSmsAuthenticationVC.h"

@interface SRXPhoneBindVC ()

@end

@implementation SRXPhoneBindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更换绑定手机号";
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SRXSmsAuthenticationVC *vc = [segue destinationViewController];
    vc.type = SRXSetInfoUpdateSuccessTypePhone;
}

@end
