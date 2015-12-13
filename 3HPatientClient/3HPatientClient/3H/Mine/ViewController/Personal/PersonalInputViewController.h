//
//  PersonalInputViewController.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface PersonalInputViewController : BaseTableViewController
//index 0 == 用户名 1 == 姓名  2 == 通讯地址  3 == 电话  4 == 身份证号
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) void (^nameBlock)(NSString *string);
@end
