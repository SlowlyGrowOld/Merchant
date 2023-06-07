//
//  SRXGoodsListPageVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsListPageVC.h"
#import "QiPageContentView.h"
#import "JKScrollView.h"
#import "SRXGoodsListTableVC.h"
#import "SRXShopSwitchTableViewController.h"
#import "SRXGoodsInfoEditPageVC.h"

#import "SRXGoodsMoreFilterView.h"
#import "SRXShopClassFilterView.h"
#import "SRXCreateTimeFilterView.h"
#import "SRXGoodsListEditBottomView.h"
#import "SRXGoodsListModel.h"
#import "NetworkManager+Goods.h"

@interface SRXGoodsListPageVC ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet JKScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewConsH;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewConsH;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIButton *switch_shop;
@property (weak, nonatomic) IBOutlet UIView *slider;
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *auditBtn;
@property (weak, nonatomic) IBOutlet UIButton *outBtn;
@property (weak, nonatomic) IBOutlet UIButton *createTime;
@property (weak, nonatomic) IBOutlet UIButton *shopClass;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
@property (weak, nonatomic) IBOutlet UIButton *batchBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (nonatomic, strong) UIButton *selectBtn;
/** 控制器分组 */
@property (nonatomic,strong) NSMutableArray *vcs;
/** 内容视图 */
@property (nonatomic,strong) QiPageContentView *pageContentView;

@property (nonatomic,strong) SRXGoodsListTableVC *currentVC;
@property (nonatomic,assign) BOOL canScroll;
@property (nonatomic,assign) CGFloat menuViewTopOffset;
@property (nonatomic,assign) NSInteger pageScrolledIndex;

@property (nonatomic,strong) SRXCreateTimeFilterView *timeFilter;
@property (nonatomic,strong) SRXGoodsMoreFilterView *moreFilter;
@property (nonatomic,strong) SRXShopClassFilterView *classFilter;
@property (nonatomic, strong) SRXGoodsListEditBottomView *bottomView;

@property (nonatomic, strong) SRXGoodsListParameter *parameters;
@property (nonatomic, copy) NSString *select_good_id;
@end

@implementation SRXGoodsListPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isHidenNaviBar = YES;
    [self initMenuView];
    [self.addBtn.superview settingRadius:10 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    [self.switch_shop setImagePosition:LXMImagePositionRight spacing:5];
    [self.createTime setImagePosition:LXMImagePositionRight spacing:5];
    [self.shopClass setImagePosition:LXMImagePositionRight spacing:5];
    [self.filterBtn setImagePosition:LXMImagePositionRight spacing:5];
    self.selectBtn = self.saleBtn;
    self.headViewConsH.constant = StatusBarHeight + 144;
    self.containerViewConsH.constant = kScreenHeight - TopHeight - TabbarHeight;
    self.menuViewTopOffset = 100;
    self.canScroll = YES;
    self.pageScrolledIndex = 0;
    self.parameters = [SRXGoodsListParameter new];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeStatus) name:@"goods_leaveTop" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goodsListEditchange:) name:@"KNotificationEditChange" object:nil];
}

- (IBAction)switchMenuViewBtnClick:(UIButton *)sender {
    self.currentVC.isEdit = NO;
    [self setBatchStatus];
    if (sender == self.saleBtn) {[self sliderViewWith:0];}
    if (sender == self.editBtn) {[self sliderViewWith:1];}
    if (sender == self.auditBtn) {[self sliderViewWith:2];}
    if (sender == self.outBtn) {[self sliderViewWith:3];}
}

- (void)sliderViewWith:(NSInteger)index {
    [self.pageContentView setPageContentShouldScrollToIndex:index beforIndex:self.pageScrolledIndex];
    self.currentVC.scrollTop = YES;
    self.currentVC = self.vcs[index];
    self.currentVC.search_word = self.searchTF.text;
    self.parameters = self.currentVC.parameters?:[SRXGoodsListParameter new];
    CGFloat x = (kScreenWidth-30)/4;
    self.pageScrolledIndex = index;
    self.selectBtn.selected = !self.selectBtn.isSelected;
    if (index == 0) {x = 1; self.saleBtn.selected = YES; self.selectBtn = self.saleBtn;}
    if (index == 1) {x = x; self.editBtn.selected = YES; self.selectBtn = self.editBtn;}
    if (index == 2) {x = x*2; self.auditBtn.selected = YES; self.selectBtn = self.auditBtn;}
    if (index == 3) {x = x*3-2; self.outBtn.selected = YES; self.selectBtn = self.outBtn;}
    self.batchBtn.hidden = index==0?NO:YES;
    self.slider.transform = CGAffineTransformMakeTranslation(x,0);
}

