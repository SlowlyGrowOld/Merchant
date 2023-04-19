//
//  GBPopMenuView.m
//  WJMenu
//
//  Created by mac on 2016/12/2.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "GBPopMenuView.h"
#import "GBIndicatorView.h"

#define GBScreen_Height      [[UIScreen mainScreen] bounds].size.height
#define GBScreen_Width       [[UIScreen mainScreen] bounds].size.width

@interface GBPopMenuView()
{
    UIView *_backgroundView;
    UIButton *_select_button;
}
@end

static const NSInteger paddxSide = 10;
static const NSInteger paddxMid = 12;
static const NSInteger paddySide = 16;
static const NSInteger paddyMid = 7;

@implementation GBPopMenuView


-(id)initWithTitles
{
    if (self == [super init]) {
        _titles = [NSMutableArray array];
    }
    return self;
}
-(void)show:(UIView*)contentView Poprect:(CGRect)rect;
{
    _isShow = YES;
    NSInteger columnCount = 3;
    NSInteger itemWidth = (GBScreen_Width - 12*3-20*2)/columnCount;
    
    UIButton *_title_button;
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rect), GBScreen_Width, GBScreen_Height)];
    _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [contentView.superview addSubview:_backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimiss_background:)];
    [_backgroundView addGestureRecognizer:tap];
    
    CGRect frame = CGRectMake(GBScreen_Width-27, 0, 10, 6);
    GBIndicatorView *indicator = [[GBIndicatorView alloc]initWithFrame:frame];
    [GBIndicatorView setIndicatorColor:[UIColor whiteColor]];
    [_backgroundView addSubview:indicator];
    
    self.frame = CGRectMake(10, 6, GBScreen_Width-20, 200);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    [_backgroundView addSubview:self];
    
    
    if (_titles.count) {
        for (int index = 0; index < _titles.count; index++) {
            NSUInteger columnIndex =  index % columnCount;//第几列
            NSUInteger rowIndex = index / columnCount;//第几行
            UIButton *title_button = [[UIButton alloc] initWithFrame:CGRectMake(columnIndex?(itemWidth+paddxMid)*columnIndex+paddxSide:paddxSide, rowIndex?(33+paddyMid)*rowIndex+paddySide:paddySide, itemWidth, 26)];
            title_button.tag = index;
            [title_button setTitle:_titles[index] forState:UIControlStateNormal];
            [title_button setTitleColor:(self.selectIndex == index)?self.selectedColor:[UIColor colorWithRed:160 / 255.0 green:160 / 255.0 blue:160 / 255.0 alpha:1.0] forState:UIControlStateNormal];
            [title_button setBackgroundColor:(self.selectIndex == index)?MainColor:[UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1.0]];
            if (self.selectIndex == index) {
                _select_button = title_button;
            }
            title_button.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
            title_button.layer.cornerRadius = 13;
            title_button.layer.masksToBounds = YES;
            [title_button addTarget:self action:@selector(select_button:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:title_button];
            _title_button = title_button;
            
        }
        self.frame =
        CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_title_button.frame)+16);
        
    }
}


-(void)select_button:(UIButton*)sender
{
    if (self.selectIndex != sender.tag) {
        [_select_button setTitleColor:self.noSlectedColor forState:UIControlStateNormal];
        _select_button.layer.borderColor = self.noSlectedColor.CGColor;
        _select_button.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1.0];
        [sender setTitleColor:self.selectedColor  forState:UIControlStateNormal];
        sender.backgroundColor = MainColor;
        if (self.didSelectItemIndex) {
            self.didSelectItemIndex(sender.tag);
        }
    }
    _select_button = sender;
}


-(void)dimiss_background:(UITapGestureRecognizer*)tap
{
    [self dismiss];
    if (self.dismissPopView) {
        self.dismissPopView();
    }
}


-(void)dismiss
{
    _isShow = NO;
    [_backgroundView removeFromSuperview];
    _backgroundView = nil;
    [self removeFromSuperview];
}

@end
