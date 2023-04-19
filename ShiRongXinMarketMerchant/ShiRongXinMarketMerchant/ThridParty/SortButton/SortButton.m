//
//  SortButton.m
//  ShiRongXinMarketMerchant
//
//  Created by 别天神 on 2021/9/4.
//  Copyright © 2021 Alucardulad. All rights reserved.
//

#import "SortButton.h"

@interface SortButton()

@property (nonatomic, strong) UILabel *btnTitle;

@end

@implementation SortButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
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
    
    UIView *backView = [[UIView alloc] init];
    backView.frame = self.bounds;
    [self addSubview:backView];
    backView.layer.cornerRadius = 2;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = UIColorHex(#F6F6F6);
    
    self.btnTitle = [[UILabel alloc] init];
    [backView addSubview:self.btnTitle];
    [self.btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(15);
        make.top.bottom.right.equalTo(backView);
    }];
    self.btnTitle.textColor = UIColorHex(#666666);
    self.btnTitle.font = SYSTEMFONT(12);
    
    UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backView addSubview:sortBtn];
    [sortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(backView);
    }];
    [sortBtn setImage:[UIImage imageNamed:@"组 20229"] forState:UIControlStateNormal];
    [sortBtn setImage:[UIImage imageNamed:@"组 20229-1"] forState:UIControlStateSelected];
    sortBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    sortBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 12);
    @weakify(self);
    [sortBtn jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        @strongify(self);
        sortBtn.selected = !sortBtn.selected;
        if (self.sortBlock) {
            self.sortBlock(sortBtn.selected);
        }
        NSLog(@"排序方式：%@",sortBtn.selected ? @"UP":@"DOWN");
    }];
    
}


-(void)setButtonTitle:(NSString *)buttonTitle {
    self.btnTitle.text = buttonTitle;
}

@end
