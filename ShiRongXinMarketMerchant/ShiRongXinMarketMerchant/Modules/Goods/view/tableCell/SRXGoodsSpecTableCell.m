//
//  SRXGoodsSpecTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/26.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsSpecTableCell.h"
#import "SRXSpecValueCollectionCell.h"
#import "SRXSpecValueAddCollectionCell.h"

#import "SRXTextFieldAlertVC.h"
#import "NetworkManager+GoodUpdate.h"

@interface SRXGoodsSpecTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *spec_name;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConsH;
@property (nonatomic, assign) CGFloat contentSizeHeight;
@end

@implementation SRXGoodsSpecTableCell

- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SRXSpecValueCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXSpecValueCollectionCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SRXSpecValueAddCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXSpecValueAddCollectionCell"];
    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)contex {
    if ([keyPath isEqualToString:@"contentSize"]) {
        if (self.contentSizeHeight != self.collectionView.contentSize.height) {
            NSLog(@"%f",self.collectionView.contentSize.height);
            self.contentSizeHeight = self.collectionView.contentSize.height;
            self.collectionViewConsH.constant = self.contentSizeHeight;
            self.item.contentSizeHeight = self.contentSizeHeight;
            if(self.refreshBlock){self.refreshBlock();}
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteSpecBtnClick:(id)sender {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"确定要删除所选规格吗？" message:@"删除后相关编辑内容将无法恢复，请谨慎操作！" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertC addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(self.deleteBlock){self.deleteBlock();}
    }]];
    [[UIViewController jk_currentNavigatonController] presentViewController:alertC animated:YES completion:nil];
}

- (void)addSpecValueWithValue:(NSString *)value {
    [NetworkManager addGoodsSpecValueWithSpec_id:self.item.group_id spec_value_name:value success:^(NSString *message) {
        NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.item.spec_items];
        SRXGoodsSpecItemsItem *item = [SRXGoodsSpecItemsItem new];
        item.item_id = [message integerValue];
        item.spec_value = value;
        [mArr addObject:item];
        self.item.spec_items = mArr.copy;
        [self.collectionView reloadData];
    } failure:^(NSString *message) {
        
    }];
}

- (void)setItem:(SRXGoodsSpecAttrItem *)item {
    _item = item;
    _spec_name.text = item.group_name;
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.item.spec_items.count + 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.item.spec_items.count) {
        SRXSpecValueAddCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXSpecValueAddCollectionCell" forIndexPath:indexPath];
        return cell;
    } else {
        SRXSpecValueCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXSpecValueCollectionCell" forIndexPath:indexPath];
        SRXGoodsSpecItemsItem *item = self.item.spec_items[indexPath.item];
        cell.titleLb.text = item.spec_value;
        cell.deleteBtn.hidden = !item.is_select;
        cell.titleLb.textColor = item.is_select?C43B8F6:CFont99;
        cell.bgView.layer.borderColor = item.is_select?C43B8F6.CGColor:CFont99.CGColor;
        [cell.deleteBtn addCallBackAction:^(UIButton *button) {
            NSMutableArray *mArr = [NSMutableArray array];
            for (SRXGoodsSpecItemsItem *m in self.item.spec_items) {
                if (m.item_id != item.item_id) {
                    [mArr addObject:m];
                }
            }
            self.item.spec_items = mArr.copy;
            [self.collectionView reloadData];
        }];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.item.spec_items.count) {
        SRXTextFieldAlertVC *vc = [[SRXTextFieldAlertVC alloc] init];
        vc.placeholder = @"请输入规格值";
        MJWeakSelf;
        vc.block = ^(NSString * _Nonnull nickname) {
            [weakSelf addSpecValueWithValue:nickname];
        };
        [[UIViewController jk_currentViewController] presentViewController:vc animated:YES completion:nil];
    } else {
        SRXGoodsSpecItemsItem *item = self.item.spec_items[indexPath.item];
        for (SRXGoodsSpecItemsItem *m in self.item.spec_items) {
            if (item.item_id == m.item_id) {
                m.is_select = !m.is_select;
            } else {
                m.is_select = NO;
            }
        }
        if (self.selectBlock){self.selectBlock();}
        [self.collectionView reloadData];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.item.spec_items.count) {
        return CGSizeMake(62, 28);
    } else {
        SRXGoodsSpecItemsItem *item = self.item.spec_items[indexPath.item];
        CGSize size = [item.spec_value sizeForFont:[UIFont systemFontOfSize:14] size:CGSizeMake(kScreenWidth - 30, 28) mode:NSLineBreakByWordWrapping];
        CGFloat del_width = item.is_select?25:0;
        return CGSizeMake(size.width + 20 + del_width, 28);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

@end
