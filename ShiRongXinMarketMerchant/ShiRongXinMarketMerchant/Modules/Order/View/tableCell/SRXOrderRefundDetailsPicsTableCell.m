//
//  SRXOrderRefundDetailsPicsTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderRefundDetailsPicsTableCell.h"
#import "SRXOrderRefundDetailsPicsCollectionCell.h"

@interface SRXOrderRefundDetailsPicsTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConsH;
@property (nonatomic, assign) CGFloat contentSizeHeight;
@end

@implementation SRXOrderRefundDetailsPicsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    [self.collectionView registerNib:[UINib nibWithNibName:@"SRXOrderRefundDetailsPicsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXOrderRefundDetailsPicsCollectionCell"];
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
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXOrderRefundDetailsPicsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXOrderRefundDetailsPicsCollectionCell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-50-40)/5.0, (kScreenWidth-50-40)/5.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

@end
