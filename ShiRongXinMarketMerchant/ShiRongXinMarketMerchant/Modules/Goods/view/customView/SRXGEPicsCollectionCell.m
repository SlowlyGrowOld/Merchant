//
//  SRXGEPicsCollectionCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/29.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXGEPicsCollectionCell.h"
#import "UIImage+Gradient.h"

@interface SRXGEPicsCollectionCell ()
@property (weak, nonatomic) IBOutlet UIView *markView;
@end

@implementation SRXGEPicsCollectionCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setVideo_url:(NSString *)video_url {
    _video_url = video_url;
    if ([video_url isEqualToString:@"default"]) {
        self.markView.hidden = YES;
        self.picture.image = [UIImage imageNamed:@"video_load_icon"];
    } else {
        self.markView.hidden = NO;
        self.picture.image = [UIImage getVideoPreViewImageWithPath:[NSURL URLWithString:video_url]];
    }
}

- (void)setImage_url:(NSString *)image_url {
    _image_url = image_url;
    self.markView.hidden = YES;
    if ([image_url isEqualToString:@"default"]) {
        self.picture.image = [UIImage imageNamed:@"image_load_icon"];
    } else {
        [self.picture sd_setImageWithURL:[NSURL URLWithString:image_url]];
    }
}

@end
