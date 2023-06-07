//
//  SRXCalendarPickerView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/7.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MonthModel;
NS_ASSUME_NONNULL_BEGIN

@interface SRXCalendarPickerView : UIView
@property (copy, nonatomic) NSString *lastTime;
@property (copy, nonatomic) NSString *nextTime;
- (void)initStartTime:(NSString *)startTime endTime:(NSString *)endTime;
- (void)reset;
@end

//CollectionViewHeader
@interface CalendarHeaderView : UICollectionReusableView
@end

//UICollectionViewCell
@interface CalendarCell : UICollectionViewCell
@property (weak, nonatomic) UILabel *dayLabel;
@property (weak, nonatomic) UIView *bgView;

@property (strong, nonatomic) MonthModel *monthModel;
@end

//存储模型
@interface MonthModel : NSObject
@property (assign, nonatomic) NSInteger dayValue;
@property (strong, nonatomic) NSDate *dateValue;
@property (assign, nonatomic) BOOL isSelectedDay;
@property (assign, nonatomic) NSInteger isLocation;//-1开始时间,0中间时间,1结束时间，2开始结束同一天

@end
NS_ASSUME_NONNULL_END
