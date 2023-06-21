//
//  SRXGoodsEvaluateListModel.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/30.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXGoodsEvaluateListModel.h"


@implementation SRXGELEvaluate_defaultItem

@end

@implementation SRXGELEvaluate_count_arr

@end

@implementation SRXGELAdditional

@end

@implementation SRXGELDataItem
- (CGFloat)imageHeight {
    if (_imageHeight == 0.0) {
        _imageHeight = 1;
        if (self.video_url.length>0) {
            _imageHeight = (kScreenWidth - 40 - 16)/3*2 + 8;
        }else if (self.images.count == 1) {
            _imageHeight = (kScreenWidth - 40 - 16)/3*2;
        }else if (self.images.count == 2) {
            _imageHeight = (kScreenWidth - 40 - 8)/2;
        }else if (self.images.count == 3) {
            _imageHeight = (kScreenWidth - 40 - 16)/3;
        }else if (self.images.count >= 4) {
            _imageHeight = (kScreenWidth - 40 - 16)/3*2 + 8;
        }
    }
    return _imageHeight;
}
@end

@implementation SRXGoodsEvaluateListModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"data":@"SRXGELDataItem",
        @"evaluate_default":@"SRXGELEvaluate_defaultItem",
        
    };
}

@end
