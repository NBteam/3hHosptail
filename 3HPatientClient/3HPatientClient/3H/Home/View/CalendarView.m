//
//  CalendarView.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/8.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "CalendarView.h"

@implementation CalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHEX:0xffffff];
        [self customView];
    }
    return self;
}

- (void)customView{
    //初始化日历类，并设置日历类的格式是阳历 若想设置中国日历 设置为NSChineseCalendar
    myCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //设置每周的第一天从星期几开始  设置为 1 是周日，2是周一
    [myCalendar setFirstWeekday:1];
    //设置每个月或者每年的第一周必须包含的最少天数  设置为1 就是第一周至少要有一天
    [myCalendar setMinimumDaysInFirstWeek:1];
    //设置时区，不设置时区获取月的第一天和星期的第一天的时候可能会提前一天。
    [myCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:0]];
    //计算绘制日历需要的数据，我传入当前日期  输入月份或年不同的日期就能得到不同的日历。
    
    nowDate = [NSDate date];
    changeDate = nowDate;
    
    [self getNowInteger:changeDate];
    [self addSubview:self.btnUp];
    [self addSubview:self.labTitle];
    [self addSubview:self.btnDown];
    [self customLables];
    [self addSubview:self.viewBack];
    [self addSubview:self.labLine];
}

- (void)getNowInteger:(NSDate *)data{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:data];
    yearInt = [dateComponent year];
    monthInt = [dateComponent month];
    dayInt = [dateComponent day];
    
    changeYear = yearInt;
    changeMonth = monthInt;
    changeDay = dayInt;
    
    if (changeMonth<10) {
        if (changeMonth == 0) {
            changeMonth = 12;
            changeYear --;
        }
    }else{
        if (changeMonth == 13) {
            changeMonth = 1;
            changeYear ++;
            
        }
    }
    

    [self reloadTitle:changeYear month:changeMonth day:changeDay index:0];
    [self calendarSetDate:changeDate];
    
}

- (void)reloadTitle:(NSInteger)year month:(NSInteger)month day:(NSInteger)day index:(NSInteger)index{

    NSString *yearString;
    
    NSString *monthString;
    NSString *dayString;
    
    if (month<10) {
        monthString = [NSString stringWithFormat:@"0%li",month];
    }else{
        monthString = [NSString stringWithFormat:@"%li",month];
    }
    
    if (day<10) {
        dayString = [NSString stringWithFormat:@"0%li",day];
    }else{
        dayString = [NSString stringWithFormat:@"%li",day];
    }
    
    yearString = [NSString stringWithFormat:@"%li",year];
    
    if (changeYear == yearInt &&changeMonth == monthInt) {
        self.labTitle.text = [NSString stringWithFormat:@"%@年%@月%@日",yearString,monthString,dayString];
        NSLog(@"草泥马");
        if (self.CalendarBlock) {
            self.CalendarBlock(yearString,monthString,dayString);
            NSLog(@"草泥马");
        }
    }else{
        if (index == 0) {
            self.labTitle.text = [NSString stringWithFormat:@"%@年%@月%@日",yearString,monthString,@"01"];
            
            if (self.CalendarBlock) {
                self.CalendarBlock(yearString,monthString,@"01");
            }
        }else{
            self.labTitle.text = [NSString stringWithFormat:@"%@年%@月%@日",yearString,monthString,dayString];
            if (self.CalendarBlock) {
                self.CalendarBlock(yearString,monthString,dayString);
            }
        }
    }
    
    
    
}


- (UIButton *)btnUp{
    if (!_btnUp) {
        _btnUp = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnUp setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_左"] forState:UIControlStateNormal];
        _btnUp.frame = CGRectMake(10, 15, DeviceSize.width/4 -20, 25);
        [_btnUp addTarget:self action:@selector(btnUpAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnUp;
}

- (void)btnUpAction{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:changeDate];
    
    
    
    [dateComponent setMonth:([dateComponent month] - 1)];
    changeDate = [calendar dateFromComponents:dateComponent];
    changeYear = [dateComponent year];
    changeMonth = [dateComponent month];
    changeDay = [dateComponent day];
    
    if (changeMonth<10) {
        if (changeMonth == 0) {
            changeMonth = 12;
            changeYear --;
        }
    }else{
        if (changeMonth == 13) {
            changeMonth = 1;
            changeYear ++;

    }
    }
    [self reloadTitle:changeYear month:changeMonth day:changeDay index:0];
    [self calendarSetDate:changeDate];
}

- (UIButton *)btnDown{
    if (!_btnDown) {
        _btnDown = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDown setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_右"] forState:UIControlStateNormal];
        _btnDown.frame = CGRectMake(DeviceSize.width -DeviceSize.width/4 +10 ,15, DeviceSize.width/4 -20, 25);
        [_btnDown addTarget:self action:@selector(btnDownAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDown;
}

- (void)btnDownAction{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:changeDate];
    
    
    
    [dateComponent setMonth:([dateComponent month] + 1)];
    
    changeDate = [calendar dateFromComponents:dateComponent];
    changeYear = [dateComponent year];
    changeMonth = [dateComponent month];
    changeDay = [dateComponent day];
    
    if (changeMonth<10) {
        if (changeMonth == 0) {
            changeMonth = 12;
            changeYear --;
        }
    }else{
        if (changeMonth == 13) {
            changeMonth = 1;
            changeYear ++;
            
        }
    }
    
    [self reloadTitle:changeYear month:changeMonth day:changeDay index:0];
    [self calendarSetDate:changeDate];
    
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake((DeviceSize.width -DeviceSize.width/2)/2, 15, DeviceSize.width/2, 25)];
        _labTitle.textColor = AppDefaultColor;
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"2016年09月20日";
        _labTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labTitle;
}

- (void)customLables{
    NSArray *arr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i<7; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10 +((DeviceSize.width -20)/7)*i, self.btnUp.bottom +10, (DeviceSize.width -20)/7, 25)];
        lab.font = [UIFont systemFontOfSize:15];
        lab.text = arr[i];
        lab.textColor = [UIColor colorWithHEX:0x333333];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
    }
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(10, self.btnUp.bottom +35, DeviceSize.width -20, 125)];
        //_viewBack.backgroundColor = [UIColor grayColor];
    }
    return _viewBack;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}

