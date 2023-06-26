//
//  SRXPhoneBindVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXPhoneBindVC.h"
#import "SRXSmsAuthenticationVC.h"
#import "NetworkManager+Me.h"

@interface SRXPhoneBindVC ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;

@end

@implementation SRXPhoneBindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更换绑定手机号";
}

- (IBAction)sureBtnClick:(id)sender {
    [NetworkManager changePhoneWithMobile:self.mobileTF.text success:^(NSString *message) {
        SRXSmsAuthenticationVC *vc = [[UIStoryboard storyboardWithName:@"Me" bundle:nil] instantiateViewControllerWithIdentifier:@"SRXSmsAuthenticationVC"];
        vc.type = SRXSetInfoUpdateSuccessTypePhone;
        vc.mobile = self.mobileTF.text;
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    } failure:^(NSString *message) {
        
    }];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SRXSmsAuthenticationVC *vc = [segue destinationViewController];
    vc.type = SRXSetInfoUpdateSuccessTypePhone;
}

@end
