//
//  UserAccount.m
//  ZFTParking
//
//  Created by 薛静鹏 on 2018/4/4.
//  Copyright © 2018年 薛静鹏. All rights reserved.
//

#import "UserAccount.h"

@implementation UserAccount

+ (instancetype)sharedAccount {
    static UserAccount *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[UserAccount alloc] init];
        
    });
    
    return _sharedClient;
}
- (void)setUserInfo:(NSDictionary *)data{
    self.account = data[@"account"];
}

- (void)saveAccount:(NSString *)account Password:(NSString *)pwd{
    [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"account"];
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"pwd"];
    [[NSUserDefaults standardUserDefaults] setObject:@2 forKey:@"login_status"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *saved_account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    NSLog(@"save:%@",saved_account);
}

- (NSString *)getSavedAccount{
    NSString *saved_account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    return saved_account;
}

- (NSString *)getSavedPassword{
    NSString *saved_password = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
    return saved_password;
}
-(int)isOutLogin{
    NSNumber *status = [[NSUserDefaults standardUserDefaults] objectForKey:@"login_status"];
    if (status.intValue == 2) {
        return 2;
    }
    else{
        return 1;
    }
}
@end
