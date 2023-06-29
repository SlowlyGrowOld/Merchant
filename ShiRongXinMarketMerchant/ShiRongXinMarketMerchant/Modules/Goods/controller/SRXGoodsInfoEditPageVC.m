//
//  SRXGoodsInfoEditPageVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/29.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsInfoEditPageVC.h"
#import "QiPageContentView.h"
#import "QiPageMenuView.h"
#import "SRXGoodsInfoEditBaseVC.h"
#import "SRXGoodsInfoEditSaleVC.h"
#import "SRXGoodsInfoEditExpandVC.h"
#import "SRXGoodsInfoEditShowVC.h"
#import "SRXGoodsEditQuitAlertVC.h"
#import "NetworkManager+GoodUpdate.h"
#import "SRXGoodsEditInfoModel.h"
#import "SRXGoodsDetailsVC.h"

@interface SRXGoodsInfoEditPageVC ()
/** 标题数组 */
@property (nonatomic,strong) NSMutableArray *titles;
/** 分页视图 */
@property (nonatomic,strong) QiPageMenuView *menuView;
/** 控制器分组 */
@property (nonatomic,strong) NSMutableArray *vcs;
/** 内容视图 */
@property (nonatomic,strong) QiPageContentView *pageContentView;

@property (nonatomic, strong) SRXGoodsInfoEditBaseVC *baseVC;
@property (nonatomic, strong) SRXGoodsInfoEditSaleVC *saleVC;
@property (nonatomic, strong) SRXGoodsInfoEditExpandVC *expandVC;
@property (nonatomic, strong) SRXGoodsInfoEditShowVC *showVC;
@property (nonatomic, strong) SRXGoodsEditInfoModel *editInfo;
@end

@implementation SRXGoodsInfoEditPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑商品";
    [self initMenuView];
    if (self.goods_id) {
        [self requestEditInfo];
    }else {
        self.editInfo = [SRXGoodsEditInfoModel new];
        self.baseVC.editInfo = self.editInfo;
    }
    [self addNavigationItemWithImageNames:@[@"back_black"] isLeft:YES target:self action:@selector(back1BtnClicked) tags:nil];
}

- (void)back1BtnClicked {
    SRXGoodsEditQuitAlertVC *vc = [SRXGoodsEditQuitAlertVC new];
    MJWeakSelf;
    vc.quitBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
}

-(void)initMenuView {

    NSDictionary *dataSource = @{
        QiPageMenuViewNormalTitleColor:CFont66,
        QiPageMenuViewSelectedTitleColor:CFont3D,
        QiPageMenuViewTitleFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],
        QiPageMenuViewSelectedTitleFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],
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
        QiPageMenuViewLineWidth:@(30),
    };
    self.menuView = [[QiPageMenuView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44) titles:self.titles dataSource:dataSource];
    self.menuView.backgroundColor = [UIColor clearColor];
    self.menuView.userInteractionEnabled = NO;
    kWeakSelf;
    self.menuView.pageItemClicked = ^(NSInteger clickedIndex, NSInteger beforeIndex, QiPageMenuView *menu) {
        [weakSelf.pageContentView setPageContentShouldScrollToIndex:clickedIndex beforIndex:beforeIndex];
    };
    [self.view addSubview:self.menuView];
    
    self.pageContentView = [[QiPageContentView alloc]initWithFrame:CGRectMake(0, 44, KScreenWidth, kScreenHeight - TopHeight - 44) childViewController:self.vcs];
    self.pageContentView.canScroll = NO;
    self.pageContentView.canAnimated = NO;
    [self.view addSubview:self.pageContentView];
    self.menuView.pageScrolledIndex = 0;
    [self.pageContentView setPageContentShouldScrollToIndex:0 beforIndex:0];
    self.pageContentView.pageContentViewDidScroll = ^(NSInteger currentIndex, NSInteger beforeIndex, QiPageContentView * _Nonnull pageView) {
        weakSelf.menuView.pageScrolledIndex = currentIndex;
    };
}

#pragma mark - request
- (void)requestEditInfo {
    [NetworkManager getGoodsEditInfoWithGoods_id:self.goods_id success:^(SRXGoodsEditInfoModel * _Nonnull info) {
        self.editInfo = info;
        self.baseVC.editInfo = info;
    } failure:^(NSString *message) {
        
    }];
}

