//
//  PhoneAppointCalendarView.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneAppointCalendarView : UIView

{
    NSCalendar *myCalendar;
    NSRange monthRange;
    int     currentDayIndexOfMonth;
    int     firstDayIndexOfWeek;
    //年
    NSInteger yearInt;
    //月
    NSInteger monthInt;
    //日
    NSInteger dayInt;
    
    //动态月
    
    NSInteger changeYear;
    NSInteger changeMonth;
    NSInteger changeDay;
    NSDate *changeDate;
    //现在的date
    NSDate *nowDate;
}
//日期
@property (nonatomic, strong) UILabel *labTitle;
//上个月
@property (nonatomic, strong) UIButton *btnUp;
//下个月
@property (nonatomic, strong) UIButton *btnDown;
//日期背景view
@property (nonatomic, strong) UIView *viewBack;
//横线
@property (nonatomic, strong) UILabel *labLine;


@property (nonatomic,assign) CGFloat viewHeight;
@property (nonatomic,copy) void (^CalendarBlock)(NSString * year ,NSString * month ,NSString * day);

//通知tableview改变y坐标

@property (nonatomic, copy) void(^calendarFloatBlock)(CGFloat height);

@end
