//
//  NameInputViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"

@interface NameInputViewController : BaseViewController

// 0= 名字   1 == 签名
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *nameString;

@property (nonatomic,copy) void (^nameBlock)(NSString *string);
@end
