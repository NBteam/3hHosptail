//
//  BookSuccessViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BookSuccessViewController : BaseTableViewController
//1 代表挂号预约
//2 代表电话预约
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy) NSString *timeStrig;

@property (nonatomic, copy) NSString *nameString;



//预约成功后
@property (nonatomic,copy) void(^bookSuccessBlock)();
@end
