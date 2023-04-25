//
//  SRXLoginVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXLoginVC.h"
#import "SRXLoginShopListVC.h"
#import "SRXLoginProtocolVC.h"
#import "SRXLoginMsgVC.h"

#import "NetworkManager+Login.h"

@interface SRXLoginVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *psdView;
@property (weak, nonatomic) IBOutlet UILabel *login_type;
@property (weak, nonatomic) IBOutlet UILabel *questionLb;
@property (weak, nonatomic) IBOutlet UITextView *protocolLb;
@property (weak, nonatomic) IBOutlet UIImageView *agreeImage;
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
    
    self.isHidenNaviBar = YES;
    self.type = SRXLoginTypePhoneMsg;
    self.protocolLb.linkTextAttributes = @{NSForegroundColorAttributeName:UIColorHex(0x43B8F6)};
    self.protocolLb.attributedText = self.createProtocolText;
    self.protocolLb.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    MJWeakSelf;
    [self.login_type jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        if (weakSelf.type == SRXLoginTypePhoneMsg) {
            weakSelf.type = SRXLoginTypePhonePsd;
        } else {
            [weakSelf switchLoginType];
        }
    }];
    [self.agreeImage.superview jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        weakSelf.agreeImage.hidden = !weakSelf.agreeImage.isHidden;
    }];
}

- (void)setType:(SRXLoginType)type {
    _type = type;
    if (_type == SRXLoginTypePhoneMsg) {
        self.account_icon.hidden = YES;
        self.areaView.hidden = NO;
        self.psdView.hidden = YES;
        self.login_type.text = @"密码登录";
        [self.loginBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else {
        self.psdView.hidden = NO;
        self.login_type.text = @"更多登录方式";
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        if (_type == SRXLoginTypePhonePsd) {
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

- (void)switchLoginType {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertC addAction:[UIAlertAction actionWithTitle:self.type==SRXLoginTypeAccountPsd?@"手机号密码登录":@"账号密码登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.type = self.type==SRXLoginTypeAccountPsd?SRXLoginTypePhonePsd:SRXLoginTypeAccountPsd;
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"短信验证码登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.type = SRXLoginTypePhoneMsg;
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (IBAction)loginBtnClick:(id)sender {
    if (self.agreeImage.isHidden) {
        SRXLoginProtocolVC *vc = [[SRXLoginProtocolVC alloc] init];
        MJWeakSelf;
        vc.agreeBlock = ^{
            weakSelf.agreeImage.hidden = NO;
        };
        [self presentViewController:vc animated:NO completion:nil];
    } else {
        if (self.type == SRXLoginTypePhoneMsg || self.type == SRXLoginTypePhonePsd) {
            if (self.accountTF.text.length != 11) {
                [SVProgressHUD showInfoWithStatus:@"手机号码输入错误"];
                return;
            }
        }
        [SVProgressHUD show];
        UIStoryboard *login = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        if (self.type == SRXLoginTypePhoneMsg) {
            [NetworkManager sendSMSWithMobile:self.accountTF.text sms_event:@"login" success:^(NSString *message) {
                SRXLoginMsgVC *vc = [login instantiateViewControllerWithIdentifier:@"SRXLoginMsgVC"];
                vc.mobile = self.accountTF.text;
                [self.navigationController pushViewController:vc animated:YES];
            } failure:^(NSString *message) {
                
            }];
        } else {
            [NetworkManager loginAccountWithUsername:self.accountTF.text password:self.psdTF.text login_type:self.type==SRXLoginTypePhonePsd?@"2":@"1" success:^(NSString *message) {
                if ([UserManager sharedUserManager].curUserInfo.shops_num>0) {
                    UIStoryboard *login = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                    SRXLoginShopListVC *vc = [login instantiateViewControllerWithIdentifier:@"SRXLoginShopListVC"];
                    [self.navigationController pushViewController:vc animated:YES];
                } else {
                    [AppHandyMethods switchWindowToMainScene];
                }
            } failure:^(NSString *message) {
                
            }];
        }
    }
}

-(NSMutableAttributedString *)createProtocolText{
    //普通字体的大小颜色
    NSDictionary * normalAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:11], NSForegroundColorAttributeName:UIColorHex(0x333333)};
    
    //生成默认的字符串
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意《够容易用户协议》、《够容易隐私政策》。 并授权够容易使用相关帐号信息。" attributes:normalAtt];
    
    //添加点击事件
    NSString * value = [NSString stringWithFormat:@"clickprotocol://"];
    [attStr addAttribute:NSLinkAttributeName value:value range:[[attStr string] rangeOfString:@"《够容易用户协议》、"]];
    NSString * value1 = [NSString stringWithFormat:@"clickprivacy://"];
    [attStr addAttribute:NSLinkAttributeName value:value1 range:[[attStr string] rangeOfString:@"《够容易隐私政策》。"]];
    
    return attStr;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    if ([URL.scheme isEqualToString:@"clickprotocol"]) {
        NSLog(@"protocol click");
        return NO;
    }
    if ([URL.scheme isEqualToString:@"clickprivacy"]) {
        NSLog(@"privacy click");
        return NO;
    }
    return YES;
}


@end
