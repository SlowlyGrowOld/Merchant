//
//  SRXLoginVC.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2023/4/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXLoginVC.h"

@interface SRXLoginVC ()
@property (weak, nonatomic) IBOutlet UIView *psdView;
@property (weak, nonatomic) IBOutlet UILabel *login_type;
@property (weak, nonatomic) IBOutlet UILabel *questionLb;
@property (weak, nonatomic) IBOutlet UILabel *protocolLb;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet UIView *account_icon;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;

@end

@implementation SRXLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    
    MJWeakSelf;
    [self.login_type jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        if (self.type == SRXLoginTypePhoneMsg) {
            self.type = SRXLoginTypePhonePsd;
        } else {
            
        }
    }];
}

- (void)configUI {
    if (self.type == SRXLoginTypePhoneMsg) {
        self.psdView.hidden = YES;
        self.login_type.text = @"密码登录";
        [self.loginBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else {
        self.psdView.hidden = NO;
        self.login_type.text = @"更多登录方式";
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        if (self.type == SRXLoginTypePhonePsd) {
            self.account_icon.hidden = YES;
            self.areaView.hidden = NO;
            self.accountTF.placeholder = @"请输入手机号";
        } else {
            self.account_icon.hidden = NO;
            self.areaView.hidden = YES;
            self.accountTF.placeholder = @"请输入账号";
        }
    }
}

- (IBAction)loginBtnClick:(id)sender {
    
}

@end
