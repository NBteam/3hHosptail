//
//  DiagnosisAddInputViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"

@interface DiagnosisAddInputViewController : BaseViewController
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *idx;
@property (nonatomic, copy) void(^reloadBlock)(void);
@end
