//
//  SRXSetInfoTableVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/18.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXSetInfoTableVC.h"
#import "SRXSetInfoShopTableView.h"
#import "SRXPhoneCurrentVC.h"
#import "SRXPasswordUpdateVC.h"
#import "NetworkManager+Me.h"

@interface SRXSetInfoTableVC ()
@property (weak, nonatomic) IBOutlet SRXSetInfoShopTableView *shopTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopTableConsH;
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *psdView;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *mobile;

@property (nonatomic, strong) SRXMeInfo *meInfo;
@end

@implementation SRXSetInfoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人设置";
    self.view.backgroundColor = CViewBgColor;
    
    MJWeakSelf;
    [self.phoneView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        UIStoryboard *me = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
        SRXPhoneCurrentVC *vc = [me instantiateViewControllerWithIdentifier:@"SRXPhoneCurrentVC"];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self.psdView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        UIStoryboard *me = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
        SRXPasswordUpdateVC *vc = [me instantiateViewControllerWithIdentifier:@"SRXPasswordUpdateVC"];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [self requestData];
}

- (void)requestData {
    [NetworkManager getMeInfoWithSuccess:^(SRXMeInfo * _Nonnull info) {
        self.meInfo = info;
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:info.shop_user_info.avatar]];
        self.nickname.text = info.shop_user_info.nickname;
        self.account.text = info.shop_user_info.username;
        self.mobile.text = info.shop_user_info.mobile;
        self.shopTableConsH.constant = info.shop_arr.count*50;
        self.shopTableView.datas = info.shop_arr;
        [self.tableView reloadData];
    } failure:^(NSString *message) {
    
    }];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return 40+self.meInfo.shop_arr.count*50;
    } else {
        return UITableViewAutomaticDimension;
    }
}

@end
