//
//  SRXLoginProtocolVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/14.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXLoginProtocolVC.h"

@interface SRXLoginProtocolVC ()<UITextViewDelegate>

@end

@implementation SRXLoginProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = UIColor.whiteColor;
    bgView.layer.cornerRadius = 10;
    bgView.clipsToBounds = YES;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(140);
        make.centerY.mas_equalTo(0);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = UIColorHex(0xD8D8D8);
    [bgView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(-52);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = UIColorHex(0xD8D8D8);
    [bgView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
    }];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancel setTitleColor:CFont99 forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancel];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.right.equalTo(line2.mas_left);
        make.height.mas_equalTo(52);
    }];
    UIButton *agree = [UIButton buttonWithType:UIButtonTypeCustom];
    [agree setTitle:@"同意并继续" forState:UIControlStateNormal];
    agree.titleLabel.font = [UIFont systemFontOfSize:18];
    [agree setTitleColor:C43B8F6 forState:UIControlStateNormal];
    [agree addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:agree];
    [agree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.left.equalTo(line2.mas_right);
        make.height.mas_equalTo(52);
    }];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.attributedText = self.createProtocolText;
    textView.delegate = self;
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    textView.linkTextAttributes = @{NSForegroundColorAttributeName:UIColorHex(0x43B8F6)};
    [bgView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(30);
        make.bottom.equalTo(line1.mas_top).offset(-5);
    }];
}

- (void)cancelBtnClick {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)agreeBtnClick {
    [self dismissViewControllerAnimated:NO completion:^{
        if (self.agreeBlock) {self.agreeBlock();}
    }];
}

-(NSMutableAttributedString *)createProtocolText{
    //普通字体的大小颜色
    NSDictionary * normalAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:UIColorHex(0x333333)};
   
    //可点击字体的大小颜色
    NSDictionary * specAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:UIColorHex(0x43B8F6)};
    
    //生成默认的字符串
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意《够容易用户协议》、《够容易隐私政策》。 并授权够容易使用相关帐号信息。" attributes:normalAtt];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 2;
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attStr.length)];
    
    //添加点击事件
    NSString * value = [NSString stringWithFormat:@"clickprotocol://"];
    [attStr addAttribute:NSLinkAttributeName value:value range:[[attStr string] rangeOfString:@"《够容易用户协议》、"]];
    NSString * value1 = [NSString stringWithFormat:@"clickprivacy://"];
    [attStr addAttribute:NSLinkAttributeName value:value1 range:[[attStr string] rangeOfString:@"《够容易隐私政策》。"]];
    
    //设置居中
    [attStr addAttributes:specAtt range:[[attStr string] rangeOfString:@"《够容易用户协议》、《够容易隐私政策》。"]];
    
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
