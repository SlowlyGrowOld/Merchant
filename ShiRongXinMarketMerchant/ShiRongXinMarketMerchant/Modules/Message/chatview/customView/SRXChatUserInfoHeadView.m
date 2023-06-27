//
//  SRXChatUserInfoHeadView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/19.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatUserInfoHeadView.h"
#import "UIColor+JHExt.h"
#import "JYBubbleMenuView.h"
#import "JYBubbleButtonModel.h"
#import "NetworkManager+Message.h"

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
    
    [self congifLabels];
}

- (void)congifLabels {
    if (self.other.user_labels.count>2) {
        self.oneTagBtn.hidden = NO;
        self.twoTagBtn.hidden = NO;
        self.threeTagBtn.hidden = NO;
        SRXMsgLabelsItem *item = self.other.user_labels[0];
        [self setLableBtnWithBtn:self.oneTagBtn item:item];
        SRXMsgLabelsItem *item1 = self.other.user_labels[1];
        [self setLableBtnWithBtn:self.twoTagBtn item:item1];
        SRXMsgLabelsItem *item2 = self.other.user_labels[2];
        [self setLableBtnWithBtn:self.threeTagBtn item:item2];
    } else if (self.other.user_labels.count==2) {
        self.oneTagBtn.hidden = NO;
        self.twoTagBtn.hidden = NO;
        self.threeTagBtn.hidden = YES;
        SRXMsgLabelsItem *item = self.other.user_labels[0];
        [self setLableBtnWithBtn:self.oneTagBtn item:item];
        SRXMsgLabelsItem *item1 = self.other.user_labels[1];
        [self setLableBtnWithBtn:self.twoTagBtn item:item1];
    } else if (self.other.user_labels.count==1) {
        self.oneTagBtn.hidden = NO;
        self.twoTagBtn.hidden = YES;
        self.threeTagBtn.hidden = YES;
        SRXMsgLabelsItem *item = self.other.user_labels[0];
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

- (IBAction)tagBtnClick:(UIButton *)sender {
    JYBubbleButtonModel *model = [[JYBubbleButtonModel alloc] init];
    model.imageName = @"msg_bubble_delete";
    model.name = @"删除";
    CGFloat width = (kScreenWidth-50)*1.0/self.other.user_labels.count + 10;
    CGRect tempRect = [self convertRect:CGRectMake(15+width*sender.tag, sender.jk_y+25, width-10, 22) toView:((AppDelegate*)([UIApplication sharedApplication].delegate)).window];
    CGRect cursorStartRectToWindow = [self convertRect:sender.frame toView:((AppDelegate*)([UIApplication sharedApplication].delegate)).window];
    [[JYBubbleMenuView shareMenuView] showViewWithButtonModels:@[model] cursorStartRect:cursorStartRectToWindow selectionTextRectInWindow:tempRect selectBlock:^(NSString * _Nonnull selectTitle) {
        SRXMsgLabelsItem *item = self.other.user_labels[sender.tag];
        [NetworkManager removeChatUserLabelWithUser_id:self.user_id label_id:item.label_id shop_id:self.shop_id success:^(NSString *message) {
            NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.other.user_labels];
            [mArr removeObject:item];
            self.other.user_labels = mArr.copy;
            [self congifLabels];
            if (self.other.user_labels.count == 0 && self.refreshBlock) {
                self.refreshBlock();
            }
        } failure:^(NSString *message) {
            
        }];
        [JYBubbleMenuView.shareMenuView removeFromSuperview];
    }];
}

@end
