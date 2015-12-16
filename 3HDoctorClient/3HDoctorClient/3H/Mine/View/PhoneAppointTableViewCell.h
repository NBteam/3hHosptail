//
//  PhoneAppointTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PhoneAppointCalendarView.h"
@interface PhoneAppointTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) PhoneAppointCalendarView *calendarView;

@property (nonatomic, copy) void(^phoneAppointBlock)();

//赋值
- (CGFloat)confingWithModel:(NSInteger )dic;
@end
