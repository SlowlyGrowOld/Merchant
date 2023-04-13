//
//  SRXLoadFailView.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/9/22.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXLoadFailView.h"

@interface SRXLoadFailView ()
@property (nonatomic, copy) dispatch_block_t refreshBlock;
@end

@implementation SRXLoadFailView

+ (SRXLoadFailView *)initWithSuperView:(UIView *)superView  btnBlock:(dispatch_block_t)block{
    return [self initWithSuperView:superView frame:CGRectMake(0, 0, superView.width, superView.height) btnBlock:block];
}

+ (SRXLoadFailView *)initWithSuperView:(UIView *)superView frame:(CGRect)frame  btnBlock:(dispatch_block_t)block{
    SRXLoadFailView *failView = [[SRXLoadFailView alloc] initWithFrame:frame];
    [failView configUI];
    failView.refreshBlock = block;
    [superView addSubview:failView];
    return failView;
}

- (instancetype)initWithFrame:(CGRect)frame btnBlock:(dispatch_block_t)block
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        self.refreshBlock = block;
    }
    return self;
}

- (void)configUI {

    self.backgroundColor = UIColor.whiteColor;
    BOOL isNet = [[NSUserDefaults standardUserDefaults] boolForKey:KNotificationNetWorkState];
    
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"网络请求失败";
    titleLb.textColor = CFont66;
    titleLb.font = [UIFont systemFontOfSize:16];
    [self addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-10);
    }];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"no_net_icon"];
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleLb.mas_top).offset(-10);
        make.centerX.mas_equalTo(0);
    }];
    
    UILabel *hintLb = [UILabel new];
    hintLb.text = isNet?@"":@"网络异常，请检查您的网络";
    hintLb.textColor = CFont99;
    hintLb.font = [UIFont systemFontOfSize:12];
    [self addSubview:hintLb];
    [hintLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLb.mas_bottom).offset(5);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"重新加载" forState:UIControlStateNormal];
    [btn setTitleColor:CFont66 forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.layer.borderColor = CFont66.CGColor;
    btn.layer.borderWidth = 0.5;
    btn.layer.cornerRadius = 2;
    [btn addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hintLb.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
}

- (void)showWithSuperView:(UIView *)superView {
    [self dismiss];
    [superView addSubview:self];
}

- (void)dismiss {
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (void)refreshData {
    if (self.refreshBlock) {
        self.refreshBlock();
    }
    [self dismiss];
}

@end
