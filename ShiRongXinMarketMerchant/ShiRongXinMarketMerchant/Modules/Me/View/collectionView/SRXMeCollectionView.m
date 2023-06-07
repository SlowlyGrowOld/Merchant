//
//  SRXMeCollectionView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/17.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMeCollectionView.h"
#import "SRXMeImageCollectionCell.h"
#import "SRXMeTextCollectionCell.h"
#import "SRXOrdersCenterPageC.h"

@implementation SRXMeCollectionModel
+ (SRXMeCollectionModel *)configWithTitle:(NSString *)title content:(NSString *)content {
    SRXMeCollectionModel *model = [[SRXMeCollectionModel alloc] init];
    model.title = title;
    model.content = content;
    return model;
}
@end

@interface SRXMeCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation SRXMeCollectionView

-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self initWithCollectionView];
    }
    return self;
}
- (void)initWithCollectionView{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 3, 0, 3);
    layout.itemSize = CGSizeMake((kScreenWidth-16)/4, 60);
    
    self.collectionViewLayout = layout;
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"SRXMeImageCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXMeImageCollectionCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMeTextCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXMeTextCollectionCell"];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SRXMeCollectionModel *model = self.datas[indexPath.item];
    if (self.type == SRXMeCollectionTypeImage) {
        SRXMeImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXMeImageCollectionCell" forIndexPath:indexPath];
        cell.titleLb.text = model.title;
        cell.image.image = [UIImage imageNamed:model.content];
        return cell;
    } else {
        SRXMeTextCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXMeTextCollectionCell" forIndexPath:indexPath];
        cell.titleLb.text = model.title;
        cell.contentLb.text = model.content;
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.jumpType == SRXMeCollectionJumpTypeMyOrder) {
        kAppDelegate.mainTabBar.selectedIndex = 2;
        RootNavigationController *nav = kAppDelegate.mainTabBar.viewControllers[2];
        SRXOrdersCenterPageC *vc = nav.viewControllers.firstObject;
        if (indexPath.item==0) {
            vc.pageIndex = 1;
        } else if (indexPath.item==1) {
            vc.pageIndex = 0;
        } else if (indexPath.item==2) {
            vc.pageIndex = 2;
        } else{
            vc.pageIndex = 4;
        }
    } else if (self.jumpType == SRXMeCollectionJumpTypeOther) {
        kAppDelegate.mainTabBar.selectedIndex = indexPath.row==0?3:2;
    }
}

@end
