//
//  MedicationAddNumViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/17.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"

@interface MedicationAddNumViewController : BaseViewController

@property (nonatomic, copy)void (^medicationAddNumBlock)(NSString *name);
@end