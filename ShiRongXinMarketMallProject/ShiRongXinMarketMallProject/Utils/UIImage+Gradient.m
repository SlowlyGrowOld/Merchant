//
//  UIImage+Gradient.m
//  testLayer
//
//  Created by tb on 17/3/17.
//  Copyright © 2017年 com.tb. All rights reserved.
//

#import "UIImage+Gradient.h"

@implementation UIImage (Gradient)

- (UIImage *)createImageWithSize:(CGSize)imageSize gradientColors:(NSArray *)colors percentage:(NSArray *)percents gradientType:(GradientType)gradientType {
    
    NSAssert(percents.count <= 5, @"输入颜色数量过多，如果需求数量过大，请修改locations[]数组的个数");
    
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    CGFloat locations[5];
    for (int i = 0; i < percents.count; i++) {
        locations[i] = [percents[i] floatValue];
    }
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, locations);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientFromTopToBottom:
            start = CGPointMake(imageSize.width/2, 0.0);
            end = CGPointMake(imageSize.width/2, imageSize.height);
            break;
        case GradientFromLeftToRight:
            start = CGPointMake(0.0, imageSize.height/2);
            end = CGPointMake(imageSize.width, imageSize.height/2);
            break;
        case GradientFromLeftTopToRightBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imageSize.width, imageSize.height);
            break;
        case GradientFromLeftBottomToRightTop:
            start = CGPointMake(0.0, imageSize.height);
            end = CGPointMake(imageSize.width, 0.0);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage{

    //进行图像尺寸的压缩

    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸

    CGFloat width = imageSize.width;    //图片宽度

    CGFloat height = imageSize.height;  //图片高度

    //1.宽高大于1280(宽高比不按照2来算，按照1来算)

    if (width>1280 && height>1280) {

        if (width>height) {

            CGFloat scale = height/width;

            width = 1280;

            height = width*scale;

        }else{

            CGFloat scale = width/height;

            height = 1280;

            width = height*scale;

        }

        //2.宽大于1280高小于1280

    }else if(width>1280 && height<1280){

        CGFloat scale = height/width;

        width = 1280;

        height = width*scale;

        //3.宽小于1280高大于1280

    }else if(width<1280 && height>1280){

        CGFloat scale = width/height;

        height = 1280;

        width = height*scale;

        //4.宽高都小于1280

    }else{

    }

    UIGraphicsBeginImageContext(CGSizeMake(width, height));

    [sourceImage drawInRect:CGRectMake(0,0,width,height)];

    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    

    //进行图像的画面质量压缩

    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);

    if (data.length>100*1024) {

        if (data.length>1024*1024) {//1M以及以上

            data=UIImageJPEGRepresentation(newImage, 0.5);

        }else if (data.length>512*1024) {//0.5M-1M

            data=UIImageJPEGRepresentation(newImage, 0.6);

        }else if (data.length>200*1024) {

            //0.25M-0.5M

            data=UIImageJPEGRepresentation(newImage, 0.7);

        }

    }

    return data;

}

//获取视频的第一帧截图, 返回UIImage
+ (UIImage*)getVideoPreViewImageWithPath:(NSURL *)videoPath

{

    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoPath options:nil];

    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];

    gen.appliesPreferredTrackTransform = YES;

    CMTime time = CMTimeMakeWithSeconds(0.0, 600);

    NSError *error = nil;

    CMTime actualTime;

    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];

    UIImage *img = [[UIImage alloc] initWithCGImage:image];

    return img;

}

//view转成image
+ (UIImage*)imageWithUIView:(UIView*)view{

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
