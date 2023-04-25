//
//  SRXPasswordUpdateVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXPasswordUpdateVC.h"
#import "SRXSmsAuthenticationVC.h"

@interface SRXPasswordUpdateVC ()

@end

@implementation SRXPasswordUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SRXSmsAuthenticationVC *vc = [segue destinationViewController];
    vc.type = SRXSetInfoUpdateSuccessTypePsd;
}

@end
