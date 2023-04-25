//
//  SRXLoginModel.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/25.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXLoginModel : SRXBaseModel
@property (nonatomic , copy) NSString              * _id;
@property (nonatomic , copy) NSString              * shop_id;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , assign) NSInteger              shops_num;
@property (nonatomic , copy) NSString              * access_token;
@end

NS_ASSUME_NONNULL_END
