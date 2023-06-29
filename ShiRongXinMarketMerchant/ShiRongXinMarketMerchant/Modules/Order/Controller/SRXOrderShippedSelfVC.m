//
//  SRXOrderShippedSelfVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/22.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderShippedSelfVC.h"
#import "NetworkManager+Order.h"

@interface SRXOrderShippedSelfVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation SRXOrderShippedSelfVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isBgClose = YES;
    [self.contentView settingRadius:20 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
}

- (IBAction)cancleBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sureBtnClick:(id)sender {
    [NetworkManager sendGoodsBySelfLiftingWithID:self.order_id shop_id:self.shop_id success:^(NSString *message) {
        [SVProgressHUD showSuccessWithStatus:@"发货成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(self.closeBlock){self.closeBlock();}
            KPostNotificationInfo(KNotificationOrderStatusChange, nil, @"refresh");
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    } failure:^(NSString *message) {
        
    }];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = touches.allObjects.lastObject;
//    BOOL isRuselt = [touch.view isDescendantOfView:self.bgView];
//    if (!isRuselt) {
//        [self.view endEditing:YES];
//    }
//}

@end
