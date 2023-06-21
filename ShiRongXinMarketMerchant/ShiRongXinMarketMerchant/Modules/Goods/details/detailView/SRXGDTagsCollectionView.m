//
//  SRXGDTagsCollectionView.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/30.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXGDTagsCollectionView.h"
#import "SRXGETagsCollectionCell.h"
#import "SRXGoodsEvaluateListModel.h"

@interface SRXGDTagsCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation SRXGDTagsCollectionView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.tagFont = 12;
    self.delegate = self;
    self.dataSource = self;
    self.showsHorizontalScrollIndicator = NO;
    [self registerNib:[UINib nibWithNibName:@"SRXGETagsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXGETagsCollectionCell"];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXGETagsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXGETagsCollectionCell" forIndexPath:indexPath];
    if (self.type == SRXGDTagsTypeEvaluate) {
        SRXGELEvaluate_defaultItem *tag = self.datas[indexPath.row];
        cell.tagLb.text = [NSString stringWithFormat:@"%@ %@",tag.title,@(tag.e_num)];
        if (self.isSelect) {
            cell.tagLb.backgroundColor = tag.is_select?UIColorHex(0xFFC7B1):UIColorHex(0xE5E5E5);
        }else {
            cell.tagLb.backgroundColor = UIColorHex(0xFFC7B1);
        }
        return cell;
    }
    NSString *string = self.datas[indexPath.row];
    cell.tagLb.text = string;
    cell.tagLb.textColor = COrange;
    cell.tagLb.layer.borderColor = COrange.CGColor;
    cell.tagLb.layer.borderWidth = 1;
    cell.tagLb.backgroundColor = UIColor.whiteColor;
    cell.tagLb.font = [UIFont systemFontOfSize:self.tagFont];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title;
    if (self.type == SRXGDTagsTypeEvaluate) {
        SRXGELEvaluate_defaultItem *tag = self.datas[indexPath.row];
        title = [NSString stringWithFormat:@"%@ %@",tag.title,@(tag.e_num)];
    }else {
        title = self.datas[indexPath.row];
    }
    CGFloat width = [self getWidthWithStr:title];
    return CGSizeMake(width+10, self.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == SRXGDTagsTypeEvaluate) {
        if (!self.isSelect) {
            return;
        }
        for (int i=0; i<self.datas.count; i++) {
            SRXGELEvaluate_defaultItem *tag = self.datas[i];
            if (i== indexPath.row) {
                tag.is_select = YES;
            }
            tag.is_select = NO;
        }
        [self reloadData];
        if (self.selectBlock) {
            self.selectBlock(indexPath.row);
        }
    }
}

- (CGFloat)getWidthWithStr:(NSString *)text
{
    CGFloat width = [text boundingRectWithSize:CGSizeMake(KScreenWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.tagFont]} context:nil].size.width;
    return width;
}

@end
