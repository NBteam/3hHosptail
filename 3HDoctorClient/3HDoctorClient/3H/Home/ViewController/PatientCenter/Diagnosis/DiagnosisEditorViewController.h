//
//  DiagnosisEditorViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface DiagnosisEditorViewController : BaseTableViewController
@property (nonatomic, copy) NSString * mid;
@property (nonatomic, copy) void(^reloadBlock)(void);
@end
