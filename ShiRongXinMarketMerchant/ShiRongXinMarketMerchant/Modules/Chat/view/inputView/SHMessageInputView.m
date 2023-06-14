//
//  SHMessageInputView.m
//  SHChatUI
//
//  Created by CSH on 2018/6/5.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "SHMessageInputView.h"
#import <AVFoundation/AVFoundation.h>
#import "SHShareMenuView.h"
#import "SHTextView.h"
#import "SHMessageVoiceHUD.h"
#import "SHAudioPlayerHelper.h"
#import "SHAudioRecordHelper.h"
#import "SHFileHelper.h""

@interface SHMessageInputView () <
UITextViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
SHShareMenuViewDelegate,SHAudioRecordHelperDelegate>

//改变输入状态按钮（语音、文字）
@property (nonatomic, strong) UIButton *changeBtn;
//菜单按钮
@property (nonatomic, strong) UIButton *menuBtn;
//输入背景
@property (nonatomic, strong) UIView *inputBg;
//语音输入按钮
@property (nonatomic, strong) UIButton *voiceBtn;
//文本输入框
@property (nonatomic, strong) SHTextView *textView;
//引用文本
@property (nonatomic, strong) UILabel *quoteLb;
//引用文本高度
@property (nonatomic, assign) NSInteger quoteHeight;

//其他输入控件
//菜单控件
@property (nonatomic, strong) SHShareMenuView *menuView;

@property (nonatomic, strong) SHAudioRecordHelper *audioHelper;
@property (nonatomic, assign) CGFloat playTime;
@property (nonatomic, strong) NSTimer *playTimer;

@property (nonatomic, assign) CGFloat viewY;

@end

@implementation SHMessageInputView

static CGFloat start_maxY;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, kSHWidth, 1000);
        view.backgroundColor = kInPutViewColor;
        [self addSubview:view];
        
        //分割线
        self.layer.cornerRadius = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        self.layer.borderWidth = 0.4;
        [self addKeyboardNote];
    }
    return self;
}

#pragma mark - 懒加载
#pragma mark 改变输入状态按钮（语音、文字）
- (UIButton *)changeBtn {
    if (!_changeBtn) {
        ////改变输入状态按钮（语音、文字）
        _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeBtn.size = CGSizeMake(0, 35);//kSHInPutIcon_size;
        _changeBtn.jk_x = kSHInPutSpace;
        _changeBtn.backgroundColor = UIColor.whiteColor;
        _changeBtn.layer.cornerRadius = _changeBtn.jk_width/2.0;
        [_changeBtn setImage:[UIImage imageNamed:@"msg_voice"] forState:UIControlStateNormal];
        [_changeBtn setImage:[UIImage imageNamed:@"msg_text_icon"] forState:UIControlStateSelected];
        
        [_changeBtn addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _changeBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_changeBtn];
    }
    return _changeBtn;
}

#pragma mark 输入背景
- (UIView *)inputBg {
    if (!_inputBg) {
        _inputBg = [[UIView alloc] init];
        _inputBg.origin = CGPointMake(self.changeBtn.jk_right + kSHInPutSpace, 5);
        _inputBg.backgroundColor = [UIColor whiteColor];
        _inputBg.layer.cornerRadius = 4;
        _inputBg.layer.masksToBounds = YES;
        _inputBg.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        _inputBg.layer.borderWidth = 1;
//        _inputBg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:_inputBg];
    }
    return _inputBg;
}

#pragma mark 文本输入框
- (SHTextView *)textView {
    if (!_textView) {
        _textView = [[SHTextView alloc] init];
        _textView.delegate = self;
        _textView.textContainerInset = UIEdgeInsetsMake(3, 0, 0, 0);
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.returnKeyType = UIReturnKeySend;
        _textView.autocorrectionType = UITextAutocorrectionTypeNo;
        _textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        //UITextView内部判断send按钮是否可以用
        _textView.enablesReturnKeyAutomatically = YES;
        //frame
        _textView.height = ceil(_textView.font.lineHeight) + 3;
        _textView.jk_y = (int)(self.inputBg.height - _textView.height) / 2;
        _textView.jk_x = _textView.jk_y;
        _textView.width = self.inputBg.width - 2 * _textView.jk_x;
        [self.inputBg addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)quoteLb {
    if (!_quoteLb) {
        UIView *quoteView = [UIView new];
        quoteView.layer.cornerRadius = 4;
        quoteView.layer.masksToBounds = YES;
        quoteView.backgroundColor = UIColorHex(0xDEDEDE);
        [self addSubview:quoteView];
        [quoteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(_inputBg.width);
            make.left.mas_equalTo(_inputBg.jk_x);
            make.bottom.mas_equalTo(-_inputBg.jk_y);
            make.height.mas_equalTo(24);
        }];
        
        _quoteLb = [UILabel new];
        _quoteLb.textColor = UIColorHex(0x3d3d3d);
        _quoteLb.font = [UIFont systemFontOfSize:12];
        [quoteView addSubview:_quoteLb];
        [_quoteLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(6);
            make.right.mas_equalTo(-28);
        }];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.text = @"";
        [btn setImage:[UIImage imageNamed:@"close_icon_16_white"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clearQuoteData) forControlEvents:UIControlEventTouchUpInside];
        [quoteView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(28);
            make.right.top.mas_equalTo(0);
        }];
    }
    return _quoteLb;
}

