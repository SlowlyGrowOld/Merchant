//
//  NetworkManager.h
//  ZFTParking
//
//  Created by 薛静鹏 on 2018/4/24.
//  Copyright © 2018年 薛静鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface NetworkManager : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (void)prepareRequestNeedSVP:(BOOL)needSVP url:(NSString *)url parameters:(NSDictionary *)parameters;

/**
 发送post请求
 
 @param URLString 请求的网址字符串
 @param parameters 请求的参数
 @param isNeedSVP 是否需要弹窗
 @param success 请求成功的回调
 */
- (void)postWithURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                isNeedSVP:(BOOL)isNeedSVP
                  success:(void(^)(NSDictionary *messageDic))success;

- (void)postWithURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                isNeedSVP:(BOOL)isNeedSVP
                  success:(void(^)(NSDictionary *messageDic))success
                  failure:(void(^)(NSString *error))failure;

/**
 发送get请求
 
 @param URLString 请求的网址字符串
 @param parameters 请求的参数
 @param success 请求成功的回调
 */
- (void)getWithURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
               isNeedSVP:(BOOL)isNeedSVP
                 success:(void(^)(NSDictionary *messageDic))success;

- (void)getWithURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
               isNeedSVP:(BOOL)isNeedSVP
                 success:(void(^)(NSDictionary *messageDic))success
                 failure:(void (^)(NSString *error))failure;


/// 发送delete请求
/// @param URLString 请求的网址字符串
/// @param parameters 请求的参数
/// @param isNeedSVP 是否需要弹窗
/// @param success 结果
-(void)deleteWithURLString:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                 isNeedSVP:(BOOL)isNeedSVP
                   success:(void(^)(NSDictionary *messageDic))success;

///
/// @param URLString URL
/// @param parameters 请求的参数
/// @param isNeedSVP 是否需要弹窗
/// @param success 结果
-(void)putWithURLString:(NSString *)URLString
             parameters:(NSDictionary *)parameters
              isNeedSVP:(BOOL)isNeedSVP
                success:(void(^)(NSDictionary *messageDic))success;
-(void)putWithURLString:(NSString *)URLString
             parameters:(NSDictionary *)parameters
              isNeedSVP:(BOOL)isNeedSVP
                success:(void(^)(NSDictionary *messageDic))success
                failure:(void(^)(NSString *error))failure;
/**
 图片上传请求
 
 @param URLString url
 @param photos 照片
 @param isNeedSVP 是否需要弹窗
 @param success 数据
 */
- (void)uploadWithURLString:(NSString *)URLString
                     photos:(NSArray *)photos
                  isNeedSVP:(BOOL)isNeedSVP
                 parameters:(NSDictionary *)parameters
                    success:(void(^)(NSDictionary *messageDic))success
                    failure:(void(^)(NSString *error))failure;
///视频上传
///type 包含 1：视频  2：音频
- (void)uploadWithURLString:(NSString *)URLString
                     videos:(NSData *)videoData
                       type:(NSInteger)type
                  isNeedSVP:(BOOL)isNeedSVP
                 parameters:(NSDictionary *)parameters
                    success:(void(^)(NSDictionary *messageDic))success
                    failure:(void (^)(NSString * error))failure;
@end
