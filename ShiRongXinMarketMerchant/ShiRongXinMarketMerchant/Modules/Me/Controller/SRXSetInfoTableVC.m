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

@interface SRXSetInfoTableVC ()
@property (weak, nonatomic) IBOutlet SRXSetInfoShopTableView *shopTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopTableConsH;
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *psdView;

@end

@implementation SRXSetInfoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人设置";
    self.view.backgroundColor = CViewBgColor;
    self.shopTableConsH.constant = 3*50;
    self.shopTableView.datas = @[@"",@"",@""];
    
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
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return 40+3*50;
    } else {
        return UITableViewAutomaticDimension;
    }
}

@end