- (void)clearQuoteData {
    if (self.quoteText.length>0) {
        self.quoteText = @"";
    }
}

#pragma mark 语音输入按钮
- (UIButton *)voiceBtn {
    if (!_voiceBtn) {
        _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _voiceBtn.hidden = YES;
        
        _voiceBtn.size = self.inputBg.size;
        _voiceBtn.backgroundColor = [UIColor whiteColor];
        //文字颜色
        [_voiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //文字内容
        [_voiceBtn setTitle:@"按住说话" forState:UIControlStateNormal];
        [_voiceBtn setTitle:@"松开发送" forState:UIControlStateHighlighted];
        //点击方式
        [_voiceBtn addTarget:self action:@selector(beginRecordVoice) forControlEvents:UIControlEventTouchDown];
        [_voiceBtn addTarget:self action:@selector(endRecordVoice) forControlEvents:UIControlEventTouchUpInside];
        [_voiceBtn addTarget:self action:@selector(cancelRecordVoice) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [_voiceBtn addTarget:self action:@selector(remindDragExit) forControlEvents:UIControlEventTouchDragExit];
        [_voiceBtn addTarget:self action:@selector(remindDragEnter) forControlEvents:UIControlEventTouchDragEnter];
        
        _voiceBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.inputBg addSubview:_voiceBtn];
    }
    return _voiceBtn;
}

#pragma mark 菜单按钮
- (UIButton *)menuBtn {
    if (!_menuBtn) {
        _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _menuBtn.size = kSHInPutIcon_size;
        _menuBtn.backgroundColor = UIColor.whiteColor;
        _menuBtn.layer.cornerRadius = _menuBtn.jk_width/2.0;
        [_menuBtn setImage:[UIImage imageNamed:@"msg_menu_close"] forState:UIControlStateNormal];
        [_menuBtn setImage:[UIImage imageNamed:@"msg_menu_open"] forState:UIControlStateSelected];
        [_menuBtn addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
        _menuBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:_menuBtn];
    }
    return _menuBtn;
}

#pragma mark 自定义多媒体菜单
- (SHShareMenuView *)menuView {
    if (!_menuView) {
        CGFloat shareMenuView_H;
        //计算多媒体菜单高度
        if (self.shareMenuItems.count <= kSHShareMenuPerRowItemCount) {
            shareMenuView_H = 2 * KSHShareMenuItemTop + KSHShareMenuItemHeight;
        } else if (self.shareMenuItems.count <= kSHShareMenuPerRowItemCount * kSHShareMenuPerColum) {
            shareMenuView_H = (KSHShareMenuItemTop + KSHShareMenuItemHeight) * kSHShareMenuPerColum + KSHShareMenuItemTop;
        } else {
            shareMenuView_H = (KSHShareMenuItemTop + KSHShareMenuItemHeight) * kSHShareMenuPerColum + kSHShareMenuPageControlHeight;
        }
        
        _menuView = [[SHShareMenuView alloc] initWithFrame:CGRectMake(0, 0, kSHWidth, shareMenuView_H)];
        
        _menuView.backgroundColor = kInPutViewColor;
        _menuView.hidden = YES;
        _menuView.delegate = self;
        _menuView.shareMenuItems = self.shareMenuItems;
        [_menuView reloadData];
        
        [self.superview addSubview:_menuView];
    }
    
    return _menuView;
}

#pragma mark - 发送消息

#pragma mark 发送文字
- (void)sendMessageWithText:(NSString *)text {
    if (!text.length) {
        //没有内容
        return;
    }
    if ([_delegate respondsToSelector:@selector(chatMessageWithSendText:)]) {
        [_delegate chatMessageWithSendText:text];
    }
    [self clearQuoteData];
    self.textView.text = @"";
    [self textViewDidChange:self.textView];
}

#pragma mark 发送音频
- (void)sendMessageWithAudio:(NSString *)path duration:(NSInteger)duration {
    //保存文件 生成 消息服务器用的amr
    [SHFileHelper saveFileWithContent:path type:SHMessageFileType_aac];
    NSString *name = [SHFileHelper getFileNameWithPath:path];
    
    if ([_delegate respondsToSelector:@selector(chatMessageWithSendAudio:duration:)]) {
        [_delegate chatMessageWithSendAudio:name duration:duration];
    }
}

#pragma mark 发送图片
- (void)sendMessageWithImage:(UIImage *)image {
    //获取文件路径
    NSString *path = [SHFileHelper saveFileWithContent:image type:SHMessageFileType_image];
    NSString *name = [SHFileHelper getFileNameWithPath:path];
    if ([_delegate respondsToSelector:@selector(chatMessageWithSendImage:size:)]) {
        [_delegate chatMessageWithSendImage:name size:image.size];
    }
}

#pragma mark - UITextViewDelegate
#pragma mark 键盘上功能点击
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) { //点击了发送
        //发送文字
        [self sendMessageWithText:textView.text];
        return NO;
    }
    return YES;
}

