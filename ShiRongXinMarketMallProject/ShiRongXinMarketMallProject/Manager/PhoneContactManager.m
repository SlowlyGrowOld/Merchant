//
//  PhoneContactManager.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2023/2/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "PhoneContactManager.h"

#import <ContactsUI/ContactsUI.h> // I框架：提供了联系人列表界面、联系人详情界面、添加联系人界面等，一般用于选择联系人。

@interface PhoneContactManager () <CNContactPickerDelegate>

@end

@implementation PhoneContactManager

+ (instancetype)shareInstance {
    
    static PhoneContactManager *phoneContactManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        phoneContactManager = [[self alloc]init];
    });
    return phoneContactManager;
}

/** 1、判断：是否拥有读取通讯录权限 */
- (void)getCheckAddressBookAuthorization:(AddressBookAuthorizationBlock)addressBookAuthorizationBlock {
    
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];

    /*! 用户尚未就应用程序是否可以访问联系人数据做出选择。 */
    if (status == CNAuthorizationStatusNotDetermined) { // 未授权，待授权
        
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            // 第一次获取权限判断，点击 “不允许”，则 granted = NO， 点击 “好”，则 granted = YES
            
            if (granted) {
                addressBookAuthorizationBlock(granted);
            } else {
                return; // 第一次访问时，如果点击“不允许”，则不做任何操作。
            }
            
            if (error) {
                
            } else {
            }
        }];
        
    } else if (status == CNAuthorizationStatusRestricted) { //
        /*! 该应用程序没有权限访问联系人数据。
 *用户无法更改此应用程序的状态，可能是由于主动限制（如父母控制到位）。 */
        addressBookAuthorizationBlock(NO);
        
    } else if (status == CNAuthorizationStatusDenied) { // 已拒绝授权
        /*! 用户明确拒绝对应用程序的联系人数据的访问。 */
        addressBookAuthorizationBlock(NO);
        
    } else if (status == CNAuthorizationStatusAuthorized) { // 已授权
        /*! 该应用程序被授权访问联系人数据。 */
        addressBookAuthorizationBlock(YES);
    }
    
}



/** 2、读取：通讯录（调起通讯录列表页） */
- (void)presentAddressBookReadFinishWithPhoneNumber:(AddressBookPhoneNumberBlock)addressBookPhoneNumberBlock {
    
    [self getCheckAddressBookAuthorization:^(BOOL isAuthorization) {
        if (isAuthorization) {
            // 已授权
            [[PhoneContactManager shareInstance] presentAddressBookCNContactPickerViewControllerWithNumber:addressBookPhoneNumberBlock];
        } else {
            // 未授权
            [[PhoneContactManager shareInstance] alertMessage];
        }
    }];
}

// 弹出通讯录
- (void)presentAddressBookCNContactPickerViewControllerWithNumber:(AddressBookPhoneNumberBlock)addressBookPhoneNumberBlock {
    
    [PhoneContactManager shareInstance].phoneNumberBlock = addressBookPhoneNumberBlock;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // CNContactPickerViewController 只能在主线程中使用：
        CNContactPickerViewController *pickerVC = [[CNContactPickerViewController alloc] init];
        pickerVC.delegate = self;
        pickerVC.displayedPropertyKeys = @[CNContactPhoneNumbersKey]; // 只显示手机号
        pickerVC.modalPresentationStyle = 0;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pickerVC animated:YES completion:nil];
    });

}

#pragma mark -- <CNContactPickerDelegate> 代理方法回调

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    
    // 注意：这里和displayedPropertyKeys属性设置相对应；只有 CNPhoneNumber 类型，如果添加别的类型，需要加类型判断，否则可能crash；例如：通讯录中的日期、邮箱...
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString *phoneStr = phoneNumber.stringValue;
    //回调block，把号码带回去
    if (self.phoneNumberBlock) {
        self.phoneNumberBlock(phoneStr);
    }
    
}


// 弹出提示信息
-(void)alertMessage {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请授权通讯录权限" message:@"请在\"设置-隐私-通讯录\"选项中，允许云间高尔夫访问您的通讯录" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"允许" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
        }];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:action];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}
@end
