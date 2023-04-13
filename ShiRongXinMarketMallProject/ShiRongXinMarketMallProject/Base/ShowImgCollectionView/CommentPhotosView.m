//
//  CommentPhotosView.m
//  ShengBaiClientProject
//
//  Created by 别天神 on 2021/3/11.
//

#import "CommentPhotosView.h"
#import <GKPhotoBrowser.h>
@interface CommentPhotoCollectionCell:UICollectionViewCell
@property (nonatomic, strong) UIImageView *icon;
@end

@implementation CommentPhotoCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.icon = [[UIImageView alloc]initWithFrame:self.bounds];
        self.icon.layer.cornerRadius = 10;
        self.icon.layer.contentMode = UIViewContentModeScaleAspectFill;
        self.icon.layer.masksToBounds = YES;
        [self.contentView addSubview:self.icon];
    }
    return self;
}

@end

@interface CommentPhotosView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation CommentPhotosView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    self.showsHorizontalScrollIndicator = NO;
    [self registerClass:[CommentPhotoCollectionCell class] forCellWithReuseIdentifier:@"cellID"];
    self.collectionViewLayout = ({
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout;
    });
        
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.type == CommentPhotosViewTypeFiveAny) {
        return 5;
    } else {
        return MIN(self.datas.count, self.maxCount);
    }
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommentPhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    if(self.datas.count > 0 && self.datas.count > indexPath.row) {
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:self.datas[indexPath.row]] placeholderImage:nil];
    }
    
    if (self.type == CommentPhotosViewTypeFiveImage || self.type == CommentPhotosViewTypeFiveAny) {
        cell.icon.layer.cornerRadius = 23;
        
        if(self.type == CommentPhotosViewTypeFiveAny) {
            cell.layer.cornerRadius = 23;
            if(indexPath.row >= self.minCount) {  // 多出来cell进行隐藏
                cell.hidden = YES;
            } else { // 显示剩下的
                cell.hidden = NO;
                if(indexPath.row < self.datas.count) {
                    [cell.icon sd_setImageWithURL:[NSURL URLWithString:self.datas[indexPath.row]] placeholderImage:nil];
                } else {
                    if(self.isNoComplete) {
                        cell.hidden = YES;
                    } else {
                        cell.icon.image = [UIImage imageNamed:@"tianjia"];
                    }
                    
                }
                
            }
        }
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.type == CommentPhotosViewTypeFiveAny) {
        if(indexPath.row > self.datas.count - 1) {
            !self.addMemberBlock ?: self.addMemberBlock();
        }
        return;
    }
    CommentPhotoCollectionCell *cell = (CommentPhotoCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    [self.datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *model = [[GKPhoto alloc] init];
        model.url = [NSURL URLWithString:obj];
        model.sourceImageView = cell.icon;
        [photos addObject:model];
    }];
    
    GKPhotoBrowser *browser = [[GKPhotoBrowser alloc] initWithPhotos:photos currentIndex:indexPath.row];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    [browser showFromVC:[UIViewController jk_currentViewController]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == CommentPhotosViewTypeFourImage) {
        return CGSizeMake((self.frame.size.width - 15)/4-1,(self.frame.size.width - 15)/4-1);
    }else if (self.type == CommentPhotosViewTypeFiveImage || self.type == CommentPhotosViewTypeFiveAny) {
        return CGSizeMake(46, 46);
    }
    return CGSizeMake((self.frame.size.width - 25)/3,(self.frame.size.width - 25)/3);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (self.type == CommentPhotosViewTypeFourImage) {
        return 5;
    }else if (self.type == CommentPhotosViewTypeFiveImage) {
        return (self.frame.size.width - 46*5)/4;
    } else if(self.type == CommentPhotosViewTypeFiveAny) {
//        if(self.minCount <= 5) {
//            return (self.frame.size.width - 46*self.minCount)/ (self.minCount - 1);
//        } else {
//            return 14;
//        }
        return (self.frame.size.width - 46*5)/4;
    }
    return 12;
}


@end