#pragma mark 开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.inputType == SHInputViewType_menu) {
        [textView resignFirstResponder];
        [self menuClick:self.menuBtn];
        return;
    }
    if (self.inputType != SHInputViewType_emotion) {
        //输入文本
        self.inputType = SHInputViewType_text;
    }
    
    [self textViewDidChange:self.textView];
}

- (CGSize)getSizeWithAtt:(NSAttributedString *)att
                 maxSize:(CGSize)maxSize{
    
    if (att.length == 0) {
        return CGSizeZero;
    }
    
    CGSize size = [att boundingRectWithSize:maxSize options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    if (att.length && !size.width && !size.height) {
        size = maxSize;
    }
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

#pragma mark 文字改变
- (void)textViewDidChange:(UITextView *)textView {
    CGFloat maxH = ceil(textView.font.lineHeight * kSHInPutNum) +3;
    
    CGSize size = [self getSizeWithAtt:textView.attributedText maxSize:CGSizeMake(self.textView.width, CGFLOAT_MAX)];
    
    size.height = MIN(maxH, size.height + 3) + 2 * self.textView.jk_y + 2 * self.inputBg.jk_y;
    CGFloat textH = ceil(MAX(size.height, kSHInPutHeight));
    
    if (self.height != textH) {
        self.jk_y += self.height - textH - self.quoteHeight;
        self.height = textH + self.quoteHeight;
        self.inputBg.height = self.height - 2 * self.inputBg.jk_y - self.quoteHeight;
        self.textView.height = self.inputBg.height - 2 * self.textView.jk_y;
    }
}

#pragma mark - SHShareMenuViewDelegate
- (void)didSelecteShareMenuItem:(SHShareMenuItem *)menuItem index:(NSInteger)index {
    if ([_delegate respondsToSelector:@selector(didSelecteMenuItem:index:)]) {
        [_delegate didSelecteMenuItem:menuItem index:index];
    }
}

#pragma mark - SHAudioRecordHelperDelegate
- (void)audioFinishWithPath:(NSString *)path duration:(NSInteger)duration {
    if (duration) {
        //发送音频
        [self sendMessageWithAudio:path duration:duration];
    } else {
        //时间太短
        //提示框
        [SHMessageVoiceHUD shareInstance].hudType = SHVoiceHudType_warning;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SHMessageVoiceHUD shareInstance].hudType = SHVoiceHudType_remove;
        });
    }
}

#pragma mark - 录音事件
#pragma mark 开始录音
- (void)beginRecordVoice {
    //录音的时候停止播放
    [[SHAudioPlayerHelper shareInstance] stopAudio];
    
    //麦克风权限
    AVAuthorizationStatus microPhoneStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        switch (microPhoneStatus) {
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
            {
                UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"提示" message:@"开启权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [ale show];
            }
                break;
            case AVAuthorizationStatusNotDetermined:
            {
                //请求权限
                [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                    
                }];
            }
                break;
            case AVAuthorizationStatusAuthorized:
            {
                [self prepareRecordVoice];
            }
                break;

            default:
                break;
        }
    
}

