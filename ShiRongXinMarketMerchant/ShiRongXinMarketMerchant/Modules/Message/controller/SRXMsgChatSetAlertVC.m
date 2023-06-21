//
//  SRXMsgChatSetAlertVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/19.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMsgChatSetAlertVC.h"
#import "SRXChatTransferServiceVC.h"
#import "NetworkManager+Message.h"

@interface SRXMsgChatSetAlertVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *remove_chat;
@property (weak, nonatomic) IBOutlet UIView *transfer_chat;
@property (weak, nonatomic) IBOutlet UITextField *remarkTF;
@property (weak, nonatomic) IBOutlet UIButton *oneTagBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoTagBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeTagBtn;

@end

@implementation SRXMsgChatSetAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.contentView settingRadius:20 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    [self.oneTagBtn setImagePosition:LXMImagePositionLeft spacing:4];
    [self.twoTagBtn setImagePosition:LXMImagePositionLeft spacing:4];
    [self.threeTagBtn setImagePosition:LXMImagePositionLeft spacing:4];
    MJWeakSelf;
    [self.remove_chat jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [weakSelf removeUser];
    }];
    [self.transfer_chat jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [weakSelf transferUser];
    }];
    self.remarkTF.text = self.item.nickname;
}

- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)removeUser {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否移除对话？" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"移除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [NetworkManager removeChatUserWithUser_id:self.item.user_id shop_id:@"" success:^(NSString *message) {
            if (self.refreshBlock) {
                self.refreshBlock();
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSString *message) {
            
        }];
    }]];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)transferUser {
    SRXChatTransferServiceVC *vc = [[SRXChatTransferServiceVC alloc] init];
    MJWeakSelf;
    vc.serviceBlock = ^(SRXMsgChatServiceItem * _Nonnull item) {
        [NetworkManager transferChatServiceWithUser_id:[UserManager sharedUserManager].curUserInfo._id shop_user_id:item.shop_user_id success:^(NSString *message) {
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                            
            }];
            } failure:^(NSString *message) {
            
        }];
    };
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    if ([textField.text isEqualToString:self.item.nickname]) {
        return YES;
    }
    [NetworkManager setChatRemarkWithUser_id:self.item.user_id shop_id:@"" remark_name:textField.text success:^(NSString *message) {
        
    } failure:^(NSString *message) {
        
    }];
    return YES;
}

@end
