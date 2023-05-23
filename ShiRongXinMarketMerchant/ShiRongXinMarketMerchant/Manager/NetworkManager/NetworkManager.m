//
//  NetworkManager.m
//  ZFTParking
//
//  Created by 薛静鹏 on 2018/4/24.
//  Copyright © 2018年 薛静鹏. All rights reserved.
//

#import "NetworkManager.h"
#import "SRXLoginHelloVC.h"
#import "UIImage+Gradient.h"

@implementation NetworkManager

+ (instancetype)sharedClient {
    static NetworkManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[NetworkManager alloc]initWithBaseURL:[NSURL URLWithString:[UserAccount sharedAccount].isOnline ? OnlineBaseURL:TestBaseURL]];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 20;
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy.validatesDomainName = NO;
    });
    return manager;
}

#pragma mark - 三种请求
- (void)postWithURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                isNeedSVP:(BOOL)isNeedSVP
                  success:(void(^)(NSDictionary *messageDic))success{
    kWeakSelf;
    [self prepareRequestNeedSVP:isNeedSVP url:URLString parameters:parameters];
    [self POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf handleResponse:(NSDictionary *)responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf handleFailure:error task:task];
    }];
}

- (void)postWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters isNeedSVP:(BOOL)isNeedSVP success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure {
    kWeakSelf;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    dic[@"shop_id"] = [UserManager sharedUserManager].curUserInfo.shop_id;
    parameters = dic.copy;
    [self prepareRequestNeedSVP:isNeedSVP url:URLString parameters:parameters];
    [self POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf handleResponse:(NSDictionary *)responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"error");
        [weakSelf handleFailure:error task:task];
    }];
}

- (void)getWithURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
               isNeedSVP:(BOOL)isNeedSVP
                 success:(void(^)(NSDictionary *messageDic))success{
    kWeakSelf;
    [self prepareRequestNeedSVP:isNeedSVP url:URLString parameters:parameters];
    [self GET:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf handleResponse:(NSDictionary *)responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf handleFailure:error task:task];
    }];
}
- (void)getWithURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
               isNeedSVP:(BOOL)isNeedSVP
                 success:(void(^)(NSDictionary *messageDic))success
                 failure:(void (^)(NSString *))failure {
    kWeakSelf;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    dic[@"shop_id"] = [UserManager sharedUserManager].curUserInfo.shop_id;
    parameters = dic.copy;
    [self prepareRequestNeedSVP:isNeedSVP url:URLString parameters:parameters];
    [self GET:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf handleResponse:(NSDictionary *)responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"error");
        [weakSelf handleFailure:error task:task];
    }];
}
-(void)deleteWithURLString:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                 isNeedSVP:(BOOL)isNeedSVP
                   success:(void(^)(NSDictionary *messageDic))success{
    kWeakSelf;
    [self prepareRequestNeedSVP:isNeedSVP url:URLString parameters:parameters];
    [self DELETE:URLString parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf handleResponse:(NSDictionary *)responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf handleFailure:error task:task];
    }];
}
-(void)putWithURLString:(NSString *)URLString
             parameters:(NSDictionary *)parameters
              isNeedSVP:(BOOL)isNeedSVP
                success:(void(^)(NSDictionary *messageDic))success{
    kWeakSelf;
    [self prepareRequestNeedSVP:isNeedSVP url:URLString parameters:parameters];
    [self PUT:URLString parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf handleResponse:(NSDictionary *)responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf handleFailure:error task:task];
    }];
}
-(void)putWithURLString:(NSString *)URLString
             parameters:(NSDictionary *)parameters
              isNeedSVP:(BOOL)isNeedSVP
                success:(void(^)(NSDictionary *messageDic))success
                failure:(void (^)(NSString *))failure {
    kWeakSelf;
    [self prepareRequestNeedSVP:isNeedSVP url:URLString parameters:parameters];
    [self PUT:URLString parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf handleResponse:(NSDictionary *)responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf handleFailure:error task:task];
        failure(@"请求失败");
    }];
}
- (void)uploadWithURLString:(NSString *)URLString
                     photos:(NSArray *)photos
                  isNeedSVP:(BOOL)isNeedSVP
                 parameters:(NSDictionary *)parameters
                    success:(void(^)(NSDictionary *messageDic))success
                    failure:(void (^)(NSString *))failure {
    [self prepareRequestNeedSVP:isNeedSVP url:URLString parameters:parameters];
    kWeakSelf;
    [self POST:URLString parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<photos.count; i++) {
            UIImage *image = photos[i];
            NSString *mimetype;
            NSString *filetype;
            if (UIImagePNGRepresentation(image)!= nil) {
                mimetype = @"image/png";
                filetype = @"png";
            }else{
                mimetype = @"image/jpeg";
                filetype = @"jpg";
            }
            NSData *imageData = [UIImage zipNSDataWithImage:image];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.%@", str,filetype];
            [formData appendPartWithFileData:imageData name:@"file[]" fileName:fileName mimeType:mimetype];
        }
    } progress:nil
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf handleResponse:(NSDictionary *)responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf handleFailure:error task:task];
        failure(@"上传失败");
    }];
}
- (void)uploadWithURLString:(NSString *)URLString
                     videos:(NSData *)videoData
                       type:(NSInteger)type
                  isNeedSVP:(BOOL)isNeedSVP
                 parameters:(NSDictionary *)parameters
                    success:(void(^)(NSDictionary *messageDic))success
                    failure:(void (^)(NSString * error))failure{
    [self prepareRequestNeedSVP:isNeedSVP url:URLString parameters:parameters];
    kWeakSelf;
    [self POST:URLString parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.%@", str,type==1?@"mp4":@"acc"];
        [formData appendPartWithFileData:videoData name:@"file[]" fileName:fileName mimeType:type==1?@"video/mp4":@"amr/mp3/acc"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf handleResponse:(NSDictionary *)responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf handleFailure:error task:task];
        failure(@"上传失败");
    }];
}

