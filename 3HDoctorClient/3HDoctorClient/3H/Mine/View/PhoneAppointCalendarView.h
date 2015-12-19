//
//  PhoneAppointCalendarView.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneAppointModel.h"
@interface PhoneAppointCalendarView : UIView

{
    NSCalendar *myCalendar;
    NSInteger     firstDayIndexOfWeek;

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
//下个月
@property (nonatomic, copy) NSString *next_date_m;
//上个月
@property (nonatomic, copy) NSString *pre_date_m;

@property (nonatomic, strong) NSMutableArray *dataArrays;

@property (nonatomic,copy) void (^CalendarBlock)(NSString * month );



//天按钮点击事件

@property (nonatomic,copy) void (^CalendarBtnBlock)(NSString * day);


- (CGFloat)reloadCalendarView:(NSMutableArray *)array;

@end
