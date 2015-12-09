//
//  DepartmentViewController.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface DepartmentViewController : BaseTableViewController
@property (nonatomic, copy) void (^choiceBlock)(NSString *id,NSString*name,NSString*pid);
@property (nonatomic, copy) NSString * id;
@end
