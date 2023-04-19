//
//  CommonWebView.m
//  LiveMusicStudentSideProject
//
//  Created by 奇林刘 on 2020/6/16.
//  Copyright © 2020 丁清波钢琴工作室. All rights reserved.
//

#import "CommonWebView.h"
#import <WebKit/WebKit.h>
#import <ReactiveObjC.h>

@interface CommonWebView ()<WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;
@property (assign, nonatomic) CGFloat contentHeight;
@property (strong, nonatomic) void (^updateHeight)(CGFloat height);

@end

@implementation CommonWebView

-(instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self initSelf];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    self.webView = [WKWebView new];
//    self.webView.navigationDelegate = self;
    [self addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
    kWeakSelf;
    [RACObserve(self.webView.scrollView, contentSize) subscribeNext:^(NSNumber *x) {
        CGFloat height = x.CGSizeValue.height;
        if (height != weakSelf.contentHeight) {
            weakSelf.contentHeight = height;
            if (weakSelf.updateHeight) weakSelf.updateHeight(weakSelf.contentHeight);
        }
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    if (objc_getAssociatedObject(self, _cmd)) return; else objc_setAssociatedObject(self, _cmd, @"Launched", OBJC_ASSOCIATION_RETAIN);
}


- (void)loadWeb:(NSString *)url updateHeight:(void(^)(CGFloat height))updateHeight {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    self.updateHeight = updateHeight;
}

- (void)loadHtml:(NSString *)html updateHeight:(void(^)(CGFloat height))updateHeight {
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    [self.webView loadHTMLString:[headerString stringByAppendingString:html] baseURL:nil];
    self.updateHeight = updateHeight;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    CGFloat webViewHeight = webView.scrollView.contentSize.height;
    if (self.updateHeight) self.updateHeight(webViewHeight);
}
@end
