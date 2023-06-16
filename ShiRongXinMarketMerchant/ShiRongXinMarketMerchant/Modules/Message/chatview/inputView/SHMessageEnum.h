//
//  SHMessageEnum.h
//  SHChatUI
//
//  Created by CCSH on 2021/4/6.
//  Copyright © 2021 CSH. All rights reserved.
//

#ifndef SHMessageEnum_h
#define SHMessageEnum_h

#define kSHWeak(VAR) \
    try {            \
    } @finally {     \
    }                \
    __weak __typeof__(VAR) VAR##_myWeak_ = (VAR)

#define kSHStrong(VAR)                            \
    try {                                         \
    } @finally {                                  \
    }                                             \
    __strong __typeof__(VAR) VAR = VAR##_myWeak_; \
    if (VAR == nil)                               \
    return

//Caches目录
#define CachesPatch NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]

#pragma mark - 聊天资源路径
//语音WAV路径
#define kSHPath_audio_wav [SHFileHelper getCreateFilePath:[NSString stringWithFormat:@"%@/APPData/Chat/Audio/WAV", CachesPatch]]
//语音AMR路径
#define kSHPath_audio_amr [SHFileHelper getCreateFilePath:[NSString stringWithFormat:@"%@/APPData/Chat/Audio/AMR", CachesPatch]]
//语音MP3路径
#define kSHPath_audio_amr [SHFileHelper getCreateFilePath:[NSString stringWithFormat:@"%@/APPData/Chat/Audio/MP3", CachesPatch]]
//图片路径
#define kSHPath_image [SHFileHelper getCreateFilePath:[NSString stringWithFormat:@"%@/APPData/Chat/Image", CachesPatch]]
//Gif路径
#define kSHPath_gif [SHFileHelper getCreateFilePath:[NSString stringWithFormat:@"%@/APPData/Chat/Gif", CachesPatch]]
//视频路径
#define kSHPath_video [SHFileHelper getCreateFilePath:[NSString stringWithFormat:@"%@/APPData/Chat/Video", CachesPatch]]
//视频第一帧图片路径
#define kSHPath_video_image [SHFileHelper getCreateFilePath:[NSString stringWithFormat:@"%@/APPData/Chat/VideoImage", CachesPatch]]
//文件路径
#define kSHPath_file [SHFileHelper getCreateFilePath:[NSString stringWithFormat:@"%@/APPData/Chat/File", CachesPatch]]

#pragma mark - 颜色定义
//三原色
#define kRGB(R, G, B, A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]
//输入框及菜单背景颜色
#define kInPutViewColor kRGB(243, 243, 247, 1)
//按钮背景颜色
#define kShareMenuViewItemColor kRGB(255, 255, 255, 1)

#pragma mark - 宏定义

//输入框高度
#define kSHInPutHeight 49
//输入框控件间隔
#define kSHInPutSpace 7
//输入框控件宽高
#define kSHInPutIcon_size CGSizeMake(35, 35)
//输入框最多几行
#define kSHInPutNum 5

//菜单一行几个
#define kSHShareMenuPerRowItemCount 4
//菜单几行
#define kSHShareMenuPerColum 2
//下方菜单选项宽高
#define kSHShareMenuItemWH 60
//下方菜单选项整体的高度(KXHShareMenuItemHeight - kXHShareMenuItemWH 为标题的高)
#define KSHShareMenuItemHeight 80
//下方菜单控件上下间隔
#define KSHShareMenuItemTop 15
//页码高度
#define kSHShareMenuPageControlHeight 30

//设备Size
#define kSHWidth ([[UIScreen mainScreen] bounds].size.width)
#define kSHHeight ([[UIScreen mainScreen] bounds].size.height)

//下方输入控件高度
#define kChatMessageInput_H 205

//录音最大时长
#define kSHMaxRecordTime 15
//录音最小时长
#define kSHMinRecordTime 1
//录音提示时长
#define kSHTipRecordTime 5

#define kIsFull (kSHTopSafe > 20)

