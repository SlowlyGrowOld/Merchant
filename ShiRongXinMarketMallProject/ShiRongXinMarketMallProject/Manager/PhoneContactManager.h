//
//  PhoneContactManager.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2023/2/9.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhoneContactManager : NSObject
/** 判断 是否授权访问通讯录：YES 已授权，NO 未授权 */
typedef void(^AddressBookAuthorizationBlock)(BOOL isAuthorization);
//@property (nonatomic, copy) void (^judgeAuthorizationBlock)(BOOL isAuthorization);

/** 获取通讯录 选择的联系人 联系方式(手机号码)：contactNumber */
typedef void(^AddressBookPhoneNumberBlock)(NSString *contactNumber);
//@property (nonatomic, copy) void (^gainContactsNumberBlock)(NSString *contactNumber);
@property (nonatomic, copy) AddressBookPhoneNumberBlock phoneNumberBlock;



+ (instancetype)shareInstance;


/** 判断：是否拥有读取通讯录权限 */
- (void)getCheckAddressBookAuthorization:(AddressBookAuthorizationBlock)addressBookAuthorizationBlock;
/** 读取：通讯录（调起通讯录列表页） */
- (void)presentAddressBookReadFinishWithPhoneNumber:(AddressBookPhoneNumberBlock)addressBookPhoneNumberBlock;
// 打开通讯录
//- (void)presentAddressBookCNContactPickerViewControllerWithNumber:(AddressBookPhoneNumberBlock)addressBookPhoneNumberBlock

@end

NS_ASSUME_NONNULL_END
