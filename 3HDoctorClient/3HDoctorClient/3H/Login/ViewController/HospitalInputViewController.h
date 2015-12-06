//
//  HospitalInputViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"

@interface HospitalInputViewController : BaseViewController
@property (nonatomic, copy) NSString * titleStr;
@property (nonatomic,copy) void (^hospitalBlock)(NSString *string);
@end
