//
//  DoctorListModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
//	id					记录ID
//	truename			名称
//	job_title				职称
//	hospital				医院
//	department			科室
//	pic					头像
@interface DoctorListModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *truename;
@property (nonatomic, copy) NSString *job_title;
@property (nonatomic, copy) NSString *hospital;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) NSString *pic;
@end
