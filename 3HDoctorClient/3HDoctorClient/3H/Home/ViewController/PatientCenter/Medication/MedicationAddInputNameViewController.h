//
//  MedicationAddInputNameViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/23.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface MedicationAddInputNameViewController : BaseTableViewController
@property (nonatomic,copy) void (^nameBlock)(NSString *string);
@end