- (IBAction)batchBtnClick:(id)sender {
    [self clearFilterBtnSelect];
    self.currentVC.isEdit = !self.currentVC.isEdit;
    [self setBatchStatus];
}

- (void)setBatchStatus {
    if (self.currentVC.isEdit) {
        [self.batchBtn setTitleColor:C43B8F6 forState:UIControlStateNormal];
        self.batchBtn.layer.borderColor = C43B8F6.CGColor;
        [self.view addSubview:self.bottomView];
    } else {
        [self.batchBtn setTitleColor:CFont99 forState:UIControlStateNormal];
        self.batchBtn.layer.borderColor = CFont99.CGColor;
        [self.bottomView removeFromSuperview];
    }
}

- (IBAction)addGoodsBtnClick:(id)sender {
    [self clearFilterBtnSelect];
    SRXGoodsInfoEditPageVC *vc = [[SRXGoodsInfoEditPageVC alloc] init];
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (IBAction)creatTimeBtnClick:(id)sender {
    [self switchFilterView:self.createTime];
}

- (IBAction)shopClassBtnClick:(id)sender {
    [self switchFilterView:self.shopClass];
}

- (IBAction)filterBtnClick:(id)sender {
    [self switchFilterView:self.filterBtn];
}

- (void)clearFilterBtnSelect {
    if (self.createTime.isSelected) {
        [self.timeFilter dismiss];
    } else if (self.shopClass.isSelected){
        [self.classFilter dismiss];
    }else if (self.filterBtn.isSelected){
        [self.moreFilter dismiss];
    }
}

- (void)switchFilterView:(UIButton *)sender {
    self.canScroll = YES;
    if (sender == self.shopClass) {
        if(sender.isSelected){
            [self.classFilter dismiss];
            return;
        }else if (self.createTime.isSelected) {
            [self.timeFilter dismiss];
        }else if (self.filterBtn.isSelected){
            [self.moreFilter dismiss];
        }
    } else if (sender == self.filterBtn) {
        if(sender.isSelected){
            [self.moreFilter dismiss];
            return;
        }else if (self.createTime.isSelected) {
            [self.timeFilter dismiss];
        } else if (self.shopClass.isSelected){
            [self.classFilter dismiss];
        }
    }else {
        if(sender.isSelected){
            [self.timeFilter dismiss];
            return;
        }else if (self.shopClass.isSelected){
            [self.classFilter dismiss];
        }else if (self.filterBtn.isSelected){
            [self.moreFilter dismiss];
        }
    }

    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, self.menuViewTopOffset) animated:NO];
    } completion:^(BOOL finished) {
        if (sender == self.shopClass) {
            self.classFilter.parameters = self.parameters;
            [[UIApplication sharedApplication].keyWindow addSubview:self.classFilter];
            self.shopClass.selected = YES;
        } else if (sender == self.filterBtn) {
            self.moreFilter.parameters = self.parameters;
            [[UIApplication sharedApplication].keyWindow addSubview:self.moreFilter];
            self.filterBtn.selected = YES;
        }else {
            self.timeFilter.parameters = self.parameters;
            [[UIApplication sharedApplication].keyWindow addSubview:self.timeFilter];
            self.createTime.selected = YES;
        }
    }];
}

- (IBAction)switchShopBtnClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    SRXShopSwitchTableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SRXShopSwitchTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goodsListEditchange:(NSNotification *)info {
    NSDictionary *dic = info.userInfo[@"info"];
    BOOL isAll = [dic[@"isAll"] boolValue];
    self.bottomView.allBtn.selected = isAll;
    self.bottomView.select_num.text = dic[@"select_num"];
    NSString *select_num = dic[@"select_num"];
    if (select_num.intValue==0){self.bottomView.batchBtn.alpha = 0.3;self.bottomView.batchBtn.enabled = NO;}else {self.bottomView.batchBtn.alpha = 1;self.bottomView.batchBtn.enabled = YES;}
    self.select_good_id = dic[@"good_id"];
}

-(void)changeStatus{
    
    self.canScroll = YES;
    self.currentVC.canScroll = NO;
    self.currentVC.isPullDown = NO;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView=====滚动==%.2F",scrollView.contentOffset.y);
    /*
     当 底层滚动式图滚动到指定位置时，
     停止滚动，开始滚动子视图
     */
    self.currentVC = self.pageContentView.controllerArray[self.pageScrolledIndex];
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
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (![self.currentVC.search_word isEqualToString:textField.text]) {
        self.currentVC.search_word = textField.text;
    }
}

