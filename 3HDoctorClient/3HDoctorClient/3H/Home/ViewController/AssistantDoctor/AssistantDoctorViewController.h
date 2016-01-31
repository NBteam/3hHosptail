//
//  AssistantDoctorViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"
#import "AssistantDoctorModel.h"
@interface AssistantDoctorViewController : BaseTableViewController

//是否是聊天过来的
@property (nonatomic, assign) BOOL isMain;

@property (nonatomic, copy) void (^chatBlock)(AssistantDoctorModel *model);
@end
