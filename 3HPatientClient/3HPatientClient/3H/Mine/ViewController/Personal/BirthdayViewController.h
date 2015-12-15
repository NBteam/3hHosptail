//
//  BirthdayViewController.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"

@interface BirthdayViewController : BaseViewController

@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, copy) void (^BirthdayBlock)(NSString *date);

@end