-(void)initMenuView {
    
    self.pageContentView = [[QiPageContentView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight - TopHeight - TabbarHeight) childViewController:self.vcs];
    self.pageContentView.canScroll = NO;
    self.pageContentView.canAnimated = NO;
    [self.containerView addSubview:self.pageContentView];
    [self.pageContentView setPageContentShouldScrollToIndex:0 beforIndex:0];
    MJWeakSelf;
    self.pageContentView.pageContentViewDidScroll = ^(NSInteger currentIndex, NSInteger beforeIndex, QiPageContentView * _Nonnull pageView) {
        [weakSelf sliderViewWith:currentIndex];
    };
}


-(NSMutableArray *)vcs {
    if (_vcs==nil) {
        _vcs = [NSMutableArray array];
        SRXGoodsListTableVC *vc1 = [[SRXGoodsListTableVC alloc] init];
        vc1.goods_status = @"1";
        SRXGoodsListTableVC *vc2 = [[SRXGoodsListTableVC alloc] init];
        vc2.goods_status = @"2";
        SRXGoodsListTableVC *vc3 = [[SRXGoodsListTableVC alloc] init];
        vc3.goods_status = @"3";
        SRXGoodsListTableVC *vc4 = [[SRXGoodsListTableVC alloc] init];
        vc4.goods_status = @"4";
        self.currentVC = vc1;
        _vcs = @[vc1,vc2,vc3,vc4].modelCopy;
    }
    return _vcs;
}

- (SRXGoodsMoreFilterView *)moreFilter {
    if (!_moreFilter) {
        _moreFilter = [[NSBundle mainBundle] loadNibNamed:@"SRXGoodsMoreFilterView" owner:nil options:nil].firstObject;
        _moreFilter.frame = CGRectMake(0, StatusBarHeight+44, kScreenWidth, kScreenHeight - StatusBarHeight-44);
        MJWeakSelf;
        _moreFilter.closeBlock = ^(SRXGoodsListParameter * _Nullable parameters) {
            weakSelf.filterBtn.selected = NO;
            if(parameters){
                weakSelf.parameters = parameters;
                weakSelf.currentVC.parameters = parameters;
            }
        };
    }
    return _moreFilter;
}

- (SRXShopClassFilterView *)classFilter {
    if (!_classFilter) {
        _classFilter = [[NSBundle mainBundle] loadNibNamed:@"SRXShopClassFilterView" owner:nil options:nil].firstObject;
        _classFilter.frame = CGRectMake(0, StatusBarHeight+44, kScreenWidth, kScreenHeight - StatusBarHeight-44);
        MJWeakSelf;
        _classFilter.closeBlock = ^(SRXGoodsListParameter * _Nullable parameters) {
            weakSelf.shopClass.selected = NO;
            if(parameters){
                weakSelf.parameters = parameters;
                weakSelf.currentVC.parameters = parameters;
            }
        };
    }
    return _classFilter;
}

- (SRXCreateTimeFilterView *)timeFilter {
    if (!_timeFilter) {
        _timeFilter = [[NSBundle mainBundle] loadNibNamed:@"SRXCreateTimeFilterView" owner:nil options:nil].firstObject;
        _timeFilter.frame = CGRectMake(0, StatusBarHeight+44, kScreenWidth, kScreenHeight - StatusBarHeight-44);
        MJWeakSelf;
        _timeFilter.closeBlock = ^(SRXGoodsListParameter * _Nullable parameters) {
            weakSelf.createTime.selected = NO;
            if(parameters){
                weakSelf.parameters = parameters;
                weakSelf.currentVC.parameters = parameters;
            }
        };
    }
    return _timeFilter;
}


- (SRXGoodsListEditBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"SRXGoodsListEditBottomView" owner:nil options:nil].firstObject;
        _bottomView.frame = CGRectMake(0, kScreenHeight - TabbarHeight - 52, kScreenWidth, 52);
        MJWeakSelf;
        [_bottomView.allBtn addCallBackAction:^(UIButton *button) {
            button.selected = !button.isSelected;
            weakSelf.currentVC.isAllEdit = button.isSelected;
        }];
        [_bottomView.batchBtn addCallBackAction:^(UIButton *button) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否批量下架？" preferredStyle:UIAlertControllerStyleAlert];
            [alertC addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertC addAction: [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [NetworkManager batchGoodsTakeOffWithIDS:weakSelf.select_good_id success:^(NSString *message) {
                    [weakSelf.currentVC.tableView.mj_header beginRefreshing];
                } failure:^(NSString *message) {
                    
                }];
            }]];
            [self presentViewController:alertC animated:YES completion:nil];
        }];
    }
    return _bottomView;
}
@end
