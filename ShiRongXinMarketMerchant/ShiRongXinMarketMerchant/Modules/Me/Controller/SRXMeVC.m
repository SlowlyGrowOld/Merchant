//
//  SRXMeVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/17.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMeVC.h"
#import "SRXMeCollectionView.h"
#import "NetworkManager+Me.h"
#import "SRXSetInfoTableVC.h"
#import "SRXCreateTimeFilterView.h"
#import "SRXShopSwitchTableVC.h"

@interface SRXMeVC ()
@property (weak, nonatomic) IBOutlet SRXMeCollectionView *orderCollectionView;
@property (weak, nonatomic) IBOutlet SRXMeCollectionView *shopCollectionView;
@property (weak, nonatomic) IBOutlet SRXMeCollectionView *incomeCollectionView;
@property (weak, nonatomic) IBOutlet SRXMeCollectionView *otherCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *shopSwitch;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
@property (nonatomic, strong) SRXCreateTimeFilterView *timeFilter;
@property (nonatomic, copy) NSString *start_date;
@property (nonatomic, copy) NSString *end_date;
@end

@implementation SRXMeVC

- (SRXCreateTimeFilterView *)timeFilter {
    if (!_timeFilter) {
        _timeFilter = [[NSBundle mainBundle] loadNibNamed:@"SRXCreateTimeFilterView" owner:nil options:nil].firstObject;
        _timeFilter.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _timeFilter.parameters = [SRXGoodsListParameter new];
        MJWeakSelf;
        _timeFilter.closeBlock = ^(SRXGoodsListParameter * _Nullable parameters) {
            weakSelf.start_date = parameters.start_time;
            weakSelf.end_date = parameters.end_time;
            [weakSelf requestData];
        };
    }
    return _timeFilter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHidenNaviBar = YES;
    self.tableView.backgroundColor = CViewBgColor;
    [self.shopSwitch settingRadius:14 corner:UIRectCornerTopLeft|UIRectCornerBottomLeft];
    [self.shopSwitch setImagePosition:LXMImagePositionRight spacing:4];
    [self.filterBtn setImagePosition:LXMImagePositionRight spacing:4];
    
    self.orderCollectionView.type = SRXMeCollectionTypeImage;
    self.orderCollectionView.jumpType = SRXMeCollectionJumpTypeMyOrder;
    self.orderCollectionView.datas = @[[SRXMeCollectionModel configWithTitle:@"待发货" content:@"me_shipping"],[SRXMeCollectionModel configWithTitle:@"待付款" content:@"me_unpaid"],[SRXMeCollectionModel configWithTitle:@"待收货" content:@"me_receiving"],[SRXMeCollectionModel configWithTitle:@"退款/售后" content:@"me_return"]];
    self.shopCollectionView.type = SRXMeCollectionTypeText;
    self.shopCollectionView.datas = @[[SRXMeCollectionModel configWithTitle:@"订单总数" content:@"0"],[SRXMeCollectionModel configWithTitle:@"昨日订单" content:@"0"]];
    self.incomeCollectionView.type = SRXMeCollectionTypeText;
    self.incomeCollectionView.datas = @[[SRXMeCollectionModel configWithTitle:@"积分抵扣" content:@"0"],[SRXMeCollectionModel configWithTitle:@"微信支付" content:@"0"],[SRXMeCollectionModel configWithTitle:@"支付宝" content:@"0"],[SRXMeCollectionModel configWithTitle:@"余额" content:@"0"],[SRXMeCollectionModel configWithTitle:@"优惠卷" content:@"0"],[SRXMeCollectionModel configWithTitle:@"运费" content:@"0"]];
    self.otherCollectionView.type = SRXMeCollectionTypeImage;
    self.otherCollectionView.jumpType = SRXMeCollectionJumpTypeOther;
    self.otherCollectionView.datas = @[[SRXMeCollectionModel configWithTitle:@"商品管理" content:@"me_goods_manage"],[SRXMeCollectionModel configWithTitle:@"订单管理" content:@"me_order_manage"]];
    
    [self requestData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
}

- (void)requestData {
    
    [NetworkManager getShopInfoWithShop_id:[UserManager sharedUserManager].curUserInfo.shop_id success:^(SRXShopInfoModel * _Nonnull info) {
        [self.tableView.mj_header endRefreshing];
        self.nameLb.text = info.shop_info.shop_user_nickname;
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:info.shop_info.shop_user_avatar]];
        self.shop_name.text = info.shop_info.shop_img;
        self.shopCollectionView.datas = @[[SRXMeCollectionModel configWithTitle:@"订单总数" content:@(info.order_num_info.all_order_num).stringValue],[SRXMeCollectionModel configWithTitle:@"昨日订单" content:@(info.order_num_info.yesterday_order_num).stringValue]];
    } failure:^(NSString *message) {
        [self.tableView.mj_header endRefreshing];
    }];
    
    [NetworkManager getIncomeInfoWithShop_id:[UserManager sharedUserManager].curUserInfo.shop_id start_date:self.start_date end_date:self.end_date success:^(SRXIncomeInfo * _Nonnull info) {
        self.incomeCollectionView.datas = @[[SRXMeCollectionModel configWithTitle:@"积分抵扣" content:info.integral_num],[SRXMeCollectionModel configWithTitle:@"微信支付" content:info.wechat_pay],[SRXMeCollectionModel configWithTitle:@"支付宝" content:info.ali_pay],[SRXMeCollectionModel configWithTitle:@"余额" content:info.balance_pay],[SRXMeCollectionModel configWithTitle:@"优惠卷" content:info.coupon_pay],[SRXMeCollectionModel configWithTitle:@"运费" content:info.shipping_pay]];
    } failure:^(NSString *message) {
        
    }];
}

- (IBAction)filterIncomeBtnClick:(id)sender {
    if (self.timeFilter.superview) {
        [self.timeFilter dismiss];
    } else {
        [[UIApplication sharedApplication].keyWindow addSubview:self.timeFilter];
    }
}

- (IBAction)switchShopBtnClick:(id)sender {
    SRXShopSwitchTableVC *vc = [[SRXShopSwitchTableVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"setInfo"]) {
        SRXSetInfoTableVC *vc = [segue destinationViewController];
        MJWeakSelf;
        vc.refreshBlock = ^{
            [weakSelf requestData];
        };
    }
}

@end
