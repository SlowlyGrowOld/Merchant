//
//  SRXGoodsDetailsVC.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/12/21.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXGoodsDetailsVC.h"
#import "SRXGoodsImageDetailView.h"
#import "SRXGDTagsCollectionView.h"
#import "SRXGDEvaluationTableView.h"
#import "SRXGDPicsCollectionView.h"
#import "SRXGDShopGoodsCollectionView.h"
#import "SRXGoodsDetailsHeadView.h"

#import "YBIBVideoData.h"
#import "JPVideoPlayerManager.h"
#import "YBImageBrowser.h"
#import "SRXAllTheGoodsModel.h"
#import "SRXGoodsEvaluateListModel.h"

#import "PopProductParametersVC.h"
#import "SRXPopFeatureSelectionVC.h"

@interface SRXGoodsDetailsVC ()<UITextViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bannerHeadView;
@property (strong, nonatomic) SRXGoodsImageDetailView *pictureScrollView;//图片视频滚动
@property (weak, nonatomic) IBOutlet UILabel *goods_name;//商品名称
@property (weak, nonatomic) IBOutlet UILabel *price;//本店价
@property (weak, nonatomic) IBOutlet UILabel *market_price;
@property (weak, nonatomic) IBOutlet UILabel *discount_price;//卷后价
@property (weak, nonatomic) IBOutlet UILabel *sales_sum;//商品销量
@property (weak, nonatomic) IBOutlet UILabel *goods_info;//商品简介
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;//收藏
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;//分享
@property (weak, nonatomic) IBOutlet SRXGDTagsCollectionView *discountCollectionView;
@property (weak, nonatomic) IBOutlet UIView *openVipView;
@property (weak, nonatomic) IBOutlet UILabel *return_money;
@property (weak, nonatomic) IBOutlet UIView *receive_coupon;

@property (weak, nonatomic) IBOutlet UIView *specView;
@property (weak, nonatomic) IBOutlet UILabel *selectSpec;
@property (weak, nonatomic) IBOutlet UILabel *basic_info;
@property (weak, nonatomic) IBOutlet UIView *basicView;

@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *commentNum;//评价数量
@property (weak, nonatomic) IBOutlet UILabel *commentRank;//好评率
@property (weak, nonatomic) IBOutlet SRXGDTagsCollectionView *tagCollectionView;
@property (weak, nonatomic) IBOutlet SRXGDEvaluationTableView *commentTableView;
@property (weak, nonatomic) IBOutlet UIView *picBgView;
@property (weak, nonatomic) IBOutlet SRXGDPicsCollectionView *picCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *moreCommentBtn;
@property (weak, nonatomic) IBOutlet UIButton *morePicBtn;
@property (weak, nonatomic) IBOutlet UIView *nodataEvaView;
@property (nonatomic, assign) CGFloat commentTableViewHeight;
@property (nonatomic, assign) CGFloat commentHeight;

@property (weak, nonatomic) IBOutlet UIImageView *shop_bg_image;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet UIImageView *shop_image;
@property (weak, nonatomic) IBOutlet UIButton *all_classBtn;
@property (weak, nonatomic) IBOutlet UIButton *go_shopBtn;
@property (weak, nonatomic) IBOutlet UILabel *is_self;
@property (weak, nonatomic) IBOutlet SRXGDShopGoodsCollectionView *shopGoodsCollectionView;

@property (weak, nonatomic) IBOutlet UITextView *goods_content;//详情

@property (strong, nonatomic) IBOutlet UIView *bottomView;//底部视图
@property (weak, nonatomic) IBOutlet UIButton *b_shopBtn;
@property (weak, nonatomic) IBOutlet UIButton *b_serviceBtn;
@property (weak, nonatomic) IBOutlet UIButton *b_collectionBtn;
@property (weak, nonatomic) IBOutlet UIButton *addCartBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *buyLb;
@property (weak, nonatomic) IBOutlet UILabel *buy_discount;

@property (nonatomic,strong) SRXGoodsDetailsHeadView  *topView;
@property (nonatomic,strong) UIButton  *backBtn;
@property (nonatomic,strong) UIButton  *topCartBtn;
/** 滚动到的位置 */
@property(nonatomic, assign) CGFloat offset;

@property (strong, nonatomic) SRXAllTheGoodsModel *allTheGoodsModel;
@property (nonatomic, strong) SRXGoodsEvaluateListModel *evaluateModel;

