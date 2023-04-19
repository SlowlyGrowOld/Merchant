//
//  CodeTextDemo
//
//  Created by 小侯爷 on 2018/9/20.
//  Copyright © 2018年 小侯爷. All rights reserved.
//

#import "HWTFCodeBView.h"
#import "IQKeyboardManager.h"

@interface HWTFCodeBView ()

@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) CGFloat itemMargin;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UIControl *maskView;

@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;

@end

@implementation HWTFCodeBView

#pragma mark - 初始化
- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin
{
    if (self = [super init]) {
        
        self.itemCount = count;
        self.itemMargin = margin;
        
        [self configTextField];
    }
    return self;
}

- (void)configTextField
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.labels = @[].mutableCopy;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [textField addTarget:self action:@selector(tfEditingChanged:) forControlEvents:(UIControlEventEditingChanged)];
    
    [self addSubview:textField];
    self.textField = textField;
    //键盘工具栏点击完成事件
    [self.textField.keyboardToolbar.doneBarButton setTarget:self action:@selector(doneBarButtonAction)];
    
    UIButton *maskView = [UIButton new];
    maskView.backgroundColor = [UIColor whiteColor];
    [maskView addTarget:self action:@selector(clickMaskView) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:maskView];
    self.maskView = maskView;
    
    for (NSInteger i = 0; i < self.itemCount; i++)
    {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkTextColor];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:36];
        label.layer.borderColor = [UIColorHex(0x999999) CGColor];
        label.layer.borderWidth = 1;
        [self addSubview:label];
        [self.labels addObject:label];
    }
}

- (void)doneBarButtonAction {
    if (self.textField.text.length >= self.itemCount) {
        [self.textField resignFirstResponder];
        if (self.codeBlock) {
            self.codeBlock(self.textField.text);
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.labels.count != self.itemCount) return;
    
    CGFloat temp = self.bounds.size.width - (self.itemMargin * (self.itemCount - 1));
    CGFloat w = temp / self.itemCount;
    CGFloat x = 0;
    
    for (NSInteger i = 0; i < self.labels.count; i++)
    {
        x = i * (w + self.itemMargin);
        
        UILabel *label = self.labels[i];
        label.frame = CGRectMake(x, 0, w, self.bounds.size.height);
    }
    
    self.textField.frame = self.bounds;
    self.maskView.frame = self.bounds;
}

#pragma mark - 编辑改变
- (void)tfEditingChanged:(UITextField *)textField
{
    if (textField.text.length > self.itemCount) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, self.itemCount)];
    }
    
    for (int i = 0; i < self.itemCount; i++)
    {
        UILabel *label = [self.labels objectAtIndex:i];
        
        if (i < textField.text.length) {
            label.text = @"·";//[textField.text substringWithRange:NSMakeRange(i, 1)];
        } else {
            label.text = nil;
        }
    }
    
    // 输入完毕后，自动隐藏键盘
    if (textField.text.length >= self.itemCount) {
        [textField resignFirstResponder];
        if (self.codeBlock) {
            self.codeBlock(textField.text);
        }
    }
}

- (void)clickMaskView
{
    [self.textField becomeFirstResponder];
}

- (BOOL)endEditing:(BOOL)force
{
    [self.textField endEditing:force];
    return [super endEditing:force];
}

- (NSString *)code
{
    return self.textField.text;
}

- (void)beganEditing {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textField becomeFirstResponder];
    });
}

@end
