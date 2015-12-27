//
//  ScheduleCalendar.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/27.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface ScheduleCalendarModel : BaseModel
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, copy) NSString *m;
@property (nonatomic, copy) NSString *next_date_m;
@property (nonatomic, copy) NSString *pre_date_m;
@property (nonatomic, copy) NSString *y;
@end