@property (nonatomic, strong) YBImageBrowser *browser;
@property (nonatomic, strong) NSMutableArray* contentImagesArr;
@property (nonatomic, strong) NSMutableArray* rangeArr;
@property (nonatomic, assign) BOOL  isTableScroll;
@end

@implementation SRXGoodsDetailsVC

- (SRXGoodsImageDetailView *)pictureScrollView {
    if (!_pictureScrollView) {
        _pictureScrollView = [[SRXGoodsImageDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    }
    return _pictureScrollView;
}

- (SRXGoodsDetailsHeadView *)topView {
    if (!_topView) {
        _topView = [[NSBundle mainBundle] loadNibNamed:@"SRXGoodsDetailsHeadView" owner:self options:nil].firstObject;
        _topView.frame = CGRectMake(0, 0, kScreenWidth, TopHeight);
    }
    return _topView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.bottomView.frame = CGRectMake(0, kScreenHeight - 52-BottomSafeHeight, kScreenWidth, 52+BottomSafeHeight);
    [self.navigationController.view addSubview:self.bottomView];
    [self.navigationController.view addSubview:self.topView];
    [self.navigationController.view addSubview:self.backBtn];
    [self.navigationController.view addSubview:self.topCartBtn];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isTableScroll = YES;
    [self.bottomView removeFromSuperview];
    [self.topView removeFromSuperview];
    [self.topCartBtn removeFromSuperview];
    [self.backBtn removeFromSuperview];
    if ([JPVideoPlayerManager sharedManager].videoPlayer.playerStatus==JPVideoPlayerStatusPlaying) {
        [[JPVideoPlayerManager sharedManager] pause];
    }
}

-(void)dealloc {
    [self.pictureScrollView.video clearCache];
    [[JPVideoPlayerManager sharedManager] stopPlay];
    [kNotificationCenter removeObserver:self name:KNotificationLoginStateChange object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenNaviBar = YES;
    self.view.backgroundColor = CViewBgColor;
    self.goods_content.delegate = self;
    [self.morePicBtn setImagePosition:LXMImagePositionRight spacing:3];
    [self.moreCommentBtn setImagePosition:LXMImagePositionRight spacing:3];
    [self.collectionBtn setImagePosition:LXMImagePositionLeft spacing:3];
    [self.shareBtn setImagePosition:LXMImagePositionLeft spacing:3];
    [self.b_shopBtn setImagePosition:LXMImagePositionTop spacing:3];
    [self.b_serviceBtn setImagePosition:LXMImagePositionTop spacing:3];
    [self.b_collectionBtn setImagePosition:LXMImagePositionTop spacing:3];
    [self.addCartBtn settingRadius:10 corner:UIRectCornerTopLeft|UIRectCornerBottomLeft];
    self.buy_discount.adjustsFontSizeToFitWidth = YES;
    self.goods_content.textContainerInset = UIEdgeInsetsZero;
    self.goods_content.textContainer.lineFragmentPadding = 0;
    [self.bannerHeadView addSubview:self.pictureScrollView];
    
    self.tagCollectionView.type = SRXGDTagsTypeEvaluate;
    self.discountCollectionView.type = SRXGDTagsTypeNomal;
    self.discountCollectionView.tagFont = 10;

    self.goods_name.text = self.goodsListModel.goods_name;
    self.price.text = [NSString stringWithFormat:@"%@",self.goodsListModel.price?:@"0"];
    self.goods_info.text = @"";
    
    self.tableView.estimatedSectionHeaderHeight = 0;
    if (@available (iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
     }
    if (@available(iOS 15.0, *)) {
        self.tableView.sectionHeaderTopPadding = 0;
    }
    self.commentHeight = 74;
    [self addClickAction];
    [self getGoodDetail];
    [self requestGoodsComment];
        
    [kNotificationCenter addObserver:self selector:@selector(loginTypeChangeAction) name:KNotificationLoginStateChange object:nil];
}

- (void)addClickAction {
    MJWeakSelf;
    self.commentTableView.heightBlock = ^(CGFloat height) {
        weakSelf.commentTableViewHeight = height;
        [weakSelf calculateCommentHeight];
    };
    
    [self.specView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {//选择规格
        SRXPopFeatureSelectionVC *vc = [[SRXPopFeatureSelectionVC alloc]initWithNibName:@"SRXPopFeatureSelectionVC" bundle:nil];
        vc.isBgClose = YES;
        vc.goodsModel = self.allTheGoodsModel;
        vc.type = SRXPopFeatureSelectionTypeSelectFeature;
        vc.changeBlock = ^(SRXAllTheGoodsModel * _Nonnull model) {
            weakSelf.allTheGoodsModel = model;
            weakSelf.selectSpec.text = model.selectSpec.key_name==nil?@"默认规格":model.selectSpec.key_name;
            if (model.selectSpec) {
                [self changeSelectSpecPrice];
            }
        };
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }];
    
    [self.basicView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        PopProductParametersVC *vc = [[PopProductParametersVC alloc]initWithNibName:@"PopProductParametersVC" bundle:nil];
        vc.basic_info = weakSelf.allTheGoodsModel.basic_info;
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }];
    
    [self.receive_coupon jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        
    }];


    [self.backBtn addCallBackAction:^(UIButton *button) {
        [[UIViewController jk_currentNavigatonController] popViewControllerAnimated:YES];
    }];
    
    [self.topView.goodBtn addCallBackAction:^(UIButton *button) {
        [weakSelf.tableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];
    [self.topView.evaluateBtn addCallBackAction:^(UIButton *button) {
        CGRect rect = [weakSelf.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        [weakSelf.tableView setContentOffset:CGPointMake(0, rect.origin.y-TopHeight) animated:YES];
    }];
    [self.topView.detailsBtn addCallBackAction:^(UIButton *button) {
        CGRect rect = [weakSelf.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
        [weakSelf.tableView setContentOffset:CGPointMake(0, rect.origin.y-TopHeight) animated:YES];
    }];
    [self.addCartBtn addCallBackAction:^(UIButton *button) {//添加购物车
        SRXPopFeatureSelectionVC *vc = [[SRXPopFeatureSelectionVC alloc]initWithNibName:@"SRXPopFeatureSelectionVC" bundle:nil];
        vc.isBgClose = YES;
        vc.goodsModel = self.allTheGoodsModel;
        vc.type = SRXPopFeatureSelectionTypeShoppingCar;
        vc.changeBlock = ^(SRXAllTheGoodsModel * _Nonnull model) {
            weakSelf.allTheGoodsModel = model;
            weakSelf.selectSpec.text = model.selectSpec.key_name==nil?@"默认规格":model.selectSpec.key_name;
            if (model.selectSpec) {
                [self changeSelectSpecPrice];
            }
        };
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }];
    [self.buyBtn addCallBackAction:^(UIButton *button) {//立即购买
        SRXPopFeatureSelectionVC *vc = [[SRXPopFeatureSelectionVC alloc]initWithNibName:@"SRXPopFeatureSelectionVC" bundle:nil];
        vc.isBgClose = YES;
        vc.goodsModel = self.allTheGoodsModel;
        vc.type = SRXPopFeatureSelectionTypeBuy;
        vc.changeBlock = ^(SRXAllTheGoodsModel * _Nonnull model) {
            weakSelf.allTheGoodsModel = model;
            weakSelf.selectSpec.text = model.selectSpec.key_name==nil?@"默认规格":model.selectSpec.key_name;
            if (model.selectSpec) {
                [self changeSelectSpecPrice];
            }
        };
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }];
}

//登录状态修改
- (void)loginTypeChangeAction {
    [self getGoodDetail];
}

- (void)changeSelectSpecPrice {
//    NSString *priceStr = [NSString stringWithNumber:@(self.allTheGoodsModel.selectSpec.price.floatValue) formatter:@"##.##"];
//    self.price.attributedText = [NSMutableAttributedString setPriceText:priceStr frontFont:26 behindFont:22 textColor:UIColor.redColor];
//    self.market_price.hidden = YES;
//    if (self.allTheGoodsModel.selectSpec.after_coupon_price > 0) {
//        self.discount_price.superview.hidden = NO;
//        self.discount_price.text = [NSString stringWithFormat:@"券后价¥%@", @(self.allTheGoodsModel.selectSpec.after_coupon_price).stringValue];
//        self.buyLb.text = @"领劵购买";
//        self.buy_discount.text = [NSString stringWithFormat:@"券后¥%@", @(self.allTheGoodsModel.selectSpec.after_coupon_price).stringValue];
//    }else if (self.allTheGoodsModel.selectSpec.member_price > 0 && self.allTheGoodsModel.is_member) {
//        self.discount_price.superview.hidden = NO;
//        self.discount_price.text = [NSString stringWithFormat:@"会员价¥%.2lf",self.allTheGoodsModel.selectSpec.member_price];
//        self.buyLb.text = @"立即购买";
//        self.buy_discount.text = @"";
//    }else {
//        self.market_price.hidden = NO;
//        if (self.allTheGoodsModel.selectSpec.market_price.floatValue > 0) {
//            self.market_price.text = self.allTheGoodsModel.selectSpec.market_price;
//            NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.market_price.text]];
//            [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
//            self.market_price.attributedText = newPrice;
//        }else {
//            self.market_price.text = @"";
//        }
//        self.discount_price.superview.hidden = YES;
//        self.buyLb.text = @"立即购买";
//        self.buy_discount.text = @"";
//    }
}

#pragma mark - request
- (void)getGoodDetail {
    MJWeakSelf;
    [[NetworkManager sharedClient] getWithURLString:[NSString stringWithFormat:@"http://api.go-easy.cn/goods/%@",self.goods_id] parameters:@{@"is_owner":@"1"} isNeedSVP:YES success:^(NSDictionary *messageDic) {
        NSDictionary *tempdic = messageDic[@"data"];
        SRXAllTheGoodsModel *model = [[SRXAllTheGoodsModel alloc]initWithDic:tempdic];
        weakSelf.allTheGoodsModel = model;
        weakSelf.allTheGoodsModel.is_package_edit_num = YES;
        NSMutableArray *basic_infoArray = [NSMutableArray array];
        for (NSDictionary *dic in weakSelf.allTheGoodsModel.basic_info) {
            [basic_infoArray addObject:dic[@"title"]];
        }
        weakSelf.basic_info.text = basic_infoArray.count>0?[basic_infoArray componentsJoinedByString:@" "]:@"无";
        [weakSelf.pictureScrollView.shufflingArray removeAllObjects];
        NSString *video = weakSelf.allTheGoodsModel.video;
        if ([video isEqualToString:@""]||video==nil) {
            weakSelf.pictureScrollView.isVideo = NO;
        }
        else {
            weakSelf.pictureScrollView.isVideo = YES;
            [weakSelf.pictureScrollView.shufflingArray addObject:video];
        }
        [weakSelf.pictureScrollView.shufflingArray addObjectsFromArray:weakSelf.allTheGoodsModel.images];
        [weakSelf.pictureScrollView updateView];
        
        weakSelf.goods_name.text = weakSelf.allTheGoodsModel.goods_name;
        NSString *priceStr = [NSString stringWithNumber:@(weakSelf.allTheGoodsModel.price.floatValue) formatter:@"##.##"];
        weakSelf.price.attributedText = [NSMutableAttributedString setPriceText:priceStr frontFont:26 behindFont:22 textColor:UIColor.redColor];
        weakSelf.market_price.hidden = YES;
        if (weakSelf.allTheGoodsModel.after_coupon_price > 0) {
            weakSelf.discount_price.superview.hidden = NO;
            weakSelf.discount_price.text = [NSString stringWithFormat:@"券后价¥%@", @(weakSelf.allTheGoodsModel.after_coupon_price).stringValue];
            weakSelf.buyLb.text = @"领劵购买";
            weakSelf.buy_discount.text = [NSString stringWithFormat:@"券后¥%@", @(weakSelf.allTheGoodsModel.after_coupon_price).stringValue];
        }else if (weakSelf.allTheGoodsModel.member_price.floatValue > 0 && weakSelf.allTheGoodsModel.is_member) {
            weakSelf.discount_price.superview.hidden = NO;
            weakSelf.discount_price.text = [NSString stringWithFormat:@"会员价¥%@", weakSelf.allTheGoodsModel.member_price];
            weakSelf.buyLb.text = @"立即购买";
            weakSelf.buy_discount.text = @"";
        }else {
            weakSelf.market_price.hidden = NO;
            if (weakSelf.allTheGoodsModel.market_price.floatValue > 0) {
                weakSelf.market_price.text = weakSelf.allTheGoodsModel.market_price;
                NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",weakSelf.market_price.text]];
                [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
                weakSelf.market_price.attributedText = newPrice;
            }else {
                weakSelf.market_price.text = @"";
            }
            weakSelf.discount_price.superview.hidden = YES;
            weakSelf.buyLb.text = @"立即购买";
            weakSelf.buy_discount.text = @"";
        }
        
        weakSelf.sales_sum.text = [NSString stringWithFormat:@"%ld人已付款",[weakSelf.allTheGoodsModel.sales_sum integerValue]];
        
        weakSelf.goods_info.text = weakSelf.allTheGoodsModel.goods_info;
        if (weakSelf.allTheGoodsModel.is_member) {
            weakSelf.return_money.text = @"分享好友，可得返佣";
        } else {
            weakSelf.return_money.text = [NSString stringWithFormat:@"成为365会员此商品最高返现￥%@",[NSString stringWithNumber:@(weakSelf.allTheGoodsModel.cash_back_money) formatter:@"#.##"]];
        }
        [weakSelf.shop_image sd_setImageWithURL:[NSURL URLWithString:weakSelf.allTheGoodsModel.shop.shop_img]];
        [weakSelf.shop_bg_image sd_setImageWithURL:[NSURL URLWithString:weakSelf.allTheGoodsModel.shop.bg_img]];
        weakSelf.shop_name.text = weakSelf.allTheGoodsModel.shop.shop_name;
        weakSelf.is_self.hidden = !weakSelf.allTheGoodsModel.shop.is_self;
        weakSelf.shopGoodsCollectionView.isMember = weakSelf.allTheGoodsModel.is_member;
        [weakSelf.shopGoodsCollectionView.datas removeAllObjects];
        [weakSelf.shopGoodsCollectionView.datas addObjectsFromArray:weakSelf.allTheGoodsModel.shop.shop_goods];
        [weakSelf.shopGoodsCollectionView reloadData];
        
        weakSelf.discountCollectionView.datas = weakSelf.allTheGoodsModel.label;
        
        if (weakSelf.allTheGoodsModel.is_collect) {
            weakSelf.collectionBtn.selected = YES;
        }else {
            weakSelf.collectionBtn.selected = NO;
        }
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView endUpdates];
        weakSelf.goods_content.scrollEnabled = NO;
        weakSelf.goods_content.editable = NO;
        [weakSelf getHTMLHeightByStr:weakSelf.allTheGoodsModel.goods_content font:[UIFont systemFontOfSize:14] lineSpacing:5.0 width:KScreenWidth];
    } failure:^(NSString *error) {
        
    }];
}
//如果需要真是数据可以套入
- (void)requestGoodsComment {
//    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
//    dicM[@"goods_id"] = self.allTheGoodsModel._id;
//    dicM[@"page"] = @(1);
//    dicM[@"page_size"] = @(2);
//    [[NetworkManager sharedClient]postWithURLString:@"http://api.go-easy.cn/goods/v2/goods_evaluate" parameters:dicM isNeedSVP:NO success:^(NSDictionary *messageDic) {
//        self.evaluateModel = [SRXGoodsEvaluateListModel mj_objectWithKeyValues:messageDic[@"data"]];
//        if (self.evaluateModel) {
//            self.commentNum.text = [NSString stringWithFormat:@"(%@)",@(self.evaluateModel.evaluate_count_arr.evaluate_count).stringValue];
//            self.commentRank.text = [NSString stringWithFormat:@"好评率%@%%",@(self.evaluateModel.evaluate_count_arr.good_rate_count).stringValue];
//            self.tagCollectionView.datas = self.evaluateModel.evaluate_default;
//            self.commentTableView.datas = self.evaluateModel.data;
//            self.picCollectionView.images = self.evaluateModel.show_images;
//            [self.tableView reloadRow:6 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
//            self.commentNum.hidden = NO;
//            self.commentRank.hidden = self.evaluateModel.evaluate_count_arr.good_rate_count==0?YES:NO;
//        }else {
//            self.commentNum.hidden = YES;
//            self.commentRank.hidden = YES;
//        }
//        self.commentTableView.hidden = self.evaluateModel.data.count==0?YES:NO;
//        self.tagCollectionView.hidden = self.evaluateModel.evaluate_default.count == 0?YES:NO;
//        self.picBgView.hidden = self.evaluateModel.show_images.count == 0?YES:NO;
//        [self calculateCommentHeight];
//    } failure:^(NSString * _Nonnull error) {
//        self.commentTableView.hidden = YES;
//        self.tagCollectionView.hidden = YES;
//        self.picBgView.hidden = YES;
//        self.commentNum.hidden = YES;
//        self.commentRank.hidden = YES;
//    }];
    self.commentTableView.hidden = YES;
    self.tagCollectionView.hidden = YES;
    self.picBgView.hidden = YES;
    self.commentNum.hidden = YES;
    self.commentRank.hidden = YES;
    self.commentHeight = 120;
}
///计算评价模块高度
- (void)calculateCommentHeight{
//    if (self.evaluateModel) {
//        self.nodataEvaView.hidden = YES;
//        CGFloat height = self.commentTableViewHeight + 20 + 150 + 74;
//        if (self.evaluateModel.data.count==0) {
//            height = height - self.commentTableViewHeight + 50;
//            self.nodataEvaView.hidden = NO;
//        }
//        if (self.evaluateModel.evaluate_default.count == 0) {
//            height = height - 20;
//        }
//        if (self.evaluateModel.show_images.count == 0) {
//            height = height - 150;
//        }
//        self.commentHeight = height;
//    }
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return kScreenWidth;
    }else if (indexPath.row==2) {
        if (self.allTheGoodsModel.is_member) {
            return 40;
        } else {
            return self.allTheGoodsModel.cash_back_money>0?40:0;
        }
    }else if (indexPath.row==3) {
        return 106;
    }else if (indexPath.row==4) {
        return self.commentHeight;
    }else if (indexPath.row == 5) {
        return 100 + (kScreenWidth-70)/3 + 62;
    }else if (indexPath.row==6) {
        return self.allTheGoodsModel.detailHeight==0?500:self.allTheGoodsModel.detailHeight;
    }
    return UITableViewAutomaticDimension;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.offset = scrollView.contentOffset.y;
    self.isTableScroll = YES;
    
    self.topView.alpha = self.offset*2.0/kScreenWidth>1?1:self.offset*2.0/kScreenWidth;
    
    if (self.offset > kScreenWidth/4.0) {
        self.backBtn.alpha = self.offset*4.0/kScreenWidth>2?1:(self.offset*4.0 - kScreenWidth)/kScreenWidth;
        self.topCartBtn.alpha = self.offset*4.0/kScreenWidth>2?1:(self.offset*4.0 - kScreenWidth)/kScreenWidth;
        _backBtn.backgroundColor = UIColor.clearColor;
        _topCartBtn.backgroundColor = UIColor.clearColor;
    }else {
        _backBtn.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.4];
        _topCartBtn.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.4];
        self.backBtn.alpha = self.offset*4.0/kScreenWidth>1?0:(kScreenWidth-self.offset*4.0)/kScreenWidth;
        self.topCartBtn.alpha = self.offset*4.0/kScreenWidth>1?0:(kScreenWidth-self.offset*4.0)/kScreenWidth;
    }
    
    CGFloat evaluateY = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]].origin.y-TopHeight-1;
    CGFloat detailsY = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]].origin.y-TopHeight-1;
    if (self.offset>=detailsY) {
        if (self.topView.currentIndex!=3) {
            self.topView.currentIndex = 3;
        }
    }else if (self.offset>=evaluateY) {
        if (self.topView.currentIndex!=2) {
            self.topView.currentIndex = 2;
        }
    }else {
        if (self.topView.currentIndex!=1){
            self.topView.currentIndex = 1;
        }
    }
}

