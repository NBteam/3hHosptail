//
//  PatientAddRequestModel.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
//id				用户ID
//truename		姓名
//sex				性别（如：保密、男、女）
//age				年龄
//pic				头像
//sick_desc		病情描述
@interface PatientAddRequestModel : BaseModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * truename;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * age;
@property (nonatomic, copy) NSString * pic;
@property (nonatomic, copy) NSString * sick_desc;
@property (nonatomic, copy) NSString * req_id;
@end
