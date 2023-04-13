//
//  ShareAlert.h
//  JobInterestProject
//
//  Created by 奇林刘 on 2019/10/30.
//  Copyright © 2019 icare. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareAlert : UIView

+ (ShareAlert *)show;//默认分享邀请链接
+ (ShareAlert *)showWithImage:(UIImage *)image;//分享图片
+ (ShareAlert *)showWithShareUrl:(NSString *)shareUrl;//分享链接

@end

NS_ASSUME_NONNULL_END
