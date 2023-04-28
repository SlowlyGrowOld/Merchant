//
//  SRXShopClassFilterView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXShopClassFilterView.h"
#import "SRXTextCollectionCell.h"

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
    if (self.removeBlock) {
        self.removeBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.collectionView registerNib:[UINib nibWithNibName:@"SRXTextCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXTextCollectionCell"];
    self.datas = @[@"订单",@"啥啥啥",@"发发发",@"佛山市地方"];
    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.collectionView reloadData];
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
    [self dismiss];
}

- (IBAction)sureBtnClick:(id)sender {
    [self dismiss];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXTextCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXTextCollectionCell" forIndexPath:indexPath];
    cell.titleLb.backgroundColor = CViewBgColor;
    cell.titleLb.text = self.datas[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [self.datas[indexPath.item] sizeForFont:[UIFont systemFontOfSize:14] size:CGSizeMake(kScreenWidth - 30 - 40, 28) mode:NSLineBreakByWordWrapping];
    return CGSizeMake(size.width + 40, 28);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
