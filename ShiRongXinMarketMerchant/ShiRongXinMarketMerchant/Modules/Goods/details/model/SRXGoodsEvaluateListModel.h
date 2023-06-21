//
//  SRXGoodsEvaluateListModel.h
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/30.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface SRXGELEvaluate_defaultItem :SRXBaseModel
@property (nonatomic , assign) NSInteger              _id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , assign) NSInteger              e_num;

@property (nonatomic , assign) BOOL              is_select;
@end


@interface SRXGELEvaluate_count_arr :NSObject
@property (nonatomic , assign) NSInteger              evaluate_count;
@property (nonatomic , assign) NSInteger              good_rate_count;
@property (nonatomic , assign) NSInteger              good_rate_num;
@property (nonatomic , assign) NSInteger              bad_rate_count;
@property (nonatomic , assign) NSInteger              image_video_count;
@property (nonatomic , assign) NSInteger              evaluate_review_count;

@end


@interface SRXGELAdditional :NSObject
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * create_time;

@end


@interface SRXGELDataItem :NSObject
@property (nonatomic , assign) NSInteger              comment_id;
@property (nonatomic , assign) NSInteger              goods_start;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , strong) NSArray <NSString *>              * images;
@property (nonatomic , copy) NSString              * video_url;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * evaluate_default_id;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , assign) NSInteger              is_recommended;
@property (nonatomic , copy) NSString              * identity_name;
@property (nonatomic , copy) NSString              * shop_reply;
@property (nonatomic , strong) SRXGELAdditional              * additional;
@property (nonatomic , assign) CGFloat             imageHeight;
@end

@interface SRXGoodsEvaluateListModel : NSObject
@property (nonatomic , strong) NSArray <SRXGELEvaluate_defaultItem *>              * evaluate_default;
@property (nonatomic , strong) SRXGELEvaluate_count_arr              * evaluate_count_arr;
@property (nonatomic , strong) NSArray <SRXGELDataItem *>              * data;
@property (nonatomic , strong) NSArray <NSString *>              * show_images;
@end

NS_ASSUME_NONNULL_END
