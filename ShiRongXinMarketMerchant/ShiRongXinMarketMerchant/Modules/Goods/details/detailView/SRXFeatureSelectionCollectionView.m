//
//  SRXFeatureSelectionCollectionView.m
//  ShiRongXinMarketMallProject
//
//  Created by 薛静鹏 on 2020/3/18.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXFeatureSelectionCollectionView.h"
#import "DCCollectionHeaderLayout.h"
#import "DCFeatureItemCell.h"
#import "DCFeatureHeaderView.h"
#import "SRXFeatureImageItemCollectionViewCell.h"
#import "SRXSpecModel.h"
#import "SRXSpecValueModel.h"

@interface SRXFeatureSelectionCollectionView()<HorizontalCollectionLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, assign) CGFloat contentSizeHeight;
@end

@implementation SRXFeatureSelectionCollectionView
-(NSMutableDictionary *)seleDic{
    if (_seleDic==nil) {
        _seleDic = [NSMutableDictionary dictionary];
    }
    return _seleDic;
}

-(NSMutableArray *)specArray{
    if (_specArray==nil) {
        _specArray = [NSMutableArray array];
    }
    return _specArray;
}
-(NSMutableArray *)specGoods{
    if (_specGoods==nil) {
        _specGoods = [NSMutableArray array];
    }
    return _specGoods;
}
-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self setupCollectionView];
    }
    return self;
}
-(void)setupCollectionView{
    DCCollectionHeaderLayout *layout = [DCCollectionHeaderLayout new];
    [self setCollectionViewLayout:layout];
    //自定义layout初始化
    layout.delegate = self;
    layout.lineSpacing = 10;
    layout.interitemSpacing = 10;
    layout.headerViewHeight = 40;
    layout.footerViewHeight = 0;
    layout.itemInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.delegate = self;
    self.dataSource = self;
    self.alwaysBounceVertical = YES;
    
    [self registerClass:[DCFeatureItemCell class] forCellWithReuseIdentifier:@"DCFeatureItemCell"];//cell
    [self registerNib:[UINib nibWithNibName:@"SRXFeatureImageItemCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SRXFeatureImageItemCollectionViewCell"];
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FeatureSelectionCell"];
    [self registerClass:[DCFeatureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DCFeatureHeaderView"]; //头部
    [self registerNib:[UINib nibWithNibName:@"SRXFeatureFooterReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SRXFeatureFooterReusableView"];
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //尾部
    
    self.numberButton = [PPNumberButton numberButtonWithFrame:CGRectZero];
    self.numberButton.shakeAnimation = YES;
    self.numberButton.minValue = 1;
    self.numberButton.inputFieldFont = 23;
    self.numberButton.increaseTitle = @"＋";
    self.numberButton.decreaseTitle = @"－";
    self.numberButton.currentNumber = 1;
    self.numberButton.decreaseImage = [UIImage imageWithColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]];
    self.numberButton.increaseImage = [UIImage imageWithColor:UIColorHex(#C3511C)];
    self.numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        NSLog(@">>>%ld",(long)num);
    };
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)contex {
    if ([keyPath isEqualToString:@"contentSize"]) {
        if (self.contentSizeHeight != self.contentSize.height) {
            NSLog(@"%f",self.contentSize.height);
            self.contentSizeHeight = self.contentSize.height;
            if (self.heightBlock) {
                self.heightBlock(self.contentSizeHeight);
            }
        }
    }
}

-(void)setIs_package_edit_num:(BOOL)is_package_edit_num {
    _is_package_edit_num = is_package_edit_num;
    self.numberButton.decreaseBtn.enabled = is_package_edit_num;
    self.numberButton.increaseBtn.enabled = is_package_edit_num;
}

- (void)setMax_number:(NSInteger)max_number {
    _max_number = max_number;
    if(self.numberView) {
        self.numberView.max_number = max_number;
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.is_hidden_num?self.specArray.count:self.specArray.count+1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==self.specArray.count) {
        return 1;
    }
    else{
        SRXSpecModel *model = [SRXSpecModel mj_objectWithKeyValues:self.specArray[section]];
        return model.spec_value.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==self.specArray.count) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FeatureSelectionCell" forIndexPath:indexPath];
        cell.selected = NO;
//        [self.numberButton removeFromSuperview];
//        [cell.contentView addSubview:self.numberButton];
//        [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.offset(0);
//            make.top.offset(0);
//            make.width.offset(150);
//            make.height.offset(40);
//        }];
        return cell;
    }
    else {
        DCFeatureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DCFeatureItemCell" forIndexPath:indexPath];
        SRXSpecModel *model = self.specArray[indexPath.section];
        SRXSpecValueModel *value = model.spec_value[indexPath.row];
        cell.contentView.layer.cornerRadius = 4;
        cell.attLabel.text = value.value;
        cell.attLabel.textColor = value.isDisabled?UIColorHex(0x999999):[UIColor blackColor];
        cell.stockoutLb.hidden = value.isDisabled?NO:YES;
        cell.contentView.backgroundColor = UIColorHex(0xF2F2F2);
        if ([self.seleDic.allKeys containsObject:model.name]) {
            SRXSpecValueModel *selectValue = self.seleDic[model.name];
            if ([value._id isEqualToString:selectValue._id]) {
                cell.attLabel.textColor = [UIColor whiteColor];
                cell.contentView.backgroundColor = UIColorHex(#C84D1D);
            }
        }
        return cell;
    }
//    else if (indexPath.section==0) {
//        SRXFeatureImageItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXFeatureImageItemCollectionViewCell" forIndexPath:indexPath];
//        cell.content.text = @"测试";
//        cell.contentView.layer.cornerRadius = 4;
//        cell.contentView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
//        return cell;
//    }
//    else {
//        DCFeatureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DCFeatureItemCell" forIndexPath:indexPath];
//        cell.contentView.layer.cornerRadius = 4;
//        cell.attLabel.textColor = [UIColor blackColor];
//        cell.attLabel.text = @"测试";
//        cell.contentView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
//        return cell;
//    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind  isEqualToString:UICollectionElementKindSectionHeader]) {
        if(indexPath.section==self.specArray.count){
            if(!self.numberView) {
                self.numberView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SRXFeatureFooterReusableView" forIndexPath:indexPath];
                self.numberView.max_number = self.max_number;
                if(self.current_number > 0){
                    self.numberView.currentNumber = self.current_number;
                    self.numberView.buy_number.text = @(self.current_number).stringValue;
                }
            }
            return self.numberView;
        }else {
            DCFeatureHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DCFeatureHeaderView" forIndexPath:indexPath];
            if (indexPath.section==self.specArray.count) {
                headerView.headerLabel.text = @"数量：";
            }
            else{
                SRXSpecModel *model = self.specArray[indexPath.section];
                headerView.headerLabel.text = model.name;
            }
            return headerView;
        }
    }
    return nil;
}
#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==self.specArray.count) {
        return;
    }
    SRXSpecModel *model = self.specArray[indexPath.section];
    SRXSpecValueModel *value = model.spec_value[indexPath.row];
    if (value.isDisabled) {
        return;
    }
    if ([self.seleDic.allKeys containsObject:model.name]) {
        SRXSpecValueModel *v = self.seleDic[model.name];
        if ([v._id isEqualToString:value._id]) {
            [self.seleDic removeObjectForKey:model.name];
            if (self.specArray.count >0 && self.seleDic.allKeys.count ==self.specArray.count-1 && self.block) {
                self.block(nil);
                self.numberView.max_number = 0;
            }
        }else {
            [self.seleDic setValue:value forKey:model.name];
        }
    }else {
        [self.seleDic setValue:value forKey:model.name];
    }
    if (self.seleDic.allKeys.count==self.specArray.count) {
        if (self.block) {
            self.block(self.seleDic);
        }
        for (NSString *key in self.seleDic.allKeys) {
            NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:self.seleDic];
            [mDic removeObjectForKey:key];
            [self dealSpecEnableWith:mDic.copy];
        }
    }else {
        [self dealSpecEnableWith:self.seleDic];
    }
    [self reloadData];
}

