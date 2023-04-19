//
//  DownloadMethod.h
//  YPKYProject
//
//  Created by 别天神 on 2021/7/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadMethod : NSObject

//-----下载视频--
- (void)playerDownload:(NSString *)url;

//下载图片
- (void)imageDownload:(NSString *)url;
- (void)imageDownloadWithImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
