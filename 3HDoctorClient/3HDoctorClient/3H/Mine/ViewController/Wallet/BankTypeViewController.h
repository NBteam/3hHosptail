//
//  BankTypeViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 16/1/9.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BankTypeViewController : BaseTableViewController

@property (nonatomic, copy) NSString *bankName;
@property (nonatomic, copy) NSString *bankId;
@property (nonatomic, copy) void (^bankBlock)(NSString *rankName,NSString *rankId,NSString *rankType);
@end
