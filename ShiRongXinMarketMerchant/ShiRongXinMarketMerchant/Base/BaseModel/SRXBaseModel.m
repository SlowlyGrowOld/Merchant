//
//  SRXBaseModel.m
//  ShiRongXinMarketMerchant
//
//  Created by Alucardulad on 1/21/20.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXBaseModel.h"

@implementation SRXBaseModel


- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        NSString *stringClass = NSStringFromClass(self.class);
        self = [NSClassFromString(stringClass) mj_objectWithKeyValues:dic];
    }
    return self;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"_id" : @"id"};
}
@end
