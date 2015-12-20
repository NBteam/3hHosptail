//
//  PhoneAppointTimesViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/20.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface PhoneAppointTimesViewController : BaseTableViewController
@property (nonatomic, copy) void (^timeVcBlock)(NSString *time);
//0 == 时间  1 == 时长
@property (nonatomic, assign) NSInteger index;

@end
