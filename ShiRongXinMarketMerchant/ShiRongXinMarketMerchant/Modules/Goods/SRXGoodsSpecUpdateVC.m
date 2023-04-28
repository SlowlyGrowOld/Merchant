//
//  SRXGoodsSpecUpdateVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/28.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsSpecUpdateVC.h"
#import "SRXGoodsSpecUpdateTableCell.h"

@interface SRXGoodsSpecUpdateVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SRXGoodsSpecUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.tableView.backgroundColor = CViewBgColor;
    [self.bgView settingRadius:10 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    [self.tableView registerNib:[UINib nibWithNibName:@"SRXGoodsSpecUpdateTableCell" bundle:nil] forCellReuseIdentifier:@"SRXGoodsSpecUpdateTableCell"];
    self.datas = @[@"",@"",@""];
    
    CGFloat height = (self.isStore?self.datas.count*84:self.datas.count*128) + 5.01*(self.datas.count-1);
    if (height+100+BottomSafeHeight>kScreenHeight-100) {
        self.tableViewConsH.constant = kScreenHeight-200-BottomSafeHeight;
        self.tableView.scrollEnabled = YES;
    } else {
        self.tableViewConsH.constant = height;
        self.tableView.scrollEnabled = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    kAppDelegate.mainTabBar.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    kAppDelegate.mainTabBar.tabBar.hidden = NO;
}

- (IBAction)saveBtnClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.allObjects.lastObject;
    BOOL isResult = [touch.view isDescendantOfView:self.bgView];
    if (!isResult) {[self dismissViewControllerAnimated:NO completion:nil];}
}

#pragma mark - tableview data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXGoodsSpecUpdateTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGoodsSpecUpdateTableCell" forIndexPath:indexPath];
    cell.isStore = self.isStore;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.isStore?84:128;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
@end
