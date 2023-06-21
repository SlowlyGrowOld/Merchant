//
//  SRXSpecValueModel.h
//  ShiRongXinMarketMallProject
//
//  Created by Alucardulad on 2/12/20.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXSpecValueModel : SRXBaseModel
@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *value;
@property (assign, nonatomic) BOOL isDisabled;

- (id)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
