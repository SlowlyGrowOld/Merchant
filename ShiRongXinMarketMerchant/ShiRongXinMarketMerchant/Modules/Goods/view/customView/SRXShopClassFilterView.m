//
//  SRXShopClassFilterView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXShopClassFilterView.h"
#import "SRXTextCollectionCell.h"
#import "NetworkManager+GoodUpdate.h"

@interface SRXShopClassFilterView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConsH;
@property (nonatomic, assign) CGFloat contentSizeHeight;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SRXShopClassFilterView

- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.allObjects.lastObject;
    BOOL result = [touch.view isDescendantOfView:self.bgView];
    if (!result){
        [self dismiss];
    }
}

- (void)dismiss {
    [self removeFromSuperview];
    if (self.closeBlock) {
        self.closeBlock(nil);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.collectionView registerNib:[UINib nibWithNibName:@"SRXTextCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXTextCollectionCell"];
    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    [self requestShopClassify];
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
        }
    }
}

- (IBAction)resetBtnClick:(id)sender {
    for (SRXShop_PlatClassifyItem *model in self.datas) {
        model.isSelect = NO;
    }
    self.parameters.extend_cat_id = @"";
    [self removeFromSuperview];
    if (self.closeBlock) {
        self.closeBlock(self.parameters);
    }
}

- (IBAction)sureBtnClick:(id)sender {
    for (SRXShop_PlatClassifyItem *model in self.datas) {
        if(model.isSelect) {
            self.parameters.extend_cat_id = model._id;
        }
    }
    [self removeFromSuperview];
    if (self.closeBlock) {
        self.closeBlock(self.parameters);
    }
}

- (void)setParameters:(SRXGoodsListParameter *)parameters {
    _parameters = parameters;
    for (SRXShop_PlatClassifyItem *model in self.datas) {
        if ([model._id isEqualToString:parameters.extend_cat_id]) {
            model.isSelect = YES;
        } else {
            model.isSelect = NO;
        }
    }
    [self.collectionView reloadData];
}

- (void)requestShopClassify {
    [NetworkManager getShopClassifyListWithSearch_word:@"" page:0 pageSize:0 success:^(NSArray *modelList) {
        self.datas = modelList;
        [self.collectionView reloadData];
    } failure:^(NSString *message) {
        
    }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXTextCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXTextCollectionCell" forIndexPath:indexPath];
    SRXShop_PlatClassifyItem *item = self.datas[indexPath.row];
    cell.titleLb.text = item.name;
    if (item.isSelect) {
        cell.titleLb.textColor = UIColor.whiteColor;
        cell.titleLb.backgroundColor = C43B8F6;
    } else {
        cell.titleLb.textColor = CFont66;
        cell.titleLb.backgroundColor = CViewBgColor;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXShop_PlatClassifyItem *item = self.datas[indexPath.row];
    CGSize size = [item.name sizeForFont:[UIFont systemFontOfSize:14] size:CGSizeMake(kScreenWidth - 30 - 40, 28) mode:NSLineBreakByWordWrapping];
    return CGSizeMake(size.width + 40, 28);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXShop_PlatClassifyItem *item = self.datas[indexPath.row];
    for (SRXShop_PlatClassifyItem *model in self.datas) {
        if ([model._id isEqualToString:item._id]) {
            item.isSelect = !item.isSelect;
        } else {
            model.isSelect = NO;
        }
    }
    [self.collectionView reloadData];
}
@end
