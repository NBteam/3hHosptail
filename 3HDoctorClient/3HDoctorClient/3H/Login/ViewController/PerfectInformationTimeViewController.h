//
//  PerfectInformationTimeViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"

@interface PerfectInformationTimeViewController : BaseViewController


@property (nonatomic, copy) void(^PerfectInformationTimeBlock)(NSString *str,NSString *price);
@end
