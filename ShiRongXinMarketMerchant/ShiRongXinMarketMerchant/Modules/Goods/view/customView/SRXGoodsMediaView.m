//
//  SRXGoodsMediaView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/30.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsMediaView.h"
#import "SRXGEPicsCollectionCell.h"

#import <TZImagePickerController/TZImagePickerController.h>

#import <CoreServices/CoreServices.h>
#import "NetworkManager+Common.h"
#import <GKPhotoBrowser.h>
#import "NSURL+JHExt.h"
#import "VideoCompress.h"
#import <AVFoundation/AVFoundation.h>
#import "YBImageBrowser.h"
#import "YBIBVideoData.h"

@interface SRXGoodsMediaView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, strong) YBImageBrowser *browser;
@end

@implementation SRXGoodsMediaView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.delegate = self;
    self.dataSource = self;
    self.contentInset = UIEdgeInsetsMake(0, 10, 0, 0);
    [self registerNib:[UINib nibWithNibName:@"SRXGEPicsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXGEPicsCollectionCell"];
    self.limit_num = 1;
}

- (void)setDatas:(NSMutableArray *)datas {
    _datas = datas;
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.datas.count>self.limit_num-1){
        return self.limit_num;
    }else{
        return self.datas.count + 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXGEPicsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXGEPicsCollectionCell" forIndexPath:indexPath];
    cell.deleteBtn.hidden = (self.datas.count!=self.limit_num && indexPath.row==self.datas.count)?YES:NO;
    if (self.is_video) {
        if (self.datas.count < self.limit_num && indexPath.row==self.datas.count) {
            cell.video_url = @"default";
        } else {
            cell.video_url = self.datas[indexPath.row];
        }
    } else {
        if (self.datas.count < self.limit_num && indexPath.row==self.datas.count) {
            cell.image_url = @"default";
        } else {
            cell.image_url = self.datas[indexPath.row];
        }
    }
    MJWeakSelf;
    [cell.deleteBtn addCallBackAction:^(UIButton *button) {
        [weakSelf.datas removeObjectAtIndex:indexPath.row];
        if (weakSelf.block) {
            weakSelf.block(weakSelf.datas.count==weakSelf.limit_num?weakSelf.datas.count:weakSelf.datas.count+1);
        }
        [weakSelf reloadData];
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.is_video) {
        return CGSizeMake((kScreenWidth - 20)/5*126/78, (kScreenWidth - 20)/5);
    }else {
        return CGSizeMake((kScreenWidth - 20)/5, (kScreenWidth - 20)/5);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.datas.count) {
        [self pushTZImagePickerController];
    }else {
        [self showImageVideoBrowserArray:self.datas selectedIndex:indexPath.row];
    }
}

#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    
    NSInteger maxNum = self.limit_num - self.datas.count;
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxNum columnNumber:4 delegate:self pushPhotoPickerVc:YES];

