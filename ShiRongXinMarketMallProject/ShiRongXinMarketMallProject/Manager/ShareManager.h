//
//  ShareManager.h
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXMiniProgramModel : NSObject
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) NSData *hdImageData;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@end
/**
 分享 相关服务
 */
@interface ShareManager : NSObject

//单例
SINGLETON_FOR_HEADER(ShareManager)


/**
 展示分享页面
 */
-(void)showShareView;

/// 分享到小程序
/// @param model 分享参数
- (void)shareMiniProgramWithModel:(WXMiniProgramModel *)model;
@end

