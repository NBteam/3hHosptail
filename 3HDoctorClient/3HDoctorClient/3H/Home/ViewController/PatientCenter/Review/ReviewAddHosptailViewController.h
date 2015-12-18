//
//  ReviewAddHosptailViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface ReviewAddHosptailViewController : BaseTableViewController

@property (nonatomic, copy) void(^ReviewAddHosptailBlock)(NSString *name);
@end
