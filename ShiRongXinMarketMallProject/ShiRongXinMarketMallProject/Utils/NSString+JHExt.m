//
//  NSString+Exist.m
//  Yacht
//
//  Created by Robin on 2019/3/17.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "NSString+JHExt.h"

@implementation NSString (JHExt)

- (BOOL)isExist {
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return (str.length != 0);
}

- (NSString *)isNull {
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str.length != 0?str:@"";
}

+ (NSString *)stringWithNumber:(NSNumber *)number formatter:(NSString *)format {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.positiveFormat = format;
    NSString *str = [formatter stringFromNumber:number];
    if ([str containsString:@".00"]) {
        str = [str stringByReplacingOccurrencesOfString:@".00" withString:@""];
    }
    return str;
}

#pragma mark - 移除中文
+ (NSString *)deleteChineseStringWithString:(NSString *)string {
    for (int i=0; i < string.length; i++) {
        int utfCode = 0;
        void *buffer = &utfCode;
        NSRange range = NSMakeRange(i, 1);
        BOOL b = [string getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
        if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5)) {
            string = [string stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    return string;
}

- (BOOL)isOnlyAlphaNumeric{
    
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}
@end
