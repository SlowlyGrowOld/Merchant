//
//  NetworkManager+Common.h
//  ShiRongXinMarketMallProject
//
//  Created by 薛静鹏 on 2020/4/9.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "NetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager (Common)

/// 上传文件
/// @param images 图片数组
/// @param success 成功
+(void)commonUploadsImages:(NSArray *)images
                 isNeedHUD:(BOOL)isNeedHUD
                   success:(void(^)(NSDictionary *messageDic))success
                   failure:(void (^)(NSString * error))failure;
/// 上传文件
/// @param type 1.视频  2.音频  3.gif
/// @param videoData 视频
/// @param success 成功
+(void)commonUploadsVideo:(NSData *)videoData
                     type:(NSInteger)type
                isNeedHUD:(BOOL)isNeedHUD
                  success:(void(^)(NSDictionary *messageDic))success
                  failure:(void (^)(NSString * error))failure;
@end

NS_ASSUME_NONNULL_END