#pragma mark 准备录音
- (void)prepareRecordVoice{
    
    [SHMessageVoiceHUD shareInstance].hudType = SHVoiceHudType_remove;
    [SHMessageVoiceHUD shareInstance].hudType = SHVoiceHudType_recording;
    
    //开始录音
    [self.audioHelper startRecord];
    
    
    if (self.playTimer) {
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
    
    self.playTime = 0;
    //过一段时间检测声波
    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(countVoiceTest) userInfo:nil repeats:YES];
}

#pragma mark 停止录音
- (void)endRecordVoice{
    //隐藏提示框
    [SHMessageVoiceHUD shareInstance].hudType = SHVoiceHudType_remove;
    
    if (self.playTimer) {
        [self.audioHelper stopRecord];
        
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
}

#pragma mark 取消录音
- (void)cancelRecordVoice {
    //隐藏提示框
    [SHMessageVoiceHUD shareInstance].hudType = SHVoiceHudType_remove;
    
    if (self.playTimer) {
        [self.audioHelper cancelRecord];
        
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
}

#pragma mark 离开提示
- (void)remindDragExit {
    [SHMessageVoiceHUD shareInstance].hudType = SHVoiceHudType_cancel;
}

#pragma mark 按住提示
- (void)remindDragEnter {
    [SHMessageVoiceHUD shareInstance].hudType = SHVoiceHudType_recording;
}

#pragma mark 声音检测
- (void)countVoiceTest {
    self.playTime += 0.25;
    
    int meters = [self.audioHelper peekRecorderVoiceMetersWithMax:7];
    //声波显示
    [[SHMessageVoiceHUD shareInstance] showVoiceMeters:meters];
    
    CGFloat time = self.playTime;
    //最后10秒
    if (time >= kSHTipRecordTime) {
        if (time == (int)time) {
            [[SHMessageVoiceHUD shareInstance] showCountDownWithTime:kSHMaxRecordTime - time];
        }
    }
    
    if (self.playTime >= kSHMaxRecordTime) { //超过最大时间停止
        //停止录音
        [self endRecordVoice];
    }
}

#pragma mark - 监听实现
#pragma mark 监听输入框的位置
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        //回调
        if ([self.delegate respondsToSelector:@selector(toolbarHeightChange)]) {
            [self.delegate toolbarHeightChange];
        }
    }
}

#pragma mark 监听输入框类型
- (void)setInputType:(SHInputViewType)inputType {
    if (_inputType == inputType) {
        return;
    }
    
    if (_inputType == SHInputViewType_voice && inputType == SHInputViewType_default) {
        _inputType = inputType;
        return;
    }
    if (self.quoteText.length>0) {
        if (inputType == SHInputViewType_voice) {
            self.quoteLb.superview.hidden = YES;
        } else {
            self.quoteLb.superview.hidden = NO;
            self.height =self.inputBg.height + 2 * self.inputBg.jk_y + self.quoteHeight;
        }
    }
    DLog(@"-----%.2lf",self.height);
    //初始化
    self.menuBtn.selected = NO;
    self.changeBtn.selected = NO;
    
    self.textView.hidden = YES;
    self.voiceBtn.hidden = YES;
    self.menuView.hidden = YES;
    
    _inputType = inputType;
    
    self.textView.inputView = nil;
    if (inputType != SHInputViewType_text && inputType != SHInputViewType_emotion) {
        [self.textView resignFirstResponder];
    }
    
    switch (inputType) {
        case SHInputViewType_default: //默认
        {
            self.textView.hidden = NO;
            
            [self updateViewY:start_maxY - self.height];
        } break;
        case SHInputViewType_text: //文本
        {
            self.textView.hidden = NO;
            
            [self.textView reloadInputViews];
            
            //弹出键盘
            [self.textView becomeFirstResponder];
        } break;
        case SHInputViewType_voice: //语音
        {
            self.changeBtn.selected = YES;
            
            self.voiceBtn.hidden = NO;
            self.height = kSHInPutHeight;
            self.inputBg.height = self.height - 2 * self.inputBg.jk_y;
            [self updateViewY:start_maxY - self.height];
        } break;
        case SHInputViewType_menu: //菜单
        {
            self.menuBtn.selected = YES;
            
            self.textView.hidden = NO;
            self.menuView.hidden = NO;
            
            //把高度计算出来
            [self textViewDidChange:self.textView];
            self.menuView.jk_y = self.superview.height;
            //多媒体菜单
            [self updateViewY:start_maxY - self.height - self.menuView.height];
        } break;
        default:
            break;
    }
}

