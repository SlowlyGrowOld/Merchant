//
//  SRXODPicsCollectionView.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/30.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXGDPicsCollectionView.h"
#import "SRXImageCollectionViewCell.h"

@interface SRXGDPicsCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation SRXGDPicsCollectionView


-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self initWithCollectionView];
    }
    return self;
}

- (void)initWithCollectionView{
    
    self.delegate = self;
    self.dataSource = self;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    self.collectionViewLayout = flowLayout;
    self.showsHorizontalScrollIndicator = NO;
    [self registerNib:[UINib nibWithNibName:@"SRXImageCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SRXImageCollectionViewCell"];
}

- (void)setImages:(NSArray *)images {
    _images = images;
    [self reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SRXImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXImageCollectionViewCell" forIndexPath:indexPath];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:self.images[indexPath.row]]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXImageCollectionViewCell * cell = (SRXImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [AppHandyMethods showImageVideoBrowserArray:self.images selectedIndex:indexPath.row projectiveView:cell];
}
@end
