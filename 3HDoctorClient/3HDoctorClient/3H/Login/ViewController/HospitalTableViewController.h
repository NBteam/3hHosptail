//
//  HospitalTableViewController.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface HospitalTableViewController : BaseTableViewController
@property (nonatomic, copy) void (^hospitalBlock)(NSString *string,NSString*str);
@property (nonatomic, copy) NSString * ids;
@end