//    imagePickerVc.selectedAssets = self.evaluateModel.selectedAssets;
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    imagePickerVc.naviTitleColor = [UIColor blackColor];
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = YES;   // 在内部显示拍视频按
    imagePickerVc.allowEditVideo = YES;
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingImage = self.is_video?NO:YES;
    imagePickerVc.allowPickingVideo = self.is_video?YES:NO;
    imagePickerVc.allowPickingGif = self.is_gif;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.videoMaximumDuration = 30;
    imagePickerVc.maxCropVideoDuration = 30;
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = NO;
    imagePickerVc.showSelectBtn = NO;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = KScreenWidth - 2 * left;
    NSInteger top = (KScreenHeight - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.statusBarStyle = UIStatusBarStyleDefault;
    imagePickerVc.naviBgColor = UIColor.whiteColor;
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.modalPresentationStyle = 0;
    kWeakSelf;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        PHAsset *asset =  (PHAsset*)assets.firstObject;
        if (asset.mediaType == PHAssetMediaTypeVideo && assets.count ==1) {
           
        }else {
            [NetworkManager commonUploadsImages:photos isNeedHUD:YES success:^(NSDictionary * _Nonnull messageDic) {
                [weakSelf.datas addObjectsFromArray:[messageDic[@"data"] componentsSeparatedByString:@","]];
                if (weakSelf.block) {
                    weakSelf.block(weakSelf.datas.count==weakSelf.limit_num?weakSelf.datas.count:weakSelf.datas.count+1);
                }
                [weakSelf reloadData];
            }failure:^(NSString * _Nonnull error) {
                
            }];
        }
    }];
    [imagePickerVc setDidFinishPickingGifImageHandle:^(UIImage *animatedImage, id sourceAssets) {
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.resizeMode = PHImageRequestOptionsResizeModeFast;
        options.synchronous=YES;
        PHCachingImageManager *mager = [[PHCachingImageManager alloc]init];
        [mager requestImageDataForAsset:sourceAssets options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            [SVProgressHUD show];
            [NetworkManager commonUploadsVideo:imageData type:3 isNeedHUD:YES success:^(NSDictionary * _Nonnull messageDic) {
                DLog(@"url:%@",messageDic);
                [weakSelf.datas addObject:messageDic[@"data"]];
                [weakSelf reloadData];
            } failure:^(NSString * _Nonnull error) {
    
            }];
        }];
    }];
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
//        [SVProgressHUD show];
        if (asset.mediaType == PHAssetMediaTypeVideo) {
            [[TZImageManager manager] getVideoWithAsset:asset completion:^(AVPlayerItem *playerItem, NSDictionary *info) {
                AVURLAsset *urlAsset = (AVURLAsset *)playerItem.asset;
                NSData *videoData = [NSData dataWithContentsOfURL:urlAsset.URL];
                DLog(@"压缩前:%ld",videoData.length);
//                NSURL *mp4Url = [NSURL jjMovConvert2Mp4:urlAsset.URL];
//                NSData *video1Data = [NSData dataWithContentsOfURL:mp4Url];
//                DLog(@"mp4压缩:%ld",video1Data.length);
//                [self compressVideoWithVideoUrl:urlAsset.URL];
//                [NetworkManager commonUploadsVideo:mp4Url success:^(NSDictionary * _Nonnull messageDic) {
//                    NSLog(@"url:%@",messageDic);
//                    self.evaluateModel.videoUrl = messageDic[@"data"];
//                    [self reloadData];
//                }];
            }];
        }
    }];
    [imagePickerVc setDidFinishPickingAndEditingVideoHandle:^(UIImage *coverImage, NSString *outputPath, NSString *errorMsg) {
        DLog(@"%@---%@",coverImage,outputPath);
        NSData *videoData = [NSData dataWithContentsOfFile:outputPath];
        DLog(@"压缩前:%ld",videoData.length);
        [SVProgressHUD show];
        [NetworkManager commonUploadsVideo:videoData type:1 isNeedHUD:YES success:^(NSDictionary * _Nonnull messageDic) {
            DLog(@"url:%@",messageDic);
            [weakSelf.datas addObject:messageDic[@"data"]];
            [weakSelf reloadData];
        } failure:^(NSString * _Nonnull error) {
            
        }];
    }];
    
    [[UIViewController jk_currentViewController] presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - 点击查看详情图片浏览器
- (void)showImageVideoBrowserArray:(NSArray *)dataArray selectedIndex:(NSInteger)index {
    
    //防止多重点击
    if (self.browser.superview) {
        return;
    }
    
    NSMutableArray *datas = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasSuffix:@".mp4"] && [obj hasPrefix:@"http"]) {
            
            // 网络视频
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL URLWithString:obj];
            data.projectiveView = nil;
            [datas addObject:data];
         
        } else if ([obj hasSuffix:@".mp4"]) {
            
            // 本地视频
            NSString *path = [[NSBundle mainBundle] pathForResource:obj.stringByDeletingPathExtension ofType:obj.pathExtension];
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL fileURLWithPath:path];
            data.projectiveView = nil;
            [datas addObject:data];
            
        } else if ([obj hasPrefix:@"http"]) {
            
            // 网络图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageURL = [NSURL URLWithString:obj];
            data.projectiveView = nil;
            [datas addObject:data];
            
        } else {
            
            // 本地图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageName = obj;
            data.projectiveView = nil;
            [datas addObject:data];
            
        }
    }];
    self.browser = [YBImageBrowser new];
    _browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    _browser.dataSourceArray = datas;
    _browser.currentPage = index;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
    [_browser show];
}
@end
