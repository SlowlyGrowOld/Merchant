//
//  NSString+YCExt.h
//  Yacht
//
//  Created by Robin on 2019/3/17.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JHExt)

- (BOOL)isExist;
- (NSString *)isNull;
+ (NSString *)stringWithNumber:(NSNumber *)number formatter:(NSString *)format;
#pragma mark - 移除中文
+ (NSString *)deleteChineseStringWithString:(NSString *)string;

- (BOOL)isOnlyAlphaNumeric;

@end

NS_ASSUME_NONNULL_END
