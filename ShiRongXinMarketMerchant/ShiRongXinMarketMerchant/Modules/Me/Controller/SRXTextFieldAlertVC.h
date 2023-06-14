//
//  SRXChangeNicknameVC.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/24.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "RootPresentViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SRXTextFieldAlertBlock)(NSString *nickname);
@interface SRXTextFieldAlertVC : RootPresentViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *default_text;
@property (nonatomic, copy) SRXTextFieldAlertBlock block;
@end

NS_ASSUME_NONNULL_END