#pragma mark - 请求和结果处理
- (void)prepareRequestNeedSVP:(BOOL)needSVP url:(NSString *)url parameters:(NSDictionary *)parameters {
    NSLog(@"token:%@ url:%@ ,参数：%@", [[UserManager sharedUserManager] curUserInfo].access_token,url ,parameters);
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[[UserManager sharedUserManager] curUserInfo].access_token] forHTTPHeaderField:@"Authorization"];
    if (needSVP) {
        [SVProgressHUD show];
    }
}

- (void)handleResponse:(NSDictionary *)response success:(void(^)(NSDictionary *messageDic))success {
    [self handleResponse:response success:success failure:nil];
}

- (void)handleResponse:(NSDictionary *)response success:(void(^)(NSDictionary *messageDic))success failure:(void (^)(NSString *))failure {
    NSLog(@"The data responsed >>>>> %@",response);
    [SVProgressHUD dismiss];
    if ([response[@"code"] integerValue] == 1) {//成功
        success(response);
        return;
    } else if ([response[@"code"] integerValue] == 0) {//失败
        if ([response[@"msg"] isEqualToString:@"未设置支付密码"]) {
            
        }else {
            [SVProgressHUD showErrorWithStatus:response[@"msg"]];
        }
        !failure?:failure(response[@"msg"]);
        return;
    } else if ([response[@"code"] integerValue] == 401) {//未登录
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:response[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
            [UserManager clearUser];
            [AppHandyMethods switchWindowToLoginScene];
            
        }];
        [sureAction setValue:MainColor forKey:@"titleTextColor"];
        [alert addAction:sureAction];
        [kAppDelegate.currentPresentedVC presentViewController:alert animated:YES completion:nil];
        return;
    } else if ([response[@"code"] integerValue] == 801) {//实名认证

    } else if ([response[@"code"] integerValue] == 201 || [response[@"code"] integerValue] == 202) {//代理冻结、已终止
        success(response);
        return;
    }else if ([response[@"code"] integerValue] == 210) {//货款不足
        success(response);
        return;
    }else if ([response[@"code"] integerValue] == 209) {//还未申请代理
        success(response);
        return;
    }
        
}

- (void)handleFailure:(NSError * _Nonnull)error task:(NSURLSessionDataTask * _Nullable)task {
    [SVProgressHUD dismiss];
    NSString *error1 = [self failHandleWithErrorResponse:error task:task];
    [SVProgressHUD showErrorWithStatus:error1];
}

- (NSString *)failHandleWithErrorResponse:( NSError * _Nullable )error task:( NSURLSessionDataTask * _Nullable )task {
    __block NSString *message = nil;
    // 这里可以直接设定错误反馈，也可以利用AFN 的error信息直接解析展示
    NSData *afNetworking_errorMsg = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
    NSLog(@"afNetworking_errorMsg == %@",[[NSString alloc]initWithData:afNetworking_errorMsg encoding:NSUTF8StringEncoding]);
    if (!afNetworking_errorMsg) {
        message = @"网络连接失败";
    }
    else{
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger responseStatue = response.statusCode;
        if (responseStatue >= 500) {  // 网络错误
            message = @"服务器维护升级中,请耐心等待";
        } else if (responseStatue >= 400) {
            
            // 错误信息
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:afNetworking_errorMsg options:NSJSONReadingAllowFragments error:nil];
            message = responseObject[@"error"];
        }
        
        
    }
    
    NSLog(@"error == %@",error);
    return message;
}

@end
