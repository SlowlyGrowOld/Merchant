//
//  SRXChangeNicknameVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXTextFieldAlertVC.h"
#import "NetworkManager+Me.h"

@interface SRXTextFieldAlertVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewConsY;

@end

@implementation SRXTextFieldAlertVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.textField.placeholder = self.placeholder;
    self.textField.text = self.default_text;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

- (IBAction)cancelBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtnClick:(id)sender {
    if (self.textField.text.stringByTrim.length==0) {
        [SVProgressHUD showInfoWithStatus:self.placeholder];
        return;
    }
    if(self.block){self.block(self.textField.text);}
    [self dismissViewControllerAnimated:YES completion:nil];
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
    CGFloat offsetY = 0.0;
    if ((kScreenHeight/2.0+70-rect.origin.y)>=0) {
        offsetY = kScreenHeight/2.0+72-rect.origin.y;
    }else {
        offsetY = 0;
    }
    [UIView animateWithDuration:duration animations:^{
//        self.view.transform = CGAffineTransformMakeTranslation(0, -offsetY);
        self.contentViewConsY.constant = -offsetY;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    //NSLog(@"keyboardWillHide:%@",notification);
 
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
 
    [UIView animateWithDuration:duration animations:^{
//        self.view.transform = CGAffineTransformIdentity;
        self.contentViewConsY.constant = 0;
    }];
}

@end
