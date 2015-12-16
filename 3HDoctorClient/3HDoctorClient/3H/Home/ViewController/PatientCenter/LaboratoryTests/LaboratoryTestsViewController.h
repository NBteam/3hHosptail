//
//  LaboratoryTestsViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"

@interface LaboratoryTestsViewController : BaseViewController

@property (nonatomic, copy) NSString * mid;
//VcIndex == 0 化验  1  检查
@property (nonatomic, assign) NSInteger VcIndex;

@end
