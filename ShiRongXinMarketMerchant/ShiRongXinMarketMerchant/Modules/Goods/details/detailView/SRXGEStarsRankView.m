//
//  SRXGEStarsRankView.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/30.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXGEStarsRankView.h"

@interface SRXGEStarsRankView ()
@property (nonatomic, strong) NSMutableArray *imageArr;
@end

@implementation SRXGEStarsRankView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    for (int i=0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.jk_height + 5)*i, 0, self.jk_height, self.jk_height)];
        imageView.image = [UIImage imageNamed:@"star_bright"];
        [self addSubview:imageView];
        [self.imageArr addObject:imageView];
    }
}

- (void)setScore:(NSInteger)score {
    _score = score;
    for (int i=0; i<5; i++) {
        UIImageView *imgView = self.imageArr[i];
        imgView.hidden =i<score?NO:YES;
    }
}

- (NSMutableArray *)imageArr {
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

@end
