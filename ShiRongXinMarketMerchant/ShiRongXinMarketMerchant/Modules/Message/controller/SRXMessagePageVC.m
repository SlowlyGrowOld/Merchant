//
//  SRXMessagePageVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMessagePageVC.h"
#import "QiPageContentView.h"
#import "QiPageMenuView.h"
#import "SRXMessageListVC.h"
#import "SRXMessageSetTableVC.h"

@interface SRXMessagePageVC ()
@property (weak, nonatomic) IBOutlet UIView *menuBgView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
/** 标题数组 */
@property (nonatomic,strong) NSMutableArray *titles;
/** 分页视图 */
@property (nonatomic,strong) QiPageMenuView *menuView;
/** 控制器分组 */
@property (nonatomic,strong) NSMutableArray *vcs;
/** 内容视图 */
@property (nonatomic,strong) QiPageContentView *pageContentView;
@end

@implementation SRXMessagePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = YES;
    
    [self initMenuView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[JHWebSocketManager shareInstance] initWebSocket];
    DLog(@"-----%@",[UserManager sharedUserManager].curUserInfo._id);
}

#pragma mark - UIButton event
- (IBAction)setBtnClick:(id)sender {
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    SRXMessageListVC *vc = self.vcs[self.menuView.currentPage];
    vc.search_word = textField.text;
}

#pragma mark - init
-(void)initMenuView {

    NSDictionary *dataSource = @{
        QiPageMenuViewNormalTitleColor:UIColor.whiteColor,
        QiPageMenuViewSelectedTitleColor:UIColor.whiteColor,
        QiPageMenuViewTitleFont:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium],
        QiPageMenuViewSelectedTitleFont:[UIFont systemFontOfSize:18 weight:UIFontWeightBold],
        QiPageMenuViewHasUnderLine:@(YES),
        QiPageMenuViewItemTopPadding:@(0),
//        QiPageMenuViewItemWidth:@(174/self.vcs.count),
//        QiPageMenuViewItemsAutoResizing:@(NO),
        QiPageMenuViewItemIsVerticalCentred:@(NO),
        QiPageMenuViewItemHeight:@(44),
        QiPageMenuViewItemPadding:@(0),
        QiPageMenuViewLineTopPadding:(@-8),
        QiPageMenuViewHasUnderLine:@(NO),
        QiPageMenuViewLeftMargin:@(5),
        QiPageMenuViewRightMargin:@(5),
        QiPageMenuViewLineColor:UIColor.whiteColor,
        QiPageMenuViewLineHeight:@(2),
        QiPageMenuViewLineWidth:@(14),
    };
    self.menuView = [[QiPageMenuView alloc]initWithFrame:CGRectMake(0, 0, 174, 44) titles:self.titles dataSource:dataSource];
    self.menuView.backgroundColor = [UIColor clearColor];
    kWeakSelf;
    self.menuView.pageItemClicked = ^(NSInteger clickedIndex, NSInteger beforeIndex, QiPageMenuView *menu) {
        [weakSelf.pageContentView setPageContentShouldScrollToIndex:clickedIndex beforIndex:beforeIndex];
    };
    [self.menuBgView addSubview:self.menuView];
    
    self.pageContentView = [[QiPageContentView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight - TopHeight - 20) childViewController:self.vcs];
    self.pageContentView.canScroll = NO;
    self.pageContentView.canAnimated = NO;
    [self.contentView addSubview:self.pageContentView];
    self.pageContentView.pageContentViewDidScroll = ^(NSInteger currentIndex, NSInteger beforeIndex, QiPageContentView * _Nonnull pageView) {
        weakSelf.menuView.pageScrolledIndex = currentIndex;
    };
}

-(NSMutableArray *)vcs {
    if (_vcs==nil) {
        _vcs = [NSMutableArray array];
        SRXMessageListVC *vc1 = [[SRXMessageListVC alloc] init];
        vc1.chat_type = @"1";
        SRXMessageListVC *vc2 = [[SRXMessageListVC alloc] init];
        vc2.chat_type = @"2";
        SRXMessageListVC *vc3 = [[SRXMessageListVC alloc] init];
        _vcs = @[vc1,vc2,vc3].modelCopy;
    }
    return _vcs;
}

-(NSMutableArray *)titles {
    if (_titles==nil) {
        _titles = [NSMutableArray array];
        _titles = @[@"接待",@"标记"].modelCopy;//,@"系统"
    }
    return _titles;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    SRXMessageListVC *vc = self.vcs[self.menuView.currentPage];
    if ([segue.identifier isEqualToString:@"chatSet"]) {
        SRXMessageSetTableVC * set = [segue destinationViewController];
        set.shop_id = vc.shop.shop_id;
    }
}

@end
