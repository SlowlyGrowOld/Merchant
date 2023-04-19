//
//  GameInfo.h
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameInfo : NSObject

@property(nonatomic,assign) long long gold_coin;//金币数
@property(nonatomic,assign) long long flow;//流量币
@property(nonatomic,assign) long long growth_value;//成长值
@property (nonatomic,assign) NSInteger  level;//用户等级
@property(nonatomic,assign) long long cash;//现金

@end
