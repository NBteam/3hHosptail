//
//  MyAppointmentRegisteredModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
//	id						订单ID
//	order_sn					订单编号
//	total						订单金额
//	pay_status				支付状态，0未支付，1已经支付
//	status_n					订单状态描述
//	addtime					订单提交日期
//	order_date_n				预约时间段
//
//	truename				医生名称
//	job_title					医生职称
//	hospital					医生医院
//	department				医生科室
//	pic						医生头像
@interface MyAppointmentRegisteredModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *pay_status;
@property (nonatomic, copy) NSString *status_n;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *order_date_n;
@property (nonatomic, copy) NSString *truename;
@property (nonatomic, copy) NSString *job_title;
@property (nonatomic, copy) NSString *hospital;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *price;
@end

