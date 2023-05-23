//
//  SRXSmsAuthenticationVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXSmsAuthenticationVC.h"
#import "HWTFCodeView.h"
#import "SRXSetInfoUpdateSuccessVC.h"

#import "NetworkManager+Me.h"

@interface SRXSmsAuthenticationVC ()
@property (weak, nonatomic) IBOutlet UILabel *numberLb;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIButton *sendMsgBtn;
@property (nonatomic, strong) HWTFCodeView *code1View;
@property (nonatomic, strong) dispatch_source_t timer;// 注意:此处应该使用强引用strong
@property (nonatomic, assign) long num;
@end

@implementation SRXSmsAuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"短信认证";
    
    _code1View = [[HWTFCodeView alloc] initWithCount:6 margin:12];
    _code1View.frame = CGRectMake(0, 0, kScreenWidth-88, 50);
    MJWeakSelf;
    _code1View.codeBlock = ^(NSString * _Nonnull code) {
        [weakSelf verifyPsdWith:code];
    };
    [self.codeView addSubview:_code1View];
    self.num = 60;
    self.sendMsgBtn.enabled = NO;
    [self startTimer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.code1View.isEdit = YES;
}

- (IBAction)sendMsgBtnClick:(id)sender {
    self.sendMsgBtn.enabled = !self.sendMsgBtn.isEnabled;
    [self startTimer];
}

- (void)verifyPsdWith:(NSString *)code {
    NSLog(@"code:%@",code);
    
    if (self.type == SRXSetInfoUpdateSuccessTypePhone) {
        [NetworkManager changePhoneWithMobile:self.mobile code:code success:^(NSString *message) {
            UIStoryboard *Me = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
            SRXSetInfoUpdateSuccessVC *vc = [Me instantiateViewControllerWithIdentifier:@"SRXSetInfoUpdateSuccessVC"];
            vc.type = self.type;
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSString *message) {
            
        }];
    }else {
        [NetworkManager changePasswordWithPwd:self.pwd re_pwd:self.re_pwd code:code success:^(NSString *message) {
            UIStoryboard *Me = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
            SRXSetInfoUpdateSuccessVC *vc = [Me instantiateViewControllerWithIdentifier:@"SRXSetInfoUpdateSuccessVC"];
            vc.type = self.type;
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSString *message) {
            
        }];
    }
}

- (void)startTimer {

    dispatch_queue_t queue = dispatch_get_main_queue();
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);

    __weak typeof (self) weak_self = self;
    dispatch_source_set_event_handler(self.timer, ^{

        weak_self.num --;
        if (weak_self.num==0) {
            [weak_self stopTimer];
        } else {
            [weak_self self_updateTimeView];
        }
    });
    dispatch_resume(self.timer);
}

-(void)stopTimer {
    if (self.timer) {
        self.num = 60;
        [self.sendMsgBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        self.sendMsgBtn.enabled = YES;
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)self_updateTimeView {
    [self.sendMsgBtn setTitle:[NSString stringWithFormat:@"%ld秒后再次获取验证码",self.num] forState:UIControlStateDisabled];
}

- (void)dealloc {
    [self stopTimer];
}

@end
