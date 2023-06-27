//
//  SRXMessageSetTableVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMessageSetTableVC.h"
#import "SRXChatStateSwitchVC.h"
#import "SRXMsgSetAllReadVC.h"
#import "SRXChatFastTextVC.h"
#import "SRXChatTagsListVC.h"
#import "SRXChatQuickReplyVC.h"
#import "NetworkManager+MsgSet.h"

@interface SRXMessageSetTableVC ()
@property (weak, nonatomic) IBOutlet UILabel *stateLb;

@end

@implementation SRXMessageSetTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self requestChatStatus];
}

- (void)requestChatStatus {
    [NetworkManager getChatStatusWithShop_id:self.shop_id success:^(NSString *message) {
        int chat_status = message.intValue;
        if (chat_status == 1) {
            self.stateLb.text = @"值守中";
            self.stateLb.textColor = UIColorHex(0x1FBD00);
        } else {
            self.stateLb.text = @"休息中";
            self.stateLb.textColor = CRed;
        }
    } failure:^(NSString *message) {
        
    }];
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"----%zd----",indexPath.row);
    
    if (indexPath.row == 0) {
        SRXChatStateSwitchVC *vc = [[SRXChatStateSwitchVC alloc] init];
        vc.shop_id = self.shop_id;
        MJWeakSelf;
        vc.stateBlock = ^(NSUInteger type) {
            if (type == 0) {
                weakSelf.stateLb.text = @"值守中";
                weakSelf.stateLb.textColor = UIColorHex(0x1FBD00);
            } else {
                weakSelf.stateLb.text = @"休息中";
                weakSelf.stateLb.textColor = CRed;
            }
        };
        [self presentViewController:vc animated:YES completion:nil];
    } else if (indexPath.row == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
        SRXChatTagsListVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXChatTagsListVC"];
        vc.shop_id = self.shop_id;
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
        SRXChatQuickReplyVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXChatQuickReplyVC"];
        vc.shop_id = self.shop_id;
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
        SRXChatFastTextVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXChatFastTextVC"];
        vc.shop_id = self.shop_id;
        vc.type = SRXChatFastTextTypeWelcome;
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    } else if (indexPath.row == 4) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
        SRXChatFastTextVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXChatFastTextVC"];
        vc.shop_id = self.shop_id;
        vc.type = SRXChatFastTextTypeEvaluate;
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    } else if (indexPath.row == 5) {
        SRXMsgSetAllReadVC *vc = [[SRXMsgSetAllReadVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    } else{
        
    }
}

@end