#define kSHBottomSafe (kIsFull ? 39 : 0)
#define kSHTopSafe ([[UIApplication sharedApplication] statusBarFrame].size.height)

//内容最大宽度（截取到气泡）
#define kChat_content_maxW (kSHWidth - 4*kChat_margin - 2*kChat_icon - kChat_angle_w - 40)

//内容设置
//图片
//图片最大宽高
#define kChat_pic_size CGSizeMake(160, 160)
//语音
//语音最大size
#define kChat_voice_size CGSizeMake(160, kChat_min_h)
//位置
//位置size
#define kChat_location_size CGSizeMake(200, 120)
//名片
//名片的size
#define kChat_card_size CGSizeMake(200, 80.5)
//视频
//视频最大zise
#define kChat_video_size CGSizeMake(160, 160)
//动图
//Gif最大size
#define kChat_gif_size CGSizeMake(100, 100)
//红包
//红包size
#define kChat_red_size CGSizeMake(200, 80)
//文件
//文字size
#define kChat_file_size CGSizeMake(200, 76)

//字体
//时间字体
#define kChatFont_time [UIFont systemFontOfSize:11]
//ID字体
#define kChatFont_name [UIFont systemFontOfSize:11]
//内容字体
#define kChatFont_content [UIFont systemFontOfSize:16]
//提示内容字体
#define kChatFont_note [UIFont systemFontOfSize:12]


/**
 *  消息类型
 */
typedef enum {
    SHMessageBodyType_text = 1,       //文本类型
    SHMessageBodyType_image,          //图片类型
    SHMessageBodyType_voice,          //语音类型
    SHMessageBodyType_video,          //视频类型
    SHMessageBodyType_location,       //位置类型
    SHMessageBodyType_card,           //名片类型
    SHMessageBodyType_redPaper,       //红包类型
    SHMessageBodyType_gif,            //动图类型
    SHMessageBodyType_note,           //通知类型
    SHMessageBodyType_file,           //文件类型
    SHMessageBodyType_cmd,            //系统类型(界面不做展示)
    SHMessageBodyType_custom,         //自定义类型
}SHMessageBodyType;

/**
 *  资源类型
 */
typedef enum {
    SHMessageFileType_image = 1,    //image类型
    SHMessageFileType_wav,          //wav类型
    SHMessageFileType_amr,          //amr类型
    SHMessageFileType_aac,          //wav类型
    SHMessageFileType_gif,          //gif类型
    SHMessageFileType_video,        //video类型
    SHMessageFileType_video_image,  //video图片类型
    SHMessageFileType_file,         //file类型
}SHMessageFileType;

/**
 *  输入框类型
 */
typedef enum {
    SHInputViewType_default,     //默认
    SHInputViewType_text,        //文本
    SHInputViewType_voice,       //语音
    SHInputViewType_emotion,     //表情
    SHInputViewType_menu,        //菜单
}SHInputViewType;

/**
 *  地图类型
 */
typedef enum {
    SHMessageLocationType_Location = 1,   //定位
    SHMessageLocationType_Look            //查看
}SHMessageLocationType;

/**
 *  点击类型
 */
typedef enum {
    SHMessageClickType_click_message = 1,   //点击消息
    SHMessageClickType_long_message,        //长按消息
    SHMessageClickType_click_head,          //点击头像
    SHMessageClickType_long_head,           //长按头像
    SHMessageClickType_click_retry,         //点击重发
}SHMessageClickType;

/**
 *  发送方
 */
typedef enum{
    SHBubbleMessageType_Send = 0, // 发送
    SHBubbleMessageType_Receiving, // 接收
}SHBubbleMessageType;

/**
 *  聊天类型
 */
typedef enum{
    SHChatType_Chat = 1,  //单聊
    SHChatType_GroupChat  //群聊
}SHChatType;

/**
 *  消息发送状态
 */
typedef enum{
    SHSendMessageType_Successed = 1,  //发送成功
    SHSendMessageType_Failed,         //发送失败
    SHSendMessageType_Sending         //发送中
}SHSendMessageStatus;


#endif /* SHMessageEnum_h */
