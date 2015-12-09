//
//  CalendarView.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/8.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarView : UIView
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



@property (nonatomic,copy) void (^CalendarBlock)(NSString * year ,NSString * month ,NSString * day);
@end
