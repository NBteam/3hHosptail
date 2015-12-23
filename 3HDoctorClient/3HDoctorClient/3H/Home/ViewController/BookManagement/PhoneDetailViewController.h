//
//  PhoneDetailViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface PhoneDetailViewController : BaseTableViewController

@property (nonatomic, copy) NSString *ids;

@property (nonatomic, copy) void(^reloadBlock)(void);

@end
