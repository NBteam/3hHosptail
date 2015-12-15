//
//  CheckDataDetailViewController.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CheckDataDetailViewController : BaseTableViewController
// 0 == 化验  1 == 检查
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy) NSString *titles;

@property (nonatomic, copy) NSString *ids;

@end
