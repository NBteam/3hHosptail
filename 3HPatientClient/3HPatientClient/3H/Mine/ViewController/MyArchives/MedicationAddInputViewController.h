//
//  MedicationAddInputViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/17.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"

@interface MedicationAddInputViewController : BaseViewController
// 0= 名称   1 == 计量
@property (nonatomic, assign) NSInteger index;

@property (nonatomic,copy) void (^infoBlock)(NSString *string);
@end
