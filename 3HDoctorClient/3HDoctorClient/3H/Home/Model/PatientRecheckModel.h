//
//  PatientRecheckModel.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
//id				记录ID
//check_date		复查日期
//check_time		复查时段
//hospital			医院
//prj_name		复查项目
@interface PatientRecheckModel : BaseModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * check_date;
@property (nonatomic, copy) NSString * check_time;
@property (nonatomic, copy) NSString * hospital;
@property (nonatomic, copy) NSString * prj_name;

@end
