//
//  PopProductParametersVC.m
//  ShiRongXinMarketMallProject
//
//  Created by 薛静鹏 on 2020/12/30.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "PopProductParametersVC.h"
#import "ProductParameterTableViewCell.h"

@interface PopProductParametersVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *parameterTableView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@end

@implementation PopProductParametersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView settingRadius:30 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    self.contentHeight.constant = self.basic_info.count*45+130>(kScreenHeight-kTopHeight-kViewBottomHeight)?(kScreenHeight-kTopHeight-kViewBottomHeight):self.basic_info.count*45+130;
    [self initWithTableView];
    self.bgColor = JKRGBColor(37, 37, 37, 0.5);
}
#pragma mark —————产品参数—————
- (void)initWithTableView{
    self.parameterTableView.delegate = self;
    self.parameterTableView.dataSource = self;
    self.parameterTableView.rowHeight = 45;
    self.parameterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.parameterTableView registerNib:[UINib nibWithNibName:@"ProductParameterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ProductParameterTableViewCell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.basic_info.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductParameterTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.basic_info[indexPath.row];
    cell.title.text = dic[@"title"];
    cell.name.text = dic[@"desc"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (IBAction)onclickSure:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
