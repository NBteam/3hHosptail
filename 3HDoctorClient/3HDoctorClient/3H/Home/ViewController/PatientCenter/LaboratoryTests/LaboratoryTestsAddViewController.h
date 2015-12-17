//
//  LaboratoryTestsAddViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface LaboratoryTestsAddViewController : BaseTableViewController

//判断是化验还是检查 1 =化验 2 =检查
@property (nonatomic,assign) NSInteger index;
@property (nonatomic, copy) NSString * mid;

@property (nonatomic, copy) void(^reloadBlock)(void);


@end
