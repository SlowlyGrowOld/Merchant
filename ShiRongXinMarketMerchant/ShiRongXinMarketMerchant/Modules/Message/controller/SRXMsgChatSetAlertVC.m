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
#import "SRXChatTagsCollectionCell.h"
#import "NetworkManager+MsgSet.h"
#import "UIColor+JHExt.h"
#import "SRXChatTagsListVC.h"
#import "SRXChatTransferShopVC.h"

@interface SRXMsgChatSetAlertVC ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *remove_chat;
@property (weak, nonatomic) IBOutlet UIView *transfer_chat;
@property (weak, nonatomic) IBOutlet UITextField *remarkTF;
@property (weak, nonatomic) IBOutlet UICollectionView *tagsCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsViewConsH;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SRXMsgChatSetAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.'
    self.isBgClose = YES;
    [self.contentView settingRadius:20 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    [self.tagsCollectionView registerNib:[UINib nibWithNibName:@"SRXChatTagsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXChatTagsCollectionCell"];
    MJWeakSelf;
    [self.remove_chat jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [weakSelf removeUser];
    }];
    [self.transfer_chat jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [weakSelf transferUser];
    }];
    self.remarkTF.text = self.model.nickname;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goTagsListBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    SRXChatTagsListVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXChatTagsListVC"];
    vc.shop_id = self.shop_id;
    RootNavigationController *nav = [[RootNavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = 0;
    [self presentViewController:nav animated:YES completion:^{
    }];
}

- (void)removeUser {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否移除对话？" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"移除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [NetworkManager removeChatUserWithUser_id:self.model.user_id shop_id:self.shop_id success:^(NSString *message) {
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
    if ([UserManager sharedUserManager].curUserInfo.is_mine_pipe == 1) {
        SRXChatTransferShopVC *vc = [[SRXChatTransferShopVC alloc] init];
        MJWeakSelf;
        vc.serviceBlock = ^(SRXChatShopNumItem * _Nonnull shop) {
            [weakSelf transferServiceWithTo_shop_id:shop.shop_id];
        };
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        [self transferServiceWithTo_shop_id:nil];
    }
}
//转接店铺列表的shop_id，is_mine_pipe=1时传
- (void)transferServiceWithTo_shop_id:(nullable NSString *)to_shop_id {
    SRXChatTransferServiceVC *vc = [[SRXChatTransferServiceVC alloc] init];
    vc.shop_id = self.shop_id;
    MJWeakSelf;
    vc.serviceBlock = ^(SRXMsgChatServiceItem * _Nonnull item) {
        [NetworkManager transferChatServiceWithUser_id:weakSelf.model.user_id shop_user_id:item.shop_user_id shop_id:weakSelf.shop_id to_shop_id:to_shop_id success:^(NSString *message) {
            [weakSelf sendChatMessageWithTransfer:item];
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                            
            }];
        } failure:^(NSString *message) {
            
        }];
    };
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)sendChatMessageWithTransfer:(SRXMsgChatServiceItem *)item {
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    dicM[@"user_id"] = self.model.user_id;
    dicM[@"msg_type"] = @"transfer";
    dicM[@"params"] = item.shop_user_id;

    [NetworkManager sentChatMsgWithParameters:dicM.copy shop_id:self.shop_id success:^(NSString *message) {
    } failure:^(NSString *message) {

    }];
}

- (void)requestData {
    [NetworkManager getShopLabelsWithShop_id:self.shop_id user_id:self.model.user_id success:^(NSArray *modelList) {
        self.datas = modelList;
        self.tagsViewConsH.constant = modelList.count>0?83:46;
        [self.tagsCollectionView reloadData];
    } failure:^(NSString *message) {
        
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:self.model.nickname]) {
        return;
    }
    [NetworkManager setChatRemarkWithUser_id:self.model.user_id shop_id:self.shop_id remark_name:textField.text success:^(NSString *message) {
        if (self.refreshBlock) {
            self.refreshBlock();
        }
    } failure:^(NSString *message) {
        
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXChatTagsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXChatTagsCollectionCell" forIndexPath:indexPath];
    SRXMsgLabelsItem *item = self.datas[indexPath.row];
    [cell.btn setTitle:item.label_name forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"star_yellow"];
    [cell.btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [cell.btn.imageView setTintColor:[UIColor colorWithHexString:item.label_color_number alpha:1]];
    if (item.is_chose) {
        cell.backgroundColor = [C43B8F6 colorWithAlphaComponent:0.15];
    } else {
        cell.backgroundColor = [UIColorHex(0x969696) colorWithAlphaComponent:0.15];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(94, 25);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXMsgLabelsItem *item = self.datas[indexPath.row];
    if (item.is_chose) {
        [SVProgressHUD show];
        [NetworkManager removeChatUserLabelWithUser_id:self.model.user_id label_id:item.label_id shop_id:self.shop_id success:^(NSString *message) {
            item.is_chose = NO;
            [self.tagsCollectionView reloadData];
        } failure:^(NSString *message) {
            
        }];
    }else {
        NSMutableArray *mArr = [NSMutableArray array];
        for (SRXMsgLabelsItem *item in self.datas) {
            if (item.is_chose) {
                [mArr addObject:item];
            }
        }
        if (mArr.count>2) {
            [SVProgressHUD showInfoWithStatus:@"用户标签最多设置三个！"];
        }else {
            [SVProgressHUD show];
            [NetworkManager addChatUserLabelWithUser_id:self.model.user_id label_id:item.label_id shop_id:self.shop_id success:^(NSString *message) {
                item.is_chose = YES;
                [self.tagsCollectionView reloadData];
            } failure:^(NSString *message) {
                
            }];
        }
    }
}
@end
