//
//  SRXOrdersCenterPageC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/20.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrdersCenterPageC.h"
#import "QiPageContentView.h"
#import "QiPageMenuView.h"
#import "JKScrollView.h"
#import "SRXOrderListTableVC.h"
#import "SRXOrderRefundTableVC.h"

@interface SRXOrdersCenterPageC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet JKScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *menuBgView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewConsH;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UITextField *searchTF;
/** 标题数组 */
@property (nonatomic,strong) NSMutableArray *titles;
/** 分页视图 */
@property (nonatomic,strong) QiPageMenuView *menuView;
/** 控制器分组 */
@property (nonatomic,strong) NSMutableArray *vcs;
/** 内容视图 */
@property (nonatomic,strong) QiPageContentView *pageContentView;

@property (nonatomic,strong) SRXOrderListTableVC *currentVC;
@property (nonatomic,assign) BOOL canScroll;
@property (nonatomic,assign) CGFloat menuViewTopOffset;
@end

@implementation SRXOrdersCenterPageC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = YES;
    self.containerViewConsH.constant = kScreenHeight - TopHeight - 44;
    self.menuViewTopOffset = 36;
    self.canScroll = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeStatus) name:@"shop_home_leaveTop" object:nil];
    
    [self.view addSubview:self.titleLb];
    [self.view addSubview:self.searchView];
    [self.searchView addSubview:self.searchTF];
    [self initMenuView];
}

-(void)changeStatus{
    
    self.canScroll = YES;
    self.currentVC.canScroll = NO;
    self.currentVC.isPullDown = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollView=====滚动==%.2F",scrollView.contentOffset.y);
    /*
     当 底层滚动式图滚动到指定位置时，
     停止滚动，开始滚动子视图
     */
    self.currentVC = self.pageContentView.controllerArray[self.menuView.pageScrolledIndex];
    if (!self.canScroll) {
        if (self.currentVC.isPullDown) {
            scrollView.contentOffset = CGPointZero;
        } else {
            scrollView.contentOffset = CGPointMake(0, self.menuViewTopOffset);
        }
    } else if (scrollView.contentOffset.y >= self.menuViewTopOffset) {
        scrollView.contentOffset = CGPointMake(0, self.menuViewTopOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.currentVC.canScroll = YES;
            self.currentVC.isPullDown = NO;
        }
    }else if (scrollView.contentOffset.y < 0 ){
        scrollView.contentOffset = CGPointZero;
        self.canScroll = NO;
        self.currentVC.isPullDown = YES;
        self.currentVC.canScroll = YES;
    }else {
        self.canScroll = YES;
        self.currentVC.canScroll = NO;
        self.currentVC.isPullDown = NO;
    }
    if (scrollView.contentOffset.y<15) {
        self.titleLb.frame = CGRectMake((kScreenWidth - 96)/2-(kScreenWidth - 96)/2/15.0*scrollView.contentOffset.y, StatusBarHeight, 96, 44);
    }else {
        self.titleLb.frame = CGRectMake(0, StatusBarHeight, 96, 44);
    }
    if (scrollView.contentOffset.y<25) {
        self.searchView.frame = CGRectMake(15 + 82/25.0*scrollView.contentOffset.y, TopHeight + 4 - scrollView.contentOffset.y, kScreenWidth - 30 - 82/25.0*scrollView.contentOffset.y, 30);
    } else {
        self.searchView.frame = CGRectMake(15 + 82, TopHeight - 21 - 16/36.0*scrollView.contentOffset.y, kScreenWidth - 30 - 82, 30);
    }
}

