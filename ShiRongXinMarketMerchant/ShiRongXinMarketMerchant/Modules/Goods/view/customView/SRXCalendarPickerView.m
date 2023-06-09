//
//  SRXCalendarPickerView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/7.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXCalendarPickerView.h"
#import "NSDate+Formatter.h"

@interface SRXCalendarPickerView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dayModelArray;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIButton *lastBtn;
@property (strong, nonatomic) UIButton *nextBtn;

@property (strong, nonatomic) NSDate *tempDate;
//开始时间
@property (strong, nonatomic) NSDate *lowDate;
//结束时间
@property (strong, nonatomic) NSDate *highDate;
@end

@implementation SRXCalendarPickerView

- (NSString *)lastTime {
    return self.lowDate?self.lowDate.yyyyMMddByLineWithDate:@"";
}
- (NSString *)nextTime {
    return self.highDate?self.highDate.yyyyMMddByLineWithDate:@"";
}

- (void)initStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    self.lowDate = [NSDate dateWithString:startTime withDateFormat:@"yyyy-MM-dd"];
    self.highDate = [NSDate dateWithString:endTime withDateFormat:@"yyyy-MM-dd"];
    [self congifArrayData];
    [self.collectionView reloadData];
}

- (void)reset {
    self.lowDate = nil;
    self.highDate = nil;
    [self congifArrayData];
    self.dateLabel.text = self.tempDate.yyyyMMChineseWithDate;
    [self getDataDayModel:self.tempDate];

//    [self.collectionView reloadData];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self congifUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self congifUI];
    }
    return self;
}

- (void)congifUI {
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_offset(5);
        make.height.mas_offset(40);
    }];
    [self addSubview:self.lastBtn];
    [self.lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.width.mas_offset(55);
        make.height.mas_offset(40);
        make.top.mas_offset(5);
    }];
    [self addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.width.mas_offset(55);
        make.height.mas_offset(40);
        make.top.mas_offset(5);
    }];
    [self addSubview:self.collectionView];
    self.tempDate = [NSDate date];
    self.dateLabel.text = self.tempDate.yyyyMMChineseWithDate;
    [self getDataDayModel:self.tempDate];
}

- (void)lastBtnClick {
    self.tempDate = [self getLastMonth:self.tempDate];
    self.dateLabel.text = self.tempDate.yyyyMMChineseWithDate;
    [self getDataDayModel:self.tempDate];
}

- (void)nextBtnClick {
    self.tempDate = [self getNextMonth:self.tempDate];
    self.dateLabel.text = self.tempDate.yyyyMMChineseWithDate;
    [self getDataDayModel:self.tempDate];
}

