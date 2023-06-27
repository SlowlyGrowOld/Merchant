//
//  SRXSearchView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXSearchView.h"

@interface SRXSearchView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UITextField *searchTF;
@end

@implementation SRXSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.backgroundColor = CViewBgColor;
    [self addSubview:self.searchView];
    [self.searchView addSubview:self.searchTF];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchTF endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.searchBlock) {
        self.searchBlock(textField.text);
    }
}

- (void)setPlaceholder_text:(NSString *)placeholder_text {
    _placeholder_text = placeholder_text;
    _searchTF.placeholder =_placeholder_text;
}

- (UIView *)searchView {
    if (!_searchView) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(15, (self.jk_height-30)/2, kScreenWidth - 30, 30)];
        _searchView.backgroundColor = UIColor.whiteColor;//UIColorHex(0xF1F1F1);
        _searchView.layer.cornerRadius = 15;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 8, 14, 14)];
        imgView.image = [UIImage imageNamed:@"textfield_search"];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [_searchView addSubview:imgView];
    }
    return _searchView;
}

- (UITextField *)searchTF {
    if (!_searchTF) {
        _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(33, 0, kScreenWidth - 30 - 50, 30)];
        _searchTF.placeholder = @"请输入商品信息";
        _searchTF.font = [UIFont systemFontOfSize:14];
        _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTF.returnKeyType = UIReturnKeySearch;
        _searchTF.delegate = self;
    }
    return _searchTF;
}

@end
