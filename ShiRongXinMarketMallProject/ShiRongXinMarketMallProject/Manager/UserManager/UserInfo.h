//
//  UserInfo.h
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameInfo;

typedef NS_ENUM(NSInteger,UserGender){
    UserGenderUnKnow = 0,
    UserGenderMale, //男
    UserGenderFemale //女
};

@interface UserInfo : NSObject

@property(nonatomic,assign)long long _id;//用户ID
@property (nonatomic,copy) NSString * nickname;//昵称
@property (nonatomic,copy) NSString * mobile;//手机号码
@property (nonatomic,copy) NSString * avatar;//头像
//@property (nonatomic, assign) UserGender sex;//性别
@property (nonatomic,copy) NSString * token;//token
@property (nonatomic,copy) NSString * user_id;//显示的用户id

@end