#pragma mark - 键盘通知
#pragma mark 添加键盘通知
- (void)addKeyboardNote {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    // 1.显示键盘
    [center addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    
    // 2.隐藏键盘
    [center addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    
    //添加监听
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

#pragma mark 键盘通知执行
- (void)keyboardChange:(NSNotification *)notification {
    if (self.inputType == SHInputViewType_menu) {
        return;
    }
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardEndFrame;
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
//    CGFloat viewY = keyboardEndFrame.origin.y - self.height;
    CGFloat viewY = keyboardEndFrame.origin.y - self.inputBg.height - 2*self.inputBg.jk_y - _quoteHeight;
    if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
        viewY -= kSHBottomSafe;
    }
    
    [self updateViewY:viewY];
}

#pragma mark - 私有方法
#pragma mark 更新Y
- (void)updateViewY:(CGFloat)viewY {
    if (self.jk_y != viewY) {
        [UIView animateWithDuration:0.25
                         animations:^{
            self.jk_y = viewY;
            self.menuView.jk_y = self.jk_bottom;
        }];
    }
}

#pragma mark 清除
- (void)clear {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"frame"];
}

#pragma mark 处理时间
- (NSString *)dealTime:(NSInteger)time {
    if (isnan(time)) {
        return @"00:00";
    }
    
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
    formatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorPad;
    
    if (time / 3600 >= 1) {
        formatter.allowedUnits = kCFCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    } else {
        formatter.allowedUnits = NSCalendarUnitMinute | NSCalendarUnitSecond;
    }
    NSString *dealTime = [formatter stringFromTimeInterval:time];
    
    if (dealTime.length == 7 || dealTime.length == 4) {
        dealTime = [NSString stringWithFormat:@"0%@", dealTime];
    }
    
    return dealTime;
}

#pragma mark - 按钮点击
#pragma mark 状态点击
- (void)changeClick:(UIButton *)btn {
    NSLog(@"改变输入与录音状态");
    
    if (self.changeBtn.selected) {
        [self textViewDidChange:self.textView];
        //文本输入
        self.inputType = SHInputViewType_text;
    } else {
        //语音输入
        self.inputType = SHInputViewType_voice;
    }
}

#pragma mark 菜单点击
- (void)menuClick:(UIButton *)btn {
    NSLog(@"点击菜单");
    
    if (self.menuBtn.selected) {
        //文本输入
        self.inputType = SHInputViewType_text;
    } else {
        //菜单输入
        self.inputType = SHInputViewType_menu;
    }
}

#pragma mark - 公共方法
#pragma mark 刷新界面
- (void)reloadView {
    start_maxY = self.jk_bottom;
    
    self.viewY = (self.height - kSHInPutIcon_size.height) / 2;
    
    self.changeBtn.jk_y = self.viewY;
    self.menuBtn.origin = CGPointMake(kSHWidth - kSHInPutSpace - self.menuBtn.width, self.viewY);
    
    self.inputBg.width = self.menuBtn.jk_x - self.changeBtn.jk_right - 2 * kSHInPutSpace;
    self.inputBg.height = self.height - 2 * self.inputBg.jk_y;
    
    [self textView];
    
    //设置输入框类型
    self.inputType = SHInputViewType_default;
    
    //设置录音代理
    self.audioHelper = [SHAudioRecordHelper new];
    self.audioHelper.delegate = self;
}

- (void)setQuoteText:(NSString *)quoteText {
    _quoteText = quoteText;
    if (quoteText.length>0) {
        self.quoteLb.superview.hidden = NO;
        self.quoteLb.text = _quoteText;
        if (self.quoteHeight>0) {
            self.inputType = SHInputViewType_text;
            [self.textView becomeFirstResponder];
        } else {
            self.quoteHeight = 24 + 4;
            self.height = self.height + self.quoteHeight;
            self.inputBg.height = self.height - 2 * self.inputBg.jk_y - self.quoteHeight;
            self.inputType = SHInputViewType_text;
            [self.textView becomeFirstResponder];
        }
    } else {
        self.quoteLb.superview.hidden = YES;
        self.quoteHeight = 0;
        [self textViewDidChange:self.textView];
    }
}

@end
