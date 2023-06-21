//
//  SRXSpecModel.h
//  ShiRongXinMarketMallProject
//
//  Created by Alucardulad on 2/12/20.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXBaseModel.h"
#import "SRXSpecValueModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SRXSpecModel : SRXBaseModel
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray <SRXSpecValueModel *> *spec_value ;
- (id)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
