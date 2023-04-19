//
//  AppHandyMethods.m
//  ShiRongXinMarketMerchant
//
//  Created by 奇林刘 on 2020/3/6.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "AppHandyMethods.h"
#import "SRXLoginHelloVC.h"

#import "YBImageBrowser.h"
#import "YBIBVideoData.h"
#import <JPUSHService.h>

@implementation AppHandyMethods

//+ (void)saveUserWithLoginMode:(UserModelLogin *)loginModel {
//    [UserManager sharedUserManager].curUserLoginModel = loginModel;
//    [kUserDefaults setValue:loginModel.mj_JSONString forKey:UserDefaultkeyLoginModel];
//    [kUserDefaults synchronize];
//}

//+ (void)clearUser {
//    [UserManager sharedUserManager].curUserLoginModel = nil;
//    [kUserDefaults setValue:nil forKey:UserDefaultkeyLoginModel];
//    [kUserDefaults synchronize];
//    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//        DLog(@"deleteAlias");
//    } seq:1];
//}

+ (void)switchWindowToMainScene {
    kAppDelegate.mainTabBar = [[MainTabBarController alloc] init];
    kAppWindow.rootViewController = kAppDelegate.mainTabBar;
}

+ (void)switchWindowToBindPhoneScene {
//    BindPhoneVC *vc = [[BindPhoneVC alloc] initWithNibName:@"BindPhoneVC" bundle:nil];
//    RootNavigationController *nav = [[RootNavigationController alloc] initWithRootViewController:vc];
//    kAppWindow.rootViewController = nav;
}

+ (void)switchWindowToLoginScene {
    UIStoryboard *login = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    RootNavigationController *vc = [[RootNavigationController alloc] initWithRootViewController:[login instantiateViewControllerWithIdentifier:@"SRXLoginHelloVC"]];
    kAppWindow.rootViewController = vc;
}

+ (void)handleAPNS:(NSDictionary *)apns {
   
}


+ (UIImage *)switchGetImageWithView:(UIScrollView *)scrollView {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, NO, [UIScreen mainScreen].scale);
     
    } else {
        UIGraphicsBeginImageContext(scrollView.contentSize);
    }
    //先保存原来frame 和 偏移量
    CGPoint savedContentOffset = scrollView.contentOffset;
    CGRect savedFrame = scrollView.frame;
    CGSize contentSize = scrollView.contentSize;
    CGRect oldBounds = scrollView.layer.bounds;

    if(@available(iOS 13, *)){
        //iOS 13 系统截屏需要改变tableview 的bounds
         [scrollView.layer setBounds:CGRectMake(oldBounds.origin.x, oldBounds.origin.y, contentSize.width, contentSize.height)];
    }

    //偏移量归零
    scrollView.contentOffset = CGPointZero;
    //frame变为contentSize
    scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    //截图
     [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    if(@available(iOS 13,*)){
        [scrollView.layer setBounds:oldBounds];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //还原frame 和 偏移量
    scrollView.contentOffset = savedContentOffset;
    scrollView.frame = savedFrame;
    
    return image;
}

+ (UIImage *)getImageWithView:(UIView *)view {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(view.frame.size);
    }

    //截图
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    if(@available(iOS 13, *)){
        //iOS 13 系统截屏需要改变tableview 的bounds
         [view.layer setBounds:CGRectMake(view.origin.x, view.origin.y, view.frame.size.width, view.frame.size.height)];
    }

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/**
 比较两个版本号的大小（2.0）
 
 @param v1 第一个版本号
 @param v2 第二个版本号
 @return 版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
 */
+ (NSInteger)compareVersion2:(NSString *)v1 to:(NSString *)v2 {
    // 都为空，相等，返回0
    if (!v1 && !v2) {
        return 0;
    }
    
    // v1为空，v2不为空，返回-1
    if (!v1 && v2) {
        return -1;
    }
    
    // v2为空，v1不为空，返回1
    if (v1 && !v2) {
        return 1;
    }
    
    // 获取版本号字段
    NSArray *v1Array = [v1 componentsSeparatedByString:@"."];
    NSArray *v2Array = [v2 componentsSeparatedByString:@"."];
    // 取字段最大的，进行循环比较
    NSInteger bigCount = (v1Array.count > v2Array.count) ? v1Array.count : v2Array.count;
    
    for (int i = 0; i < bigCount; i++) {
        // 字段有值，取值；字段无值，置0。
        NSInteger value1 = (v1Array.count > i) ? [[v1Array objectAtIndex:i] integerValue] : 0;
        NSInteger value2 = (v2Array.count > i) ? [[v2Array objectAtIndex:i] integerValue] : 0;
        if (value1 > value2) {
            // v1版本字段大于v2版本字段，返回1
            return 1;
        } else if (value1 < value2) {
            // v2版本字段大于v1版本字段，返回-1
            return -1;
        }
        
        // 版本相等，继续循环。
    }

    // 版本号相等
    return 0;
}


+ (void)theCopyActionWith:(NSString *)string {
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = string;
    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
}

//加载html片段
+ (NSAttributedString *)attrHtmlStringFrom:(NSString *)str {
        
    str = [NSString stringWithFormat:@"<html><meta content=\"width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=0; \" name=\"viewport\" /> <body style=\"overflow-wrap:break-word;word-break:break-all;white-space: normal; font-size:12px; color:#666666; \">%@</body></html>",str];
        
    str = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;height:auto}</style></head>%@",kScreenWidth,str];
    
    NSAttributedString *attrStr=  [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
    return attrStr;
}

//获取UILabel的行数
+ (NSInteger)rowsOfString:(NSString *)text withFont:(UIFont *)font withWidth:(CGFloat)width
{
    if (!text || text.length == 0) {
        return 0;
    }
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,width,MAXFLOAT));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    return lines.count;
}

