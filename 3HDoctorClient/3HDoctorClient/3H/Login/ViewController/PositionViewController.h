//
//  PositionViewController.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface PositionViewController : BaseTableViewController
@property (copy, nonatomic) void(^ChoiceBlock)(NSString *positionStr);
@end
