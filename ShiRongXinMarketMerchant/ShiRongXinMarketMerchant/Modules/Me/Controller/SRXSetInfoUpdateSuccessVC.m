//
//  SRXSetInfoUpdateSuccessVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXSetInfoUpdateSuccessVC.h"
#import "SRXSetInfoTableVC.h"

@interface SRXSetInfoUpdateSuccessVC ()
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation SRXSetInfoUpdateSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.type== SRXSetInfoUpdateSuccessTypePsd?@"修改密码":@"更换绑定手机号";
    self.contentLb.text = self.type== SRXSetInfoUpdateSuccessTypePsd?@"登录密码修改成功":@"绑定手机号更换成功";
    [self.btn setTitle:self.type== SRXSetInfoUpdateSuccessTypePsd?@"返回":@"重新登录" forState:UIControlStateNormal];
}

- (IBAction)bottomBtnClick:(id)sender {
    if (self.type == SRXSetInfoUpdateSuccessTypePsd) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[SRXSetInfoTableVC class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [UserManager clearUser];
        [AppHandyMethods switchWindowToLoginScene];
    }
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
