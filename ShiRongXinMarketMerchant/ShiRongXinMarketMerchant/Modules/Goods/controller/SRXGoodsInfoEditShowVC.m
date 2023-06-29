//
//  SRXGoodsInfoEditShowVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/29.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsInfoEditShowVC.h"
#import "SRXGoodsMediaView.h"

@interface SRXGoodsInfoEditShowVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsImageConsH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BannersConsH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gifConsH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoConsH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videosConsH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailsConsH;
@property (weak, nonatomic) IBOutlet SRXGoodsMediaView *imageCollectionView;
@property (weak, nonatomic) IBOutlet SRXGoodsMediaView *bannersCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *bannerNum;
@property (weak, nonatomic) IBOutlet SRXGoodsMediaView *gifCollectionView;
@property (weak, nonatomic) IBOutlet SRXGoodsMediaView *videoCollectionView;
@property (weak, nonatomic) IBOutlet SRXGoodsMediaView *videosCollectionView;
@property (weak, nonatomic) IBOutlet SRXGoodsMediaView *detailCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;

@end

@implementation SRXGoodsInfoEditShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CViewBgColor;
    CGFloat height = (kScreenWidth - 20)/5;
    _goodsImageConsH.constant = height;
    _gifConsH.constant = height;
    _videoConsH.constant = height;
    _bannersCollectionView.limit_num = 9;
    _gifCollectionView.is_gif = YES;
    _videoCollectionView.is_video = YES;
    _videosCollectionView.limit_num = 2;
    _videosCollectionView.is_video = YES;
    _detailCollectionView.limit_num = 9;
    MJWeakSelf;
    _bannersCollectionView.block = ^(NSInteger count) {
        weakSelf.BannersConsH.constant = count>5?height * 2:height;
        weakSelf.bannerNum.text = [NSString stringWithFormat:@"商品轮播图（%zd/9）",weakSelf.bannersCollectionView.datas.count];
    };
    _detailCollectionView.block = ^(NSInteger count) {
        weakSelf.detailsConsH.constant = count>5?height * 2:height;
    };
}

- (void)setEditInfo:(SRXGoodsEditInfoModel *)editInfo {
    _editInfo = editInfo;
    
    self.lookBtn.hidden = editInfo._id?NO:YES;
    _imageCollectionView.datas = editInfo.image.length>0?@[editInfo.image].mutableCopy:@[].mutableCopy;
    
    _bannerNum.text = [NSString stringWithFormat:@"商品轮播图（%zd/9）",editInfo.images.count];
    _bannersCollectionView.datas = [NSMutableArray arrayWithArray:editInfo.images];
    CGFloat height = (kScreenWidth - 20)/5;
    self.BannersConsH.constant = editInfo.images.count>=5?height * 2:height;
    
    _gifCollectionView.datas = editInfo.gif_image.length>0?@[editInfo.gif_image].mutableCopy:@[].mutableCopy;
    
    _videoCollectionView.datas = editInfo.video.length>0?@[editInfo.video].mutableCopy:@[].mutableCopy;
    _videosCollectionView.datas = [NSMutableArray arrayWithArray:editInfo.videos];
    _videosConsH.constant = editInfo.videos.count>2?height * 2:height;
    
    _detailCollectionView.datas = [NSMutableArray arrayWithArray:editInfo.goods_content];
    _detailsConsH.constant = editInfo.goods_content.count>=5?height * 2:height;
}

- (void)setGoods_id:(NSString *)goods_id {
    _goods_id = goods_id;
    self.lookBtn.hidden = goods_id.intValue>0?NO:YES;
}

- (IBAction)lastStepBtnClick:(id)sender {
    if (self.block) {
        self.block(0);
    }
}
- (IBAction)saveBtnClick:(id)sender {
    [self configParameters];
    if (self.block) {
        self.block(1);
    }
}
- (IBAction)lookBtnClick:(id)sender {
    if (self.block) {
        self.block(2);
    }
}

- (void)configParameters {
    self.parameters = [NSMutableDictionary dictionary];
    self.parameters[@"image"] = self.imageCollectionView.datas.count>0?self.imageCollectionView.datas.firstObject:nil;
    self.parameters[@"images"] = self.bannersCollectionView.datas;
    self.parameters[@"gif_image"] = self.gifCollectionView.datas.count>0?self.gifCollectionView.datas.firstObject:nil;
    self.parameters[@"video"] = self.videoCollectionView.datas.count>0?self.videoCollectionView.datas.firstObject:nil;
    self.parameters[@"videos"] = self.videosCollectionView.datas;
    self.parameters[@"goods_content"] = self.detailCollectionView.datas;

    DLog(@"销售信息：%@",self.parameters);
}
@end
