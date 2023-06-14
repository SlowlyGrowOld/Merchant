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

@property (nonatomic,copy) NSString * _id;//用户ID
@property (nonatomic,copy) NSString * username;//昵称
@property (nonatomic,copy) NSString * nickname;//店铺
@property (nonatomic,copy) NSString * mobile;//手机号码
@property (nonatomic,copy) NSString * avatar;//头像
//@property (nonatomic, assign) UserGender sex;//性别
@property (nonatomic,copy) NSString * access_token;//token
@property (nonatomic,copy) NSString * shop_id;//
@property (nonatomic,assign) NSInteger shops_num;//
@end
