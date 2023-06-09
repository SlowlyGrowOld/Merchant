//
//  SRXGoodsSpecInfoEditVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsSpecInfoEditVC.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "NetworkManager+Common.h"

@interface SRXGoodsSpecInfoEditVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewConsH;
@property (weak, nonatomic) IBOutlet UILabel *sepc_name;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *package_price;
@property (weak, nonatomic) IBOutlet UITextField *score;
@property (weak, nonatomic) IBOutlet UITextField *profit;
@property (weak, nonatomic) IBOutlet UITextField *market_price;
@property (weak, nonatomic) IBOutlet UITextField *store_count;
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UIImageView *spec_img;
@property (weak, nonatomic) IBOutlet UIView *img_View;

@property (nonatomic, copy) NSString *imageUrl;
@end

@implementation SRXGoodsSpecInfoEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.isBgClose = YES;
    self.contentViewConsH.constant = (kScreenHeight - TopHeight>660)?660:(kScreenHeight - TopHeight);
    [self.contentView settingRadius:20 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    
    _sepc_name.text = self.item.spec_key_name;
    if (self.item.form) {
        _price.text = self.item.form.price.length==0?@"":[NSString stringWithNumber:@(self.item.form.price.doubleValue) formatter:@"###.##"];
        _package_price.text = self.item.form.package_price.length==0?@"":[NSString stringWithNumber:@(self.item.form.package_price.doubleValue) formatter:@"###.##"];
        _market_price.text = self.item.form.market_price.length==0?@"":[NSString stringWithNumber:@(self.item.form.market_price.doubleValue) formatter:@"###.##"];
        _profit.text = self.item.form.profit.length==0?@"":[NSString stringWithNumber:@(self.item.form.profit.doubleValue) formatter:@"###.##"];
        _score.text = self.item.form.score.length==0?@"":@(self.item.form.score.doubleValue).stringValue;
        _store_count.text = self.item.form.store_count.length==0?@"":@(self.item.form.store_count.doubleValue).stringValue;
        _weight.text = self.item.form.weight.length==0?@"":[NSString stringWithNumber:@(self.item.form.weight.doubleValue) formatter:@"###.##"];
        [_spec_img sd_setImageWithURL:[NSURL URLWithString:self.item.form.spec_img] placeholderImage:[UIImage imageNamed:@"image_load_icon"]];
        self.imageUrl = self.item.form.spec_img;
    }else {
        self.item.form = [SRXGoodsSpecForm new];
    }
    MJWeakSelf;
    [_img_View jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [weakSelf pushTZImagePickerController];
    }];
}

- (IBAction)batchBtnClick:(UIButton *)sender {
    SRXGoodsSpecFormBatch *batch = [SRXGoodsSpecFormBatch new];
    switch (sender.tag) {
        case 1:
            batch.is_price = YES;
            batch.value = self.price.text;
            break;
        case 2:
            batch.is_package_price = YES;
            batch.value = self.package_price.text;
            break;
        case 3:
            batch.is_market_price = YES;
            batch.value = self.market_price.text;
            break;
        case 4:
            batch.is_score = YES;
            batch.value = self.score.text;
            break;
        case 5:
            batch.is_profit = YES;
            batch.value = self.profit.text;
            break;
        case 6:
            batch.is_store_count = YES;
            batch.value = self.store_count.text;
            break;
        case 7:
            batch.is_weight = YES;
            batch.value = self.weight.text;
            break;
        case 8:
            batch.is_spec_img = YES;
            batch.value = self.imageUrl;
            break;
        default:
            break;
    }
    if (self.batchBlock) {
        self.batchBlock(batch);
    }
}

- (IBAction)resetBtnClick:(id)sender {
    _price.text = @"";
    _package_price.text = @"";
    _market_price.text = @"";
    _profit.text = @"";
    _score.text = @"";
    _store_count.text = @"";
    _weight.text = @"";
    _spec_img.image = [UIImage imageNamed:@"image_load_icon"];
    self.imageUrl = nil;
}

- (IBAction)saveBtnClick:(id)sender {
    self.item.form.price = _price.text;
    self.item.form.market_price = _market_price.text;
    self.item.form.package_price = _package_price.text;
    self.item.form.profit = _profit.text;
    self.item.form.score = _score.text;
    self.item.form.store_count = _store_count.text;
    self.item.form.weight = _weight.text;
    self.item.form.spec_img = self.imageUrl;
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.batchBlock) {
            self.batchBlock(nil);
        }
    }];
}

- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];

//    imagePickerVc.selectedAssets = self.evaluateModel.selectedAssets;
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    imagePickerVc.naviTitleColor = [UIColor blackColor];
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
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
//        PHAsset *asset =  (PHAsset*)assets.firstObject;
        [NetworkManager commonUploadsImages:photos isNeedHUD:YES success:^(NSDictionary * _Nonnull messageDic) {
            weakSelf.imageUrl = messageDic[@"data"];
            [weakSelf.spec_img sd_setImageWithURL:[NSURL URLWithString:weakSelf.imageUrl] placeholderImage:[UIImage imageNamed:@"image_load_icon"]];
        }failure:^(NSString * _Nonnull error) {
                
        }];
    }];
    [[UIViewController jk_currentViewController] presentViewController:imagePickerVc animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
