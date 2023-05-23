//
//  SRXPhoneCurrentVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXPhoneCurrentVC.h"

@interface SRXPhoneCurrentVC ()
@property (weak, nonatomic) IBOutlet UILabel *current_mobile;

@end

@implementation SRXPhoneCurrentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"当前手机号";
    
    self.current_mobile.text = self.mobile;
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
