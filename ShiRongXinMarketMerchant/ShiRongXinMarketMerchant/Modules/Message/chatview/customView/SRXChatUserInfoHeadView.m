//
//  SRXChatUserInfoHeadView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/19.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatUserInfoHeadView.h"
#import "UIColor+JHExt.h"

@interface SRXChatUserInfoHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *wait_sendLb;
@property (weak, nonatomic) IBOutlet UILabel *wait_payLb;
@property (weak, nonatomic) IBOutlet UILabel *wait_evalLb;
@property (weak, nonatomic) IBOutlet UIButton *oneTagBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoTagBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeTagBtn;

@end

@implementation SRXChatUserInfoHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.oneTagBtn setImagePosition:LXMImagePositionLeft spacing:4];
    [self.twoTagBtn setImagePosition:LXMImagePositionLeft spacing:4];
    [self.threeTagBtn setImagePosition:LXMImagePositionLeft spacing:4];
}

- (void)setOther:(SRXMsgChatOther *)other {
    _other = other;
    _wait_sendLb.text = [NSString stringWithFormat:@"待发货（%zd）",other.order_num.to_be_delivery_num];
    _wait_payLb.text = [NSString stringWithFormat:@"待付款（%zd）",other.order_num.to_be_pay_num];
    _wait_evalLb.text = [NSString stringWithFormat:@"待评价（%zd）",other.order_num.to_be_evaluate_num];
    
    if (other.user_labels.count>2) {
        self.oneTagBtn.hidden = NO;
        self.twoTagBtn.hidden = NO;
        self.threeTagBtn.hidden = NO;
        SRXMsgLabelsItem *item = other.user_labels[0];
        [self setLableBtnWithBtn:self.oneTagBtn item:item];
        SRXMsgLabelsItem *item1 = other.user_labels[1];
        [self setLableBtnWithBtn:self.twoTagBtn item:item1];
        SRXMsgLabelsItem *item2 = other.user_labels[2];
        [self setLableBtnWithBtn:self.threeTagBtn item:item2];
    } else if (other.user_labels.count==2) {
        self.oneTagBtn.hidden = NO;
        self.twoTagBtn.hidden = NO;
        self.threeTagBtn.hidden = YES;
        SRXMsgLabelsItem *item = other.user_labels[0];
        [self setLableBtnWithBtn:self.oneTagBtn item:item];
        SRXMsgLabelsItem *item1 = other.user_labels[1];
        [self setLableBtnWithBtn:self.twoTagBtn item:item1];
    } else if (other.user_labels.count==1) {
        self.oneTagBtn.hidden = NO;
        self.twoTagBtn.hidden = YES;
        self.threeTagBtn.hidden = YES;
        SRXMsgLabelsItem *item = other.user_labels[0];
        [self setLableBtnWithBtn:self.oneTagBtn item:item];
    } else{
        self.oneTagBtn.hidden = YES;
        self.twoTagBtn.hidden = YES;
        self.threeTagBtn.hidden = YES;
    }
}

- (void)setLableBtnWithBtn:(UIButton *)btn item:(SRXMsgLabelsItem *)item {
    [btn setTitle:item.label_name forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"star_yellow"];
    [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [btn.imageView setTintColor:[UIColor colorWithHexString:item.label_color_number alpha:1]];
}

@end
