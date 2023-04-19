//
//  SRXMeVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/17.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMeVC.h"
#import "SRXMeCollectionView.h"

@interface SRXMeVC ()
@property (weak, nonatomic) IBOutlet SRXMeCollectionView *orderCollectionView;
@property (weak, nonatomic) IBOutlet SRXMeCollectionView *shopCollectionView;
@property (weak, nonatomic) IBOutlet SRXMeCollectionView *incomeCollectionView;
@property (weak, nonatomic) IBOutlet SRXMeCollectionView *otherCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *shopSwitch;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@end

@implementation SRXMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHidenNaviBar = YES;
    self.tableView.backgroundColor = CViewBgColor;
    [self.shopSwitch settingRadius:14 corner:UIRectCornerTopLeft|UIRectCornerBottomLeft];
    [self.shopSwitch setImagePosition:LXMImagePositionRight spacing:4];
    
    self.orderCollectionView.type = SRXMeCollectionTypeImage;
    self.orderCollectionView.datas = @[[SRXMeCollectionModel configWithTitle:@"待付款" content:@"me_unpaid"],[SRXMeCollectionModel configWithTitle:@"待发货" content:@"me_shipping"],[SRXMeCollectionModel configWithTitle:@"待收货" content:@"me_receiving"],[SRXMeCollectionModel configWithTitle:@"退款/售后" content:@"me_return"]];
    self.shopCollectionView.type = SRXMeCollectionTypeText;
    self.shopCollectionView.datas = @[[SRXMeCollectionModel configWithTitle:@"订单总数" content:@"0"],[SRXMeCollectionModel configWithTitle:@"昨日订单" content:@"0"]];
    self.incomeCollectionView.type = SRXMeCollectionTypeText;
    self.incomeCollectionView.datas = @[[SRXMeCollectionModel configWithTitle:@"积分抵扣" content:@"0"],[SRXMeCollectionModel configWithTitle:@"微信支付" content:@"0"],[SRXMeCollectionModel configWithTitle:@"支付宝" content:@"0"],[SRXMeCollectionModel configWithTitle:@"余额" content:@"0"],[SRXMeCollectionModel configWithTitle:@"优惠卷" content:@"0"],[SRXMeCollectionModel configWithTitle:@"运费" content:@"0"]];
    self.otherCollectionView.type = SRXMeCollectionTypeImage;
    self.otherCollectionView.datas = @[[SRXMeCollectionModel configWithTitle:@"商品管理" content:@"me_goods_manage"],[SRXMeCollectionModel configWithTitle:@"订单管理" content:@"me_order_manage"]];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 261+StatusBarHeight;
    } else if (indexPath.section == 2) {
        return 172;
    } else {
        return 112;
    }
}

#pragma mark - button event

- (IBAction)setBtnClick:(id)sender {
    
}



@end
