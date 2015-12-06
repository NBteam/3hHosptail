//
//  SexViewController.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface SexViewController : BaseTableViewController
@property (nonatomic,copy) void (^hospitalBlock)(NSString *string);
@end