/**
 计算html字符串高度

 @param str html 未处理的字符串
 @param font 字体设置
 @param lineSpacing 行高设置
 @param width 容器宽度设置
 */
-(void)getHTMLHeightByStr:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width
{
    str = [NSString stringWithFormat:@"<head><style> img{width:%f !important;height:auto;display:block;font-size:1px;} </style></head><body>%@</body>",KScreenWidth-20,str];
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //    self.goodsModel.goodsDetailStr =[[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    //    self.goods_content.attributedText = self.goodsModel.goodsDetailStr;
    kWeakSelf;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        weakSelf.allTheGoodsModel.goodsDetailStr =[[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
        CGSize contextSize = [weakSelf.allTheGoodsModel.goodsDetailStr boundingRectWithSize:(CGSize){KScreenWidth-20, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.goods_content.attributedText = weakSelf.allTheGoodsModel.goodsDetailStr;
            weakSelf.allTheGoodsModel.detailHeight = contextSize.height;
            [weakSelf.tableView beginUpdates];
            [weakSelf.tableView endUpdates];
            [self getGoods_contentImages];
        });
    });
}

/// 获取详情里图片集
- (void)getGoods_contentImages {
    
    self.rangeArr = [NSMutableArray array];
    self.contentImagesArr = [NSMutableArray array];
    NSArray *array = [self.allTheGoodsModel.goods_content componentsSeparatedByString:@"\""];
    for (NSString *string in array) {
        if ([string containsString:@"http"]) {
            [self.contentImagesArr addObject:string];
        }
    }
    MJWeakSelf;
    [self.goods_content.attributedText enumerateAttributesInRange:NSMakeRange(0, self.goods_content.attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        if (attrs[@"NSAttachment"]) {
            NSTextAttachment *attachment = attrs[@"NSAttachment"];
            if ([attachment.fileType containsString:@"png"] ||
                [attachment.fileType containsString:@"jpg"] ||
                [attachment.fileType containsString:@"jpeg"]||
                [attachment.fileType containsString:@"bmp"]||
                [attachment.fileType containsString:@"gif"]) {
                NSString* str = [NSString stringWithFormat:@"%ld",(unsigned long)range.location];
                [weakSelf.rangeArr insertObject:str atIndex:0];
            };
        }
    }];
}
 
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    
    if (interaction == UITextItemInteractionInvokeDefaultAction) {
        self.isTableScroll = NO;
        NSString*location = [NSString stringWithFormat:@"%ld",(unsigned long)characterRange.location];
        
        /** 适配：延迟弹出浏览器，是因为tableView滑动也会导致textView响应此代理方法（iOS15.4试过不会，iOS 13会） */
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            DLog(@"是否滑动:%ld",(long)self.isTableScroll);
            if (!self.isTableScroll) {
                for (int i=0; i<self.rangeArr.count; i++) {
                    if ([location isEqualToString:self.rangeArr[i]] && self.contentImagesArr.count>i) {
                        [self showImageVideoBrowserArray:self.contentImagesArr selectedIndex:i];
                        break;
                    }
                }
            }
        });
    }
    [self.goods_content jk_setSelectedRange:NSRangeFromString(@"去除选中效果")];
    return NO;
}

