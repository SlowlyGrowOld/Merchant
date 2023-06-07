//
//  SRXGoodsEditQuitAlertVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/6.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsEditQuitAlertVC.h"

@interface SRXGoodsEditQuitAlertVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation SRXGoodsEditQuitAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isBgClose = YES;
    [self.contentView settingRadius:20 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
}
- (IBAction)continueEditBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)quitBtnClick:(id)sender {
    if (self.quitBlock) {
        [self dismissViewControllerAnimated:YES completion:^{
            self.quitBlock();
        }];
    } else {
        
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
