//
//  SRXBasePopupVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2022/6/29.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXBasePopupVC.h"

@interface SRXBasePopupVC ()

@end

@implementation SRXBasePopupVC

-(instancetype)init{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.clearColor;
    self.headHeight = 300;
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.titleLb];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(34);
    }];
    [self.bottomView addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.equalTo(self.titleLb);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(54);
    }];
    [self.bottomView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.top.mas_equalTo(50);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.4];
        [self.bottomView setFrame:CGRectMake(0, self.headHeight, kScreenWidth, kScreenHeight - self.headHeight)];
    }];
}

- (void)dismissVC {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.01];
        [self.bottomView setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - self.headHeight)];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (point.y < self.headHeight) {
        [self dismissVC];
    }
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - self.headHeight)];
        [_bottomView settingRadius:30 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
        _bottomView.backgroundColor = UIColor.whiteColor;
    }
    return _bottomView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.text = @"title";
        _titleLb.textColor = CFont3D;
        _titleLb.font = [UIFont systemFontOfSize:16];
    }
    return _titleLb;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"XCircle"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
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