#pragma mark - 点击查看详情图片浏览器
- (void)showImageVideoBrowserArray:(NSArray *)dataArray selectedIndex:(NSInteger)index {
    
    //防止多重点击
    if (self.browser.superview) {
        return;
    }
    
    NSMutableArray *datas = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasSuffix:@".mp4"] && [obj hasPrefix:@"http"]) {
            
            // 网络视频
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL URLWithString:obj];
            data.projectiveView = nil;
            [datas addObject:data];
         
        } else if ([obj hasSuffix:@".mp4"]) {
            
            // 本地视频
            NSString *path = [[NSBundle mainBundle] pathForResource:obj.stringByDeletingPathExtension ofType:obj.pathExtension];
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL fileURLWithPath:path];
            data.projectiveView = nil;
            [datas addObject:data];
            
        } else if ([obj hasPrefix:@"http"]) {
            
            // 网络图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageURL = [NSURL URLWithString:obj];
            data.projectiveView = nil;
            [datas addObject:data];
            
        } else {
            
            // 本地图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageName = obj;
            data.projectiveView = nil;
            [datas addObject:data];
            
        }
    }];
    self.browser = [YBImageBrowser new];
    _browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    _browser.dataSourceArray = datas;
    _browser.currentPage = index;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
    [_browser show];
}

- (UIButton *)topCartBtn {
    if (!_topCartBtn) {
        _topCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topCartBtn.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.4];
        _topCartBtn.layer.cornerRadius = 15;
        _topCartBtn.layer.masksToBounds = YES;
        [_topCartBtn setImage:[UIImage imageNamed:@"goods_d_menu"] forState:UIControlStateNormal];
        _topCartBtn.frame = CGRectMake(kScreenWidth - 42.5, StatusBarHeight + 7, 30, 30);
    }
    return _topCartBtn;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.4];
        _backBtn.layer.cornerRadius = 15;
        _backBtn.layer.masksToBounds = YES;
        [_backBtn setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
        _backBtn.frame = CGRectMake(10, StatusBarHeight + 7, 30, 30);
    }
    return _backBtn;
}
@end
