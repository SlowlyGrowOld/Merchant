//
//  SRXMsgChatQuoteView.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2023/3/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXMsgChatQuoteView.h"

@interface SRXMsgChatQuoteView ()
@property (weak, nonatomic) IBOutlet UITextView *quoteTV;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *bg1View;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quoteTVConsH;

@end

@implementation SRXMsgChatQuoteView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.quoteTV.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
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

- (void)setQuote:(NSString *)quote {
    _quote = quote;
    self.quoteTV.text = quote;
    CGSize size = [self getSizeWithAtt:self.quoteTV.attributedText maxSize:CGSizeMake(kScreenWidth - 132, kScreenHeight - 300)];
    self.quoteTVConsH.constant = size.height+10;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
    UITouch *touch = [touches.allObjects lastObject];
    BOOL result = [touch.view isDescendantOfView:self.quoteTV];
    if (!result) {
        [self dismiss];
    } else {
        
    }
}


@end