-(void)initMenuView {

    NSDictionary *dataSource = @{
        QiPageMenuViewNormalTitleColor:CFont99,
        QiPageMenuViewSelectedTitleColor:C43B8F6,
        QiPageMenuViewTitleFont:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular],
        QiPageMenuViewSelectedTitleFont:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium],
        QiPageMenuViewHasUnderLine:@(YES),
        QiPageMenuViewItemTopPadding:@(0),
        QiPageMenuViewItemWidth:@(kScreenWidth/self.vcs.count),
        QiPageMenuViewItemsAutoResizing:@(NO),
        QiPageMenuViewItemIsVerticalCentred:@(NO),
        QiPageMenuViewItemHeight:@(40),
        QiPageMenuViewItemPadding:@(0),
        QiPageMenuViewLineTopPadding:(@-8),
        QiPageMenuViewHasUnderLine:@(NO),
        QiPageMenuViewLeftMargin:@(0),
        QiPageMenuViewRightMargin:@(0),
        QiPageMenuViewLineColor:C43B8F6,
        QiPageMenuViewLineHeight:@(2),
        QiPageMenuViewLineWidth:@(16),
    };
    self.menuView = [[QiPageMenuView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44) titles:self.titles dataSource:dataSource];
    self.menuView.backgroundColor = [UIColor clearColor];
    kWeakSelf;
    self.menuView.pageItemClicked = ^(NSInteger clickedIndex, NSInteger beforeIndex, QiPageMenuView *menu) {
        [weakSelf.pageContentView setPageContentShouldScrollToIndex:clickedIndex beforIndex:beforeIndex];
        weakSelf.currentVC.scrollTop = YES;
        weakSelf.currentVC = weakSelf.vcs[clickedIndex];
    };
    [self.menuBgView addSubview:self.menuView];
    
    self.pageContentView = [[QiPageContentView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight - TopHeight - 44) childViewController:self.vcs];
    self.pageContentView.canScroll = NO;
    self.pageContentView.canAnimated = NO;
    [self.containerView addSubview:self.pageContentView];
    self.menuView.pageScrolledIndex = 0;
    [self.pageContentView setPageContentShouldScrollToIndex:0 beforIndex:0];
    self.pageContentView.pageContentViewDidScroll = ^(NSInteger currentIndex, NSInteger beforeIndex, QiPageContentView * _Nonnull pageView) {
        weakSelf.menuView.pageScrolledIndex = currentIndex;
    };
}


-(NSMutableArray *)vcs {
    if (_vcs==nil) {
        _vcs = [NSMutableArray array];
        SRXOrderListTableVC *vc1 = [[SRXOrderListTableVC alloc] init];
        SRXOrderListTableVC *vc2 = [[SRXOrderListTableVC alloc] init];
        SRXOrderListTableVC *vc3 = [[SRXOrderListTableVC alloc] init];
        SRXOrderListTableVC *vc4 = [[SRXOrderListTableVC alloc] init];
        SRXOrderRefundTableVC *vc5 = [[SRXOrderRefundTableVC alloc] init];
        self.currentVC = vc1;
        _vcs = @[vc1,vc2,vc3,vc4,vc5].modelCopy;
    }
    return _vcs;
}

-(NSMutableArray *)titles {
    if (_titles==nil) {
        _titles = [NSMutableArray array];
        _titles = @[@"待发货",@"待收货",@"待付款",@"已完成",@"售后管理"].modelCopy;
    }
    return _titles;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 96)/2, StatusBarHeight, 96, 44)];
        _titleLb.text = @"订单中心";
        _titleLb.textColor = CNavBgFontColor;
        _titleLb.font = [UIFont systemFontOfSize:16];
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

- (UIView *)searchView {
    if (!_searchView) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(15, TopHeight + 4, kScreenWidth - 30, 30)];
        _searchView.backgroundColor = UIColorHex(0xF1F1F1);
        _searchView.layer.cornerRadius = 15;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 9, 12, 12)];
        imgView.image = [UIImage imageNamed:@"textfield_search"];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [_searchView addSubview:imgView];
    }
    return _searchView;
}

- (UITextField *)searchTF {
    if (!_searchTF) {
        _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(33, 0, kScreenWidth - 30 - 50, 30)];
        _searchTF.placeholder = @"请输入商品信息";
        _searchTF.font = [UIFont systemFontOfSize:13];
        _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _searchTF;
}

@end
