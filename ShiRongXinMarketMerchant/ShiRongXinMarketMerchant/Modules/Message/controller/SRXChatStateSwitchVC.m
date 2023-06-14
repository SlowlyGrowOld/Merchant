//
//  SRXChatStateSwitchVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatStateSwitchVC.h"
#import "NetworkManager+MsgSet.h"

@interface SRXChatStateSwitchVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation SRXChatStateSwitchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isBgClose = YES;
    [self.contentView settingRadius:20 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
}

- (IBAction)cancelBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)switchBtnClick:(UIButton *)sender {
    [SVProgressHUD show];
    [NetworkManager changeChatStatusWithChat_status:sender.tag==0?@"1":@"0" success:^(NSString *message) {
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.stateBlock) {
                self.stateBlock(sender.tag);
            }
        }];
    } failure:^(NSString *message) {
        
    }];
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
