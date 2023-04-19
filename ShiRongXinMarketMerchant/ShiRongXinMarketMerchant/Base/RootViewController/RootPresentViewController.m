//
//  RootPresentViewController.m
//  SeaStarVoiceProject
//
//  Created by 薛静鹏 on 2020/1/10.
//  Copyright © 2020 薛静鹏. All rights reserved.
//

#import "RootPresentViewController.h"

@interface RootPresentViewController ()<UIViewControllerTransitioningDelegate>

/** 背景 */
@property (nonatomic,strong) UIView *bgView;
/** UIPresentationController */
@property (nonatomic,strong) UIPresentationController *presentation;
@end

@implementation RootPresentViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}
-(instancetype)init{
    if (self = [super init]) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:self.bgView atIndex:0];
    
}
-(void)close:(id)tap{
    if (self.isBgClose) {
        if (self.navigationController) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
}

-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.bgView.backgroundColor = bgColor;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _bgView.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close:)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}
@end
