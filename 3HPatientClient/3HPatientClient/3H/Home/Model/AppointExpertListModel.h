//
//  AppointExpertListModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/20.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface AppointExpertListModel : BaseModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * truename;
@property (nonatomic, copy) NSString * job_title;
@property (nonatomic, copy) NSString * hospital;
@property (nonatomic, copy) NSString * department;
@property (nonatomic, copy) NSString * pic;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * md5_id;
@property (nonatomic, copy) NSString * group_id;
//是否有消息
@property (nonatomic, assign) BOOL isMessages;
@end
//	id					记录ID
//	truename			名称
//	job_title				职称
//	hospital				医院
//	department			科室
//	pic					头像
//	desc				医生简介
//	mobile				医生手机号
