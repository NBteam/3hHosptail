//
//  BookRefuseReasonViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"
#import "PhoneDetailModel.h"
@interface BookRefuseReasonViewController : BaseViewController

@property (nonatomic, copy) NSString *ids;

@property (nonatomic, strong) PhoneDetailModel *model;
//拒绝提交完拒绝理由后回调
@property (nonatomic, copy) void(^reloadBlock)(void);
@end
