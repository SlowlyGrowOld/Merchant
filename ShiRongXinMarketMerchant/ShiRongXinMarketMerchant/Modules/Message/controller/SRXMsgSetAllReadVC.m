//
//  SRXMsgSetAllReadVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMsgSetAllReadVC.h"
#import "NetworkManager+MsgSet.h"

@interface SRXMsgSetAllReadVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation SRXMsgSetAllReadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isBgClose = YES;
    [self.contentView settingRadius:20 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
}
- (IBAction)cancelBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sureBtnClick:(id)sender {
    [NetworkManager markChatAllReadWithSuccess:^(NSString *message) {
        KPostNotification(KNotificationMsgAllRead, nil);
        [self dismissViewControllerAnimated:YES completion:^{
            [SVProgressHUD showSuccessWithStatus:@"已读完成"];
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