/*!
@brief 修正浮点型精度丢失
@param str 传入接口取到的数据
@return 修正精度后的数据
*/
+(NSString *)reviseString:(NSString *)str {
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

//登录弹窗
+ (void)switchToLoginAlert {
    
    __block BOOL canPush = YES;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
            
        canPush = NO;
        [AppHandyMethods clearUser];
        SRXLoginHelloVC *vc = [[SRXLoginHelloVC alloc] initWithNibName:@"SRXLoginVC" bundle:nil];
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:^{
                    
        }];
        
    }];
    [sureAction setValue:MainColor forKey:@"titleTextColor"];
    [alert addAction:sureAction];
    [kAppDelegate.currentPresentedVC presentViewController:alert animated:YES completion:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (canPush) {
            [alert dismissViewControllerAnimated:YES completion:^{
                [AppHandyMethods clearUser];
//                SRXLoginVC *vc = [[NewLoginVC alloc] initWithNibName:@"SRXLoginVC" bundle:nil];
//                vc.backToLast = YES;
//                [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:^{
//
//                }];
            }];
        }
    });
    
}

+ (void)callWithPhone:(NSString *)phone {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+ (void)showImageVideoBrowserArray:(NSArray *)dataArray selectedIndex:(NSInteger)index projectiveView:(UIView *)projectiveView{
    
    NSMutableArray *datas = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasSuffix:@".mp4"] && [obj hasPrefix:@"http"]) {
            
            // 网络视频
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL URLWithString:obj];
            data.projectiveView = projectiveView;
            [datas addObject:data];
         
        } else if ([obj hasSuffix:@".mp4"]) {
            
            // 本地视频
            NSString *path = [[NSBundle mainBundle] pathForResource:obj.stringByDeletingPathExtension ofType:obj.pathExtension];
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL fileURLWithPath:path];
            data.projectiveView = projectiveView;
            [datas addObject:data];
            
        } else if ([obj hasPrefix:@"http"]) {
            
            // 网络图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageURL = [NSURL URLWithString:obj];
            data.projectiveView = projectiveView;
            [datas addObject:data];
            
        } else {
            
            // 本地图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageName = obj;
            data.projectiveView = projectiveView;
            [datas addObject:data];
            
        }
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = index;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    [browser show];
}
@end