- (void)getDataDayModel:(NSDate *)date{
    NSUInteger days = [self numberOfDaysInMonth:date];
    NSInteger week = [self startDayOfWeek:date];
    self.dayModelArray = [[NSMutableArray alloc] initWithCapacity:42];
    int day = 1;
    for (int i= 1; i<days+week; i++) {
        if (i<week) {
            [self.dayModelArray addObject:@""];
        }else{
            MonthModel *mon = [MonthModel new];
            mon.dayValue = day;
            NSDate *dayDate = [self dateOfDay:day];
            mon.dateValue = dayDate;
            if ([dayDate.yyyyMMddByLineWithDate isEqualToString:[NSDate date].yyyyMMddByLineWithDate] && !self.lowDate) {
                mon.isSelectedDay = YES;
                self.lowDate = mon.dateValue;
                self.highDate = mon.dateValue;
                mon.isLocation = 2;
            }
            [self.dayModelArray addObject:mon];
            day++;
        }
    }
    [self congifArrayData];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dayModelArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCell" forIndexPath:indexPath];
    
    id mon = self.dayModelArray[indexPath.row];
    if ([mon isKindOfClass:[MonthModel class]]) {
        cell.monthModel = (MonthModel *)mon;
    }else{
        cell.monthModel = nil;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CalendarHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CalendarHeaderView" forIndexPath:indexPath];
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    id mon = self.dayModelArray[indexPath.row];
    MonthModel *monthModel = (MonthModel *)mon;
    monthModel.isSelectedDay = YES;
    if (self.lowDate) {
        if ([self.lowDate compare:monthModel.dateValue] == NSOrderedSame) {
            self.highDate = monthModel.dateValue;
            monthModel.isLocation = 2;
            [self congifArrayData];
        } else if ([self.lowDate compare:monthModel.dateValue] == NSOrderedDescending) {
            self.highDate = self.highDate?self.highDate:self.lowDate;
            self.lowDate = monthModel.dateValue;
            [self congifArrayData];
        } else if ([self.lowDate compare:monthModel.dateValue] == NSOrderedAscending &&!self.highDate){
            self.highDate = monthModel.dateValue;
            [self congifArrayData];
        } else if ([self.highDate compare:monthModel.dateValue] == NSOrderedSame){
            self.lowDate = monthModel.dateValue;
            monthModel.isLocation = 2;
            [self congifArrayData];
        } else if ([self.highDate compare:monthModel.dateValue] == NSOrderedAscending){
            self.highDate = monthModel.dateValue;
            [self congifArrayData];
        } else {
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            unsigned int unitFlags = NSCalendarUnitDay;
            NSDateComponents *low_comps = [gregorian components:unitFlags fromDate:self.lowDate  toDate:monthModel.dateValue  options:0];
            NSDateComponents *high_comps = [gregorian components:unitFlags fromDate:monthModel.dateValue  toDate:self.highDate  options:0];
            if (low_comps.day>=high_comps.day) {
                self.highDate = monthModel.dateValue;
            } else {
                self.lowDate = monthModel.dateValue;
            }
            [self congifArrayData];
        }
    } else {
        self.lowDate = monthModel.dateValue;
        monthModel.isLocation = -1;
    }
    [self.collectionView reloadData];
}

- (void)congifArrayData {
    for (MonthModel *item in self.dayModelArray) {
        if ([item isKindOfClass:[MonthModel class]]) {
            if (self.lowDate && self.highDate) {
                if ([item.dateValue compare:self.lowDate]==NSOrderedDescending && [item.dateValue compare:self.highDate]==NSOrderedAscending) {
                    item.isSelectedDay = YES;
                    item.isLocation = 0;
                }
                if ([item.dateValue compare:self.lowDate]==NSOrderedSame){
                    item.isSelectedDay = YES;
                    item.isLocation = -1;
                }
                if ([item.dateValue compare:self.highDate]==NSOrderedSame){
                    item.isSelectedDay = YES;
                    item.isLocation = 1;
                }
                if ([self.lowDate compare:self.highDate]==NSOrderedSame){
                    item.isLocation = 2;
                }
                if ([item.dateValue compare:self.lowDate]==NSOrderedAscending || [item.dateValue compare:self.highDate]==NSOrderedDescending) {
                    item.isSelectedDay = NO;
                }
            } else {
                if ([item.dateValue compare:self.lowDate]==NSOrderedSame){
                    item.isSelectedDay = YES;
                    item.isLocation = self.highDate?-1:2;
                }else {
                    item.isSelectedDay = NO;
                }
            }
        }
    }
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        NSInteger width = kRealValue(54);
        NSInteger height = kRealValue(44);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 30);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, width * 7, kRealValue(44)*6 + 30) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"CalendarCell"];
        [_collectionView registerClass:[CalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CalendarHeaderView"];
        
    }
    return _collectionView;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = CFont3D;
        _dateLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    }
    return _dateLabel;
}

- (UIButton *)lastBtn {
    if (!_lastBtn) {
        _lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lastBtn setImage:[UIImage imageNamed:@"last_icon"] forState:UIControlStateNormal];
        [_lastBtn addTarget:self action:@selector(lastBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setImage:[UIImage imageNamed:@"next_icon"] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

#pragma mark -Private
- (NSUInteger)numberOfDaysInMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [greCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;

}

- (NSDate *)firstDateOfMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitWeekday | NSCalendarUnitDay
                               fromDate:date];
    comps.day = 1;
    return [greCalendar dateFromComponents:comps];
}

- (NSUInteger)startDayOfWeek:(NSDate *)date
{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];//Asia/Shanghai
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitWeekday | NSCalendarUnitDay
                               fromDate:[self firstDateOfMonth:date]];
    return comps.weekday;
}

