//
//  CommonWebView.h
//  LiveMusicStudentSideProject
//
//  Created by 奇林刘 on 2020/6/16.
//  Copyright © 2020 丁清波钢琴工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonWebView : UIView

- (void)loadWeb:(NSString *)url updateHeight:(void(^)(CGFloat height))updateHeight;
- (void)loadHtml:(NSString *)html updateHeight:(void(^)(CGFloat height))updateHeight;

@end

NS_ASSUME_NONNULL_END