-(void)calendarSetDate:(NSDate *)date
{
   // [self.viewBack removeFromSuperview];
    
    for (UIButton *btn in self.viewBack.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn removeFromSuperview];
        }
    }
    /* 日历类里比较重要的三个方法
     -(NSRange)rangeOfUnit:(NSCalendarUnit)smaller inUnit:(NSCalendarUnit)larger forDate:(NSDate *)date;
     该方法计算date所在的larger单位  里有几个  smaller单位。
     例如smaller为NSDayCalendarUnit，larger为NSMonthCalendarUnit则返回的nsrange的length为date所在的月里共有多少天。
     
     -(NSUInteger)ordinalityOfUnit:(NSCalendarUnit)smaller inUnit:(NSCalendarUnit)larger forDate:(NSDate *)date;
     该方法计算date 所在的smaller单位 在 date所在的larger单位 里的位置，即第几位。
     例如smaller为NSDayCalendarUnit，larger为NSMonthCalendarUnit则返回的 nsUInteger为date是date所在的月里的第几天。
     
     -(BOOL)rangeOfUnit:(NSCalendarUnit)unit startDate:(NSDate *)datep interval:(NSTimeInterval )tip forDate:(NSDate *)date;
     若datep 和 tip 可计算，则方法返回YES，否则返回NO。当返回YES时，可从datep里得到date所在的 unit单位 的第一天。unit可以为 NSMonthCalendarUnit NSWeekCalendarUnit 等
     
     */
    
    
    //获取date所在的月的天数，即monthRange的length
    monthRange = [myCalendar rangeOfUnit:NSDayCalendarUnit
                                  inUnit:NSMonthCalendarUnit
                                 forDate:date];
    NSLog(@"monthRange:%li,%li",monthRange.location,monthRange.length);
    //获取date在其所在的月份里的位置

    if (yearInt == changeYear &&monthInt == changeMonth) {
        currentDayIndexOfMonth = [myCalendar ordinalityOfUnit:NSDayCalendarUnit
                                                       inUnit:NSMonthCalendarUnit
                                                      forDate:date] ;
        NSLog(@"currentIndex:%i",currentDayIndexOfMonth);
    }else{
        currentDayIndexOfMonth = 0;
    }
    
    NSTimeInterval interval;
    NSDate *firstDayOfMonth;
    //如果firstDayOfMonth和interval可计算，下边这个方法会返回YES，并且由firstDayOfMonth可得到date所在的设置的时间段（NSMonthCalendarUnit）里的第一天
    if ([myCalendar rangeOfUnit: NSMonthCalendarUnit startDate:&firstDayOfMonth interval:&interval forDate:date])
    {
        NSLog(@"%@",firstDayOfMonth);
        NSLog(@"%f",interval);
    }
    //获取date所在月的第一天在其所在周的位置，即第几天。
    firstDayIndexOfWeek = [myCalendar ordinalityOfUnit:NSDayCalendarUnit
                                                inUnit:NSWeekCalendarUnit
                                               forDate:firstDayOfMonth];
    //画按钮
    [self drawBtn];
    
}

-(void)drawBtn
{
    CGFloat f = ((DeviceSize.width -20)/7 -25)/2;
    //为了方便计算按钮的frame，我的i没从0开始
    for (int i = firstDayIndexOfWeek - 1 ; i < monthRange.length + firstDayIndexOfWeek -1 ; i ++)
    {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(f + (f +(f+25)) * (i%7), 5 + (f +25)*(i/7), 25, 25);
        btn.tag = i + 2 - firstDayIndexOfWeek;
        
        [btn setTitle:[NSString stringWithFormat:@"%i",i + 2 - firstDayIndexOfWeek ] forState:UIControlStateNormal];
        if (i + 2 - firstDayIndexOfWeek == currentDayIndexOfMonth) {
            btn.backgroundColor = AppDefaultColor;
            [btn setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        }else{
            btn.backgroundColor = [UIColor colorWithHEX:0xffffff];
            [btn setTitleColor:[UIColor colorWithHEX:0x333333] forState:UIControlStateNormal];
        }
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self
                action:@selector(nslogBtnTag:)
      forControlEvents:UIControlEventTouchUpInside];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3;
        
        [self.viewBack addSubview:btn];
        self.viewBack.height = btn.bottom +5;
        
        self.height = self.viewBack.bottom;
        self.labLine.top = self.height -0.5;
        if (self.calendarFloatBlock) {
            self.calendarFloatBlock(self.height);
        }
    }
}

-(void)nslogBtnTag:(UIButton *)btn{
    NSLog(@"%li",btn.tag);

    for (UIButton *button in self.viewBack.subviews) {
        if (button.tag == currentDayIndexOfMonth) {
            button.backgroundColor = AppDefaultColor;
            [button setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        }else{
            if (btn.tag == button.tag) {
                button.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
                [button setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
            }else{
                button.backgroundColor = [UIColor colorWithHEX:0xffffff];
                [button setTitleColor:[UIColor colorWithHEX:0x333333] forState:UIControlStateNormal];
            }
        }
    }
    
    [self reloadTitle:changeYear month:changeMonth day:btn.tag index:1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
