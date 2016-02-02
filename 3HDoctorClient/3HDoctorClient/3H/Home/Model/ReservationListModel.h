//
//  ReservationListModel.h
//  3HDoctorClient
//
//  Created by 郑彦华 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
//	id						订单ID
//	member_id				患者ID
//	order_sn					订单编号
//	total						订单金额
//	pay_status				支付状态，0未支付，1已经支付
//	status					订单状态，0未确认，1已确认
//	status_n					订单状态描述
//	addtime					订单提交日期
//	truename				患者名称
//	sex						性别
//	birth_y					年龄
//	pic						医生头像
@interface ReservationListModel : BaseModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * member_id;
@property (nonatomic, copy) NSString * order_sn;
@property (nonatomic, copy) NSString * total;
@property (nonatomic, copy) NSString * pay_status;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * status_n;
@property (nonatomic, copy) NSString * truename;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * birth_y;
@property (nonatomic, copy) NSString * pic;
@property (nonatomic, copy) NSString * addtime;
@property(nonatomic,copy)NSString *order_date_n;
@end
