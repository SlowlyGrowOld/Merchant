//
//  SRXSpecModel.m
//  ShiRongXinMarketMallProject
//
//  Created by Alucardulad on 2/12/20.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXSpecModel.h"
@implementation SRXSpecModel
+(NSDictionary *)mj_objectClassInArray {
    return @{
        @"spec_value":@"SRXSpecValueModel",
    };
}
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    if (self) {
        
        if ([[dic allKeys] containsObject:@"spec_value"])
          {
              NSMutableArray *tempAry = [NSMutableArray array];
              for (NSDictionary *tempdic in dic[@"spec_value"])
              {
                  SRXSpecValueModel *mo = [[SRXSpecValueModel alloc] initWithDic:tempdic];
                  [tempAry addObject:mo];
              }
              self.spec_value = tempAry;
          }
    }
    return self;
}

@end