- (void)saveEditInfoWithIndex:(NSInteger)index {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"step_num"] = @(index).stringValue;
    if (index >= 1) {
        [dic addEntriesFromDictionary:self.baseVC.parameters];
    }
    if (index >= 2) {
        [dic addEntriesFromDictionary:self.saleVC.parameters];
    }
    if (index >= 3) {
        [dic addEntriesFromDictionary:self.expandVC.parameters];
    }
    if (index == 4) {
        [dic addEntriesFromDictionary:self.showVC.parameters];
    }
    if (self.goods_id) {
        [NetworkManager saveGoodsEditInfoWithGoods_id:self.goods_id parameters:dic.copy success:^(NSString *message) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        } failure:^(NSString *message) {
            
        }];
    } else {
        [NetworkManager addGoodsWithDic:dic.copy success:^(NSString *message) {
            self.goods_id = message;
            self.showVC.goods_id = message;
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        } failure:^(NSString *message) {
            
        }];
    }
}


-(NSMutableArray *)vcs {
    if (_vcs==nil) {
        _vcs = [NSMutableArray array];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
        self.baseVC = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsInfoEditBaseVC"];
        MJWeakSelf;
        self.baseVC.block = ^(NSInteger index) {
            if (index == 2) {//下一步
                weakSelf.menuView.pageScrolledIndex = 1;
                [weakSelf.pageContentView setPageContentShouldScrollToIndex:1 beforIndex:0];
                weakSelf.saleVC.editInfo = weakSelf.editInfo;
            } else {//保存
                [weakSelf saveEditInfoWithIndex:1];
            }
        };
        self.saleVC = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsInfoEditSaleVC"];
        self.saleVC.block = ^(NSInteger index) {
            if (index == 0) {//上一步
                weakSelf.menuView.pageScrolledIndex = 0;
                [weakSelf.pageContentView setPageContentShouldScrollToIndex:0 beforIndex:1];
            } else if (index == 2) {//下一步
                weakSelf.menuView.pageScrolledIndex = 2;
                [weakSelf.pageContentView setPageContentShouldScrollToIndex:2 beforIndex:1];
                weakSelf.expandVC.editInfo = weakSelf.editInfo;
            } else {//保存
                [weakSelf saveEditInfoWithIndex:2];
            }
        };
        self.expandVC = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsInfoEditExpandVC"];
        self.expandVC.block = ^(NSInteger index) {
            if (index == 0) {//上一步
                weakSelf.menuView.pageScrolledIndex = 1;
                [weakSelf.pageContentView setPageContentShouldScrollToIndex:1 beforIndex:2];
            } else if (index == 2) {//下一步
                [UIView animateWithDuration:0 animations:^{
                    weakSelf.menuView.pageScrolledIndex = 3;
                    [weakSelf.pageContentView setPageContentShouldScrollToIndex:3 beforIndex:2];
                } completion:^(BOOL finished) {
                    weakSelf.showVC.editInfo = weakSelf.editInfo;
                }];
            } else {//保存
                [weakSelf saveEditInfoWithIndex:3];
            }
        };
        self.showVC = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsInfoEditShowVC"];
        self.showVC.block = ^(NSInteger index) {
            if (index == 0) {//上一步
                weakSelf.menuView.pageScrolledIndex = 2;
                [weakSelf.pageContentView setPageContentShouldScrollToIndex:2 beforIndex:3];
            } else if (index == 2) {//浏览
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
                SRXGoodsDetailsVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsDetailsVC"];
                vc.goods_id = weakSelf.goods_id;
                [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
            } else {//保存
                [weakSelf saveEditInfoWithIndex:4];
            }
        };
        _vcs = @[self.baseVC,self.saleVC,self.expandVC,self.showVC].modelCopy;
    }
    return _vcs;
}

-(NSMutableArray *)titles {
    if (_titles==nil) {
        _titles = [NSMutableArray array];
        _titles = @[@"基本信息",@"销售信息",@"推广信息",@"展示信息"].modelCopy;
    }
    return _titles;
}

@end