- (NSDate *)getLastMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:date];
    comps.month -= 1;
    return [greCalendar dateFromComponents:comps];
}

- (NSDate *)getNextMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:date];
    comps.month += 1;
    return [greCalendar dateFromComponents:comps];
}

- (NSDate *)dateOfDay:(NSInteger)day{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:self.tempDate];
    comps.day = day;
    return [greCalendar dateFromComponents:comps];
}

@end

@implementation CalendarHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        NSArray *weekArray = [[NSArray alloc] initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
        
        for (int i=0; i<weekArray.count; i++) {
            UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*kRealValue(54), 0, kRealValue(54), 30)];
            weekLabel.textAlignment = NSTextAlignmentCenter;
            weekLabel.textColor = [UIColor grayColor];
            weekLabel.font = [UIFont systemFontOfSize:13.f];
            weekLabel.text = weekArray[i];
            [self addSubview:weekLabel];
        }
        
    }
    return self;
}
@end


@implementation CalendarCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = self.contentView.frame.size.width*0.6;
        CGFloat height = self.contentView.frame.size.height*0.6;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height*0.5-height*0.5, self.contentView.frame.size.width, height)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        self.bgView = bgView;
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake( self.contentView.frame.size.width*0.5-height*0.5,  self.contentView.frame.size.height*0.5-height*0.5, height, height )];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.layer.masksToBounds = YES;
        dayLabel.layer.cornerRadius = height * 0.5;
        dayLabel.backgroundColor = [UIColor whiteColor];
        dayLabel.textColor = [UIColor blackColor];
        dayLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:dayLabel];
        self.dayLabel = dayLabel;
    }
    return self;
}

- (void)setMonthModel:(MonthModel *)monthModel{
    _monthModel = monthModel;
    if (monthModel) {
        CGFloat height = self.contentView.frame.size.height*0.6;
        self.dayLabel.text = [NSString stringWithFormat:@"%02ld",monthModel.dayValue];
        if (monthModel.isSelectedDay) {
            self.dayLabel.backgroundColor = C43B8F6;
            self.dayLabel.textColor = [UIColor whiteColor];
            if (monthModel.isLocation ==0) {
                self.bgView.backgroundColor = UIColorHex(0xDEEFFF);
                self.bgView.frame = CGRectMake(0, self.contentView.frame.size.height*0.5-height*0.5, self.contentView.frame.size.width, height);
            } else if (monthModel.isLocation == -1) {
                self.bgView.backgroundColor = UIColorHex(0xDEEFFF);
                self.bgView.frame = CGRectMake(self.contentView.frame.size.width*0.5, self.contentView.frame.size.height*0.5-height*0.5, self.contentView.frame.size.width*0.5, height);
            } else if (monthModel.isLocation == 1) {
                self.bgView.backgroundColor = UIColorHex(0xDEEFFF);
                self.bgView.frame = CGRectMake(0, self.contentView.frame.size.height*0.5-height*0.5, self.contentView.frame.size.width*0.5, height);
            } else{
                self.bgView.backgroundColor = UIColor.whiteColor;
                self.bgView.frame = CGRectMake(0, self.contentView.frame.size.height*0.5-height*0.5, self.contentView.frame.size.width, height);
            }
        } else {
            self.dayLabel.backgroundColor = [UIColor whiteColor];
            self.dayLabel.textColor = [UIColor blackColor];
            self.bgView.backgroundColor = UIColor.whiteColor;
        }
    } else {
        self.dayLabel.text = @"";
        self.dayLabel.backgroundColor = [UIColor whiteColor];
        self.dayLabel.textColor = [UIColor blackColor];
        self.bgView.backgroundColor = UIColor.whiteColor;
    }
}
@end


@implementation MonthModel

@end
