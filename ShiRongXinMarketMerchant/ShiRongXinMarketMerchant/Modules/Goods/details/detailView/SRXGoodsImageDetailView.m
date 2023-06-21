//
//  SRXGoodsImageDetailView.m
//  ShiRongXinMarketMallProject
//
//  Created by 薛静鹏 on 2020/3/17.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXGoodsImageDetailView.h"
#import "SDPhotoBrowser.h"

@interface SRXGoodsImageDetailView()<TSVideoPlaybackDelegate,SDPhotoBrowserDelegate>

@end

@implementation SRXGoodsImageDetailView
-(NSMutableArray *)shufflingArray{
    if (_shufflingArray==nil) {
        _shufflingArray = [NSMutableArray array];
    }
    return _shufflingArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
       [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.video = [[TSVideoPlayback alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, self.height)];
    self.video.delegate = self;
    [self addSubview:self.video];
}
-(void)updateView{
    if (self.isVideo) {
        [self.video setWithIsVideo:TSDETAILTYPEVIDEO andDataArray:self.shufflingArray];
    }
    else{
        [self.video setWithIsVideo:TSDETAILTYPEIMAGE andDataArray:self.shufflingArray];
    }
}
#pragma mark - TSVideoPlaybackDelegate
-(void)videoView:(TSVideoPlayback *)view didSelectItemAtIndexPath:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
    [AppHandyMethods showImageVideoBrowserArray:self.shufflingArray selectedIndex:self.isVideo?index:index-1 projectiveView:self.video];
}
-(NSURL*)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    //网络图片（如果崩溃，可能是此图片地址不存在了）
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.shufflingArray];
    [array removeObjectAtIndex:0];
    NSString *imageName = array[index];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", imageName]];
    return url;
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    UIImage *img = [UIImage imageNamed:@"icon_tpjzz_s"];
    return img;
}
@end
