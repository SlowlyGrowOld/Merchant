//
//  SRXResultModel.h
//  ShiRongXinMarketMallProject
//
//  Created by Alucardulad on 1/21/20.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRXResultModel : SRXBaseModel
@property (strong, nonatomic) NSNumber *code;
@property (strong, nonatomic) NSString *msg;
@end

NS_ASSUME_NONNULL_END
