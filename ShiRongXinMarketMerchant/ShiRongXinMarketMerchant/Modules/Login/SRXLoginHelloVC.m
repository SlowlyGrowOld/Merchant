//
//  SRXLoginVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXLoginHelloVC.h"

@interface SRXLoginHelloVC ()

@end

@implementation SRXLoginHelloVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isHidenNaviBar = YES;
    [[JHWebSocketManager shareInstance] destoryHeart];
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
