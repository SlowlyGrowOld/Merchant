//
//  RootWebViewController.m
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import "RootWebViewController.h"
#import <YYKit.h>

@interface RootWebViewController ()<WKNavigationDelegate>

@property (nonatomic,assign) double lastProgress;//上次进度条位置
@end

@implementation RootWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)dealloc{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

