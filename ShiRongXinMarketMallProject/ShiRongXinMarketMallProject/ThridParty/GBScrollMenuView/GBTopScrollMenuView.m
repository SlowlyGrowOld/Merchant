//
//  GBTopScrollMenuView.m
//  WJMenu
//
//  Created by mac on 2016/12/2.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "GBTopScrollMenuView.h"
#import "GBPopMenuView.h"

#define GBSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define GBSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define GBARROW_BUTTON_WIDTH 44

@interface GBTopScrollMenuView()
//滚动视图
@property(strong,nonatomic)UIScrollView *myScrollView;
//滚动下划线
@property(strong,nonatomic)UIView *line;
//所有的Button集合
@property(nonatomic,strong)NSMutableArray  *items;
//所有的Button的宽度集合
@property(nonatomic,copy)NSArray *itemsWidth;
//被选中前面的宽度合（用于计算是否进行超过一屏，没有一屏则进行平分）
@property(nonatomic,assign)CGFloat selectedTitlesWidth;
//滚动视图的宽
@property(nonatomic,assign)CGFloat navigationTabBarWidth;
//是否显示右边更多的Button
@property(nonatomic,assign)BOOL showArrayButton;
@property(nonatomic,strong)GBPopMenuView *PopupView;

@end


@implementation GBTopScrollMenuView

- (instancetype)initWithFrame:(CGRect)frame showPopViewWithMoreButton:(BOOL)isHavePopView
{
    if (self = [super initWithFrame:frame]) {
        _showArrayButton = isHavePopView;
        [self loadDataAndView];
    }
    return self;
}
-(void)loadDataAndView
{
    //初始化数组
    self.items=[[NSMutableArray alloc]init];
    self.itemsWidth=[[NSArray alloc]init];
    
    self.selectedColor=[UIColor whiteColor];
    self.noSlectedColor=[UIColor blackColor];
    self.LineColor=[UIColor blueColor];
    
    self.titleFont=[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    
    _navigationTabBarWidth = _showArrayButton ? self.bounds.size.width - GBARROW_BUTTON_WIDTH : self.bounds.size.width;
    
    CGRect myScrollViewRect=self.bounds;
    myScrollViewRect.size.width=_navigationTabBarWidth;
    
    //初始化滚动
    if (!self.myScrollView) {
        self.myScrollView=[[UIScrollView alloc]initWithFrame:myScrollViewRect];
        self.myScrollView.backgroundColor=self.backgroundColor;
        self.myScrollView.showsHorizontalScrollIndicator = NO;
        self.myScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.myScrollView];
    }
    if (_showArrayButton) {
        UIButton *arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        arrowButton.frame = CGRectMake(_navigationTabBarWidth, 0, GBARROW_BUTTON_WIDTH, self.bounds.size.height);
        arrowButton.backgroundColor = self.backgroundColor;
        [arrowButton setImage:[UIImage imageNamed:@"路径 43716"] forState:UIControlStateNormal];
        [arrowButton addTarget:self action:@selector(arrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:arrowButton];
        UIView *lineView= [[UIView alloc]initWithFrame:CGRectMake(_navigationTabBarWidth, 0, 1, self.bounds.size.height)];
        lineView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1.0];
        [self addSubview:lineView];
    }
}

#pragma mark -- 计算宽度
- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    _selectedTitlesWidth = 0;
    for (NSString *title in titles)
    {
        CGSize size = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleFont} context:nil].size;
        CGFloat eachButtonWidth = size.width + 32.f;
        _selectedTitlesWidth += eachButtonWidth;
        NSNumber *width = [NSNumber numberWithFloat:eachButtonWidth];
        [widths addObject:width];
    }
    if (_selectedTitlesWidth < self.navigationTabBarWidth) {
        [widths removeAllObjects];
        NSNumber *width = [NSNumber numberWithFloat:self.navigationTabBarWidth/ titles.count];
        for (int index = 0; index < titles.count; index++) {
            [widths addObject:width];
        }
    }
    return widths;
}
#pragma mark -- 初始化Button
- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    [self cleanData];
    CGFloat buttonX = 0;
    for (NSInteger index = 0; index < widths.count; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = (self.bounds.size.height-18)/2;
        button.frame = CGRectMake(buttonX+20, 9, [widths[index] floatValue], self.bounds.size.height-18);
        button.titleLabel.font = self.titleFont;
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:self.myTitleArray[index] forState:UIControlStateNormal];
        [button setTitleColor:self.noSlectedColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myScrollView addSubview:button];
        [_items addObject:button];
        buttonX =buttonX + [widths[index] floatValue]+20;
    }

    return buttonX;
}
#pragma mark -- 设置当前选中按钮
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (_items.count>0) {
        if (currentIndex==_currentIndex&&currentIndex!=0) {
            return;
        }
        else {
            UIButton *btn = _items[_currentIndex];
            [btn setTitleColor:self.noSlectedColor forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
        }
        _currentIndex = currentIndex;
        UIButton *button = nil;
        button = _items[currentIndex];
        [button setTitleColor:self.selectedColor forState:UIControlStateNormal];
        [button setBackgroundColor:MainColor];
        CGFloat offsetX;
        if (button.center.x<self.navigationTabBarWidth * 0.5) {
            offsetX = 0;
        }
        else {
            offsetX = button.center.x-self.navigationTabBarWidth * 0.5;
        }
        [self.myScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

-(void)setMyTitleArray:(NSArray *)myTitleArray
{
    _myTitleArray=myTitleArray;
    _itemsWidth = [self getButtonsWidthWithTitles:myTitleArray];
    CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth]+20;
    self.myScrollView.contentSize = CGSizeMake(contentWidth, 0);
}

- (void)cleanData
{
    [_items removeAllObjects];
    [self.myScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

#pragma mark -- 选中时的点击事件
- (void)itemPressed:(UIButton *)button
{
    NSInteger index = [_items indexOfObject:button];
    [self currentSelectedIndex:index];
}

-(void)currentSelectedIndex:(NSInteger)index
{
    self.currentIndex=index;

    if (self.ItemDidSelectAtIndex) {
        self.ItemDidSelectAtIndex(index);
    }
    //修改选中跟没选中的Button字体颜色
    for (int i=0; i<_items.count; i++) {
        [_items[i] setTitleColor:(i==index)?self.selectedColor:self.noSlectedColor forState:UIControlStateNormal];
    }
    
    //如果有弹出窗就进行关闭
    if (_PopupView) {
        [_PopupView dismiss];
        _PopupView = nil;
    }
}


- (void)arrowBtnClick:(UIButton *)button
{
    __typeof(self)weakSelf=self;
    CGRect rc =self.frame;
    if (!_PopupView) {
        _PopupView = [[GBPopMenuView alloc]initWithTitles];
        _PopupView.titles = self.myTitleArray;
        _PopupView.selectIndex = self.currentIndex;
        _PopupView.selectedColor=self.selectedColor;
        _PopupView.noSlectedColor=self.noSlectedColor;
        _PopupView.didSelectItemIndex = ^(NSInteger index){
        
            [weakSelf currentSelectedIndex:index];
            [weakSelf.PopupView dismiss];
            weakSelf.PopupView = nil;
        };
        [_PopupView show:self Poprect:rc];
    }
    else
    {
        [_PopupView dismiss];
        _PopupView = nil;
    }
}

-(void)dimiss_popUp
{
    [_PopupView dismiss];
    _PopupView = nil;
}
@end
