//
//  SRXGoodsInfoEditBaseVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/29.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsInfoEditBaseVC.h"
#import "SRXGoodsInfoEditBasicInfoTableCell.h"
#import "SRXArrayTitlesAlertVC.h"

@interface SRXGoodsInfoEditBaseVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *platView;
@property (weak, nonatomic) IBOutlet UITextField *plat_name;
@property (weak, nonatomic) IBOutlet UIView *shopView;
@property (weak, nonatomic) IBOutlet UITextField *shop_cat_name;
@property (weak, nonatomic) IBOutlet UITextField *shop_name;
@property (weak, nonatomic) IBOutlet UIView *storageView;
@property (weak, nonatomic) IBOutlet UITextField *storage_name;
@property (weak, nonatomic) IBOutlet UITextField *keywords;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UITextView *goods_info;
@property (weak, nonatomic) IBOutlet UITextField *goods_sn;

@property (nonatomic, copy) NSString *cat_id;//平台分类ID
@property (nonatomic, copy) NSString *extend_cat_id;//店铺分类ID
@property (nonatomic, copy) NSString *hupun_storage_id;//供应商id
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation SRXGoodsInfoEditBaseVC

- (NSMutableArray *)datas {
    if(!_datas){
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CViewBgColor;
    self.tableView.rowHeight = 88;
    self.goods_info.textContainer.lineFragmentPadding = 0;
    self.goods_info.textContainerInset = UIEdgeInsetsZero;
    MJWeakSelf;
    [self.platView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        SRXArrayTitlesAlertVC *vc = [[SRXArrayTitlesAlertVC alloc] init];
        vc.type = SRXArrayTitlesTypePlat;
        vc.selectBlock = ^(SRXArrayTitlesModel * _Nonnull model) {
            weakSelf.editInfo.cat_id = model._id;
            weakSelf.plat_name.text = model.name;
        };
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }];
    [self.shopView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        SRXArrayTitlesAlertVC *vc = [[SRXArrayTitlesAlertVC alloc] init];
        vc.type = SRXArrayTitlesTypeShop;
        vc.selectBlock = ^(SRXArrayTitlesModel * _Nonnull model) {
            weakSelf.editInfo.extend_cat_id = model._id;
            weakSelf.shop_cat_name.text = model.name;
        };
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }];
    [self.storageView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        SRXArrayTitlesAlertVC *vc = [[SRXArrayTitlesAlertVC alloc] init];
        vc.type = SRXArrayTitlesTypeSupplier;
        vc.selectBlock = ^(SRXArrayTitlesModel * _Nonnull model) {
            weakSelf.editInfo.hupun_storage_id = model._id;
            weakSelf.editInfo.hupun_storage_name = model.name;
            weakSelf.storage_name.text = model.name;
        };
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }];
}

- (void)setEditInfo:(SRXGoodsEditInfoModel *)editInfo {
    _editInfo = editInfo;
    _plat_name.text = editInfo.cat_name;
    _shop_cat_name.text = editInfo.extend_cat_name;
    _shop_name.text = editInfo.goods_name;
    _storage_name.text = editInfo.hupun_storage_name;
    _keywords.text = editInfo.keywords;
    _goods_info.text = editInfo.goods_info;
    _placeholder.hidden = editInfo.goods_info.length>0?YES:NO;
    _goods_sn.text = editInfo.goods_sn;
    [self.datas addObjectsFromArray:editInfo.basic_info];
    [self.tableView reloadData];
}

- (IBAction)addBasicInfoBtnClick:(id)sender {
    for (int i=0; i<self.datas.count; i++) {
        SRXGoodsInfoEditBasicInfoTableCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        SRXGoodsBasicInfoItem *item = self.datas[i];
        item.title = cell.titleLb.text;
        item.desc = cell.contentLb.text;
    }
    SRXGoodsBasicInfoItem *item = [SRXGoodsBasicInfoItem new];
    [self.datas addObject:item];
    [self.tableView reloadData];
}

- (IBAction)saveBtnClick:(id)sender {
    [self configParameters];
    if (self.block) {
        self.block(1);
    }
}

- (IBAction)nextStepBtnClick:(id)sender {
    [self configParameters];
    if (self.block) {
        self.block(2);
    }
}

- (void)configParameters {
    self.parameters = [NSMutableDictionary dictionary];
    self.parameters[@"cat_id"] = self.editInfo.cat_id;
    self.parameters[@"extend_cat_id"] = self.editInfo.extend_cat_id;
    self.parameters[@"goods_name"] = self.shop_name.text;
    self.parameters[@"goods_sn"] = self.goods_sn.text;
    self.parameters[@"goods_info"] = self.goods_info.text;
    self.parameters[@"keywords"] = self.keywords.text;
    self.parameters[@"hupun_storage_id"] = self.editInfo.hupun_storage_id;
    self.parameters[@"hupun_storage_name"] = self.editInfo.hupun_storage_name;
    
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *descs = [NSMutableArray array];
    for (int i=0; i<self.datas.count; i++) {
        SRXGoodsInfoEditBasicInfoTableCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.titleLb.text.stringByTrim.length!=0){
            [titles addObject:cell.titleLb.text];
            [descs addObject:cell.contentLb.text.length==0?@"":cell.contentLb.text];
        }
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"title"] = titles;
    dic[@"desc"] = descs;
    self.parameters[@"basic_info"] = dic.copy;
    DLog(@"基本信息：%@",self.parameters);
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.placeholder.hidden = YES;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length==0) {
        self.placeholder.hidden = NO;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXGoodsInfoEditBasicInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGoodsInfoEditBasicInfoTableCell" forIndexPath:indexPath];
    SRXGoodsBasicInfoItem *item = self.datas[indexPath.row];
    cell.titleLb.text = item.title;
    cell.contentLb.text = item.desc;
    return cell;
}
@end
