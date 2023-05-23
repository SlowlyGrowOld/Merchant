//
//  SRXOrdersRemarkVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrdersRemarkVC.h"
#import "NetworkManager+Order.h"

@interface SRXOrdersRemarkVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet YYTextView *textView;

@end

@implementation SRXOrdersRemarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (IBAction)cancelBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtnClick:(id)sender {
    if (self.textView.text.stringByTrim.length==0) {
        [SVProgressHUD showInfoWithStatus:@"请输入订单备注"];
        return;
    }
    [NetworkManager addOrderRemarkWithOrderID:self.model.order_id admin_note:self.textView.text success:^(NSString *message) {
        self.model.admin_note = self.textView.text;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                KPostNotificationInfo(KNotificationOrderStatusChange, nil, self.model);
            }];
        });
    } failure:^(NSString *message) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.allObjects.lastObject;
    BOOL isRuselt = [touch.view isDescendantOfView:self.contentView];
    if (!isRuselt) {
        [self.view endEditing:YES];
    }
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    //NSLog(@"keyboardWillShow:%@",notification);
 
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    CGRect rect = [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
 
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -(kScreenHeight/2.0+85-rect.origin.y));
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    //NSLog(@"keyboardWillHide:%@",notification);
 
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
 
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

@end
