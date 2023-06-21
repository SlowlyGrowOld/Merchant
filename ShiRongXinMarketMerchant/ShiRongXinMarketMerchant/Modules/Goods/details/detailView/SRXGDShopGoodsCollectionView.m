//
//  SRXGDShopGoodsCollectionView.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/12/21.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXGDShopGoodsCollectionView.h"
#import "SRXGDShopGoodsCollectionCell.h"
#import "SRXAllTheGoodsModel.h"
@interface SRXGDShopGoodsCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>



@end
@implementation SRXGDShopGoodsCollectionView


-(NSMutableArray *)datas{
    if (_datas==nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
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
    flowLayout.itemSize = CGSizeMake((kScreenWidth-70)/3, (kScreenWidth-70)/3 + 42);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 0;
    self.collectionViewLayout = flowLayout;
    [self registerNib:[UINib nibWithNibName:@"SRXGDShopGoodsCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SRXGDShopGoodsCollectionCell"];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SRXGDShopGoodsCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXGDShopGoodsCollectionCell" forIndexPath:indexPath];
    SRXAllTheGoodsModel *model = self.datas[indexPath.row];
    [cell.good_image sd_setImageWithURL:[NSURL URLWithString:model.image]];
    cell.good_name.text = model.goods_name;
    cell.good_price.text = [NSString stringWithNumber:@(model.price.floatValue) formatter:@"##.##"];

    if (model.after_coupon_price>0) {
        cell.tagLb.superview.hidden = NO;
        cell.tagLb.text = @"卷后价";
        cell.good_price.text = [NSString stringWithNumber:@(model.after_coupon_price) formatter:@"##.##"];
    }else if (model.member_price.floatValue > 0 && self.isMember) {
        cell.tagLb.superview.hidden = NO;
        cell.tagLb.text = @"会员价";
        cell.good_price.text = [NSString stringWithNumber:@(model.member_price.floatValue) formatter:@"##.##"];
    }else {
        cell.tagLb.superview.hidden = YES;
        if (model.market_price.floatValue > 0) {
            cell.original_price.text = model.market_price;
            NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",cell.original_price.text]];
            [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
            cell.original_price.attributedText = newPrice;
        }else {
            cell.original_price.text = @"";
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
