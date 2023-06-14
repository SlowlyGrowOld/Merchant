//
//  SRXMessageListShopView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMessageListShopView.h"
#import "SRXMessageListShopCollectionCell.h"


@interface SRXMessageListShopView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SRXMessageListShopView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SRXMessageListShopCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXMessageListShopCollectionCell"];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXMessageListShopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXMessageListShopCollectionCell" forIndexPath:indexPath];
    cell.item = self.datas[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(144, 34);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (SRXChatShopNumItem *item in self.datas) {
        item.is_select = NO;
    }
    SRXChatShopNumItem *item = self.datas[indexPath.row];
    item.is_select = YES;
    if (self.selectBlock) {
        self.selectBlock(item);
    }
    [self.collectionView reloadData];
}

@end
