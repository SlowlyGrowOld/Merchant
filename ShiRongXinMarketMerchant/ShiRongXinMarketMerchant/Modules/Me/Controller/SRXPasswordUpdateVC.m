//
//  SRXPasswordUpdateVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXPasswordUpdateVC.h"
#import "SRXSmsAuthenticationVC.h"
#import "NetworkManager+Me.h"

@interface SRXPasswordUpdateVC ()
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *rePwdTF;

@end

@implementation SRXPasswordUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
}

- (IBAction)sureBtnClick:(id)sender {
    [NetworkManager changePasswordWithPwd:self.pwdTF.text re_pwd:self.rePwdTF.text success:^(NSString *message) {
        SRXSmsAuthenticationVC *vc = [[UIStoryboard storyboardWithName:@"Me" bundle:nil] instantiateViewControllerWithIdentifier:@"SRXSmsAuthenticationVC"];
        vc.type = SRXSetInfoUpdateSuccessTypePsd;
        vc.pwd = self.pwdTF.text;
        vc.re_pwd = self.rePwdTF.text;
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    } failure:^(NSString *message) {
        
    }];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    SRXSmsAuthenticationVC *vc = [segue destinationViewController];
//    vc.type = SRXSetInfoUpdateSuccessTypePsd;
}

@end
