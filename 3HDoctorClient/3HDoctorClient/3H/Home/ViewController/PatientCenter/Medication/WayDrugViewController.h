//
//  WayDrugViewController.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface WayDrugViewController : BaseTableViewController

//0 == 用药时间  1 == 用药途径
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) void (^WayDrugBlock)(NSString *name);
@end