- (void)dealSpecEnableWith:(NSDictionary *)dic {
    if (self.specArray.count < 2) {
        return;
    }
    if (self.seleDic.allKeys.count < self.specArray.count - 1) {
        ///有两排及以上规格未选中
        if (self.seleDic.allKeys.count>0) {
            for (NSString *key in self.seleDic.allKeys) {
                for (SRXSpecModel *model in self.specArray) {
                    if (![model.name isEqualToString:key]) {
                        for (SRXSpecValueModel *v in model.spec_value) {
                            v.isDisabled = NO;
                        }
                    }
                }
            }
        }else {
            for (SRXSpecModel *model in self.specArray) {
                for (SRXSpecValueModel *v in model.spec_value) {
                    v.isDisabled = NO;
                }
            }
        }
    }else {
        ///选中n-1个规格判断，存量0不能点击
        for (SRXSpecGoodsPriceModel *data in self.specGoods) {
            NSArray *keys = [data.spec_key componentsSeparatedByString:@"_"];
            NSMutableArray *mArr = [NSMutableArray arrayWithArray:keys];
            for (NSString *key in dic.allKeys) {
                SRXSpecValueModel *specValue = dic[key];
                if (![keys containsObject:specValue._id]) {
                    [mArr removeAllObjects];
                    break;
                }
                [mArr removeObject:specValue._id];
            }
            if (mArr.count == 1) {
                for (NSString *_id in mArr) {
                    for (SRXSpecModel *m in self.specArray) {
                        for (SRXSpecValueModel *v in m.spec_value) {
                            if ([v._id isEqualToString:_id]) {
                                v.isDisabled = data.store_count.intValue ==0?YES:NO;
                            }
                        }
                    }
                }
            }
        }
        //选中小于n个规格,选中规格默认可点击
        if (self.specArray.count > 1 &&self.seleDic.allKeys.count == self.specArray.count-1) {
            for (NSString *key in self.seleDic.allKeys) {
                for (SRXSpecModel *m in self.specArray) {
                    if ([m.name isEqualToString:key]) {
                        for (SRXSpecValueModel *v in m.spec_value) {
                            v.isDisabled = NO;
                        }
                    }
                }
            }
        }
    }
}
#pragma mark - <HorizontalCollectionLayoutDelegate>
#pragma mark - 自定义layout必须实现的方法
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==self.specArray.count) {
        return @"99999";
    }
    else {
        SRXSpecModel *model = [SRXSpecModel mj_objectWithKeyValues:self.specArray[indexPath.section]];
        SRXSpecValueModel *value = [SRXSpecValueModel mj_objectWithKeyValues:model.spec_value[indexPath.row]];
        return value.value;
    }
}

// 用协议传回 headerSize 的 size
- (CGSize)collectionViewDynamicHeaderSizeWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==self.specArray.count) {
        return CGSizeMake(kScreenWidth, 40);
    }else {
        return CGSizeMake(kScreenWidth, 40);
    }
}
@end
