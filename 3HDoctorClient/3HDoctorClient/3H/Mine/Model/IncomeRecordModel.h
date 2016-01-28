//
//  IncomeRecordModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 16/1/27.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface IncomeRecordModel : BaseModel

@property (nonatomic, copy) NSString *cur_month;
@property (nonatomic, copy) NSString *cur_month_num;
@property (nonatomic, strong) NSNumber *month_total;
@property (nonatomic, copy) NSString *pre_month;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, copy) NSString *next_month;

@end
