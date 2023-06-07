//
//  NetworkManager+Common.m
//  ShiRongXinMarketMallProject
//
//  Created by 薛静鹏 on 2020/4/9.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "NetworkManager+Common.h"

@implementation NetworkManager (Common)
+(void)commonUploadsImages:(NSArray *)images
                 isNeedHUD:(BOOL)isNeedHUD
                   success:(void(^)(NSDictionary *messageDic))success
                   failure:(void (^)(NSString * error))failure{
    [[NetworkManager sharedClient]uploadWithURLString:@"http://app.goeasy.vip/common/uploads" photos:images isNeedSVP:isNeedHUD parameters:nil success:success failure:failure];
}
+(void)commonUploadsVideo:(NSData *)videoData
                     type:(NSInteger)type
                isNeedHUD:(BOOL)isNeedHUD
                   success:(void(^)(NSDictionary *messageDic))success
                  failure:(void (^)(NSString * error))failure{
    [[NetworkManager sharedClient]uploadWithURLString:@"http://app.goeasy.vip/common/uploads" videos:videoData type:type isNeedSVP:isNeedHUD parameters:nil success:success failure:failure];
}


@end
