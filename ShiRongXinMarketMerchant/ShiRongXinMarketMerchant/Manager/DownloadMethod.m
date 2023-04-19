//
//  DownloadMethod.m
//  YPKYProject
//
//  Created by 别天神 on 2021/7/21.
//

#import "DownloadMethod.h"
#import <AFNetworking.h>

@implementation DownloadMethod


//-----下载图片-----
- (void)imageDownload:(NSString *)url {
    UIImageView *imgV = [[UIImageView alloc] init];
    [imgV sd_setImageWithURL:[NSURL URLWithString:url]];
    UIImageWriteToSavedPhotosAlbum(imgV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)imageDownloadWithImage:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
        [SVProgressHUD showErrorWithStatus:msg];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}


//-----下载视频-----
- (void)playerDownload:(NSString *)url{
            
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"jaibaili.mp4"];
    NSURL *urlNew = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlNew];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        double progress = (double)downloadProgress.completedUnitCount/(double)downloadProgress.totalUnitCount;
        NSLog(@"下载进度 = %f",progress);
        [SVProgressHUD showProgress:progress];
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"%@",response);
        [SVProgressHUD dismiss];
        [self saveVideo:fullPath];
    }];
    
    [task resume];
    
}

//videoPath为视频下载到本地之后的本地路径
- (void)saveVideo:(NSString *)videoPath{
    
    if (videoPath) {
        NSURL *url = [NSURL URLWithString:videoPath];
        BOOL compatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([url path]);
        if (compatible)
        {
            //保存相册核心代码
            UISaveVideoAtPathToSavedPhotosAlbum([url path], self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
        }
    }
}


//保存视频完成之后的回调
- (void) savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        NSLog(@"保存视频失败%@", error.localizedDescription);
        [SVProgressHUD showSuccessWithStatus:@"保存视频失败!"];
    }
    else {
        NSLog(@"保存视频成功");
        [SVProgressHUD showSuccessWithStatus:@"保存视频成功"];
    }
}

@end
