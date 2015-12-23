//
//  PhoneDetailModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/22.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface PhoneDetailModel : BaseModel


@property (nonatomic, copy) NSString *id	;//					订单ID
@property (nonatomic, copy) NSString *member_id	;//			患者ID
@property (nonatomic, copy) NSString *order_sn;//					订单编号
@property (nonatomic, copy) NSString *price	;//				预约价格
@property (nonatomic, copy) NSString *pay_status	;//			支付状态，0未支付，1已经支付
@property (nonatomic, copy) NSString *status	;//				订单状态，0未确认，1已确认
@property (nonatomic, copy) NSString *status_n;//					订单状态描述
@property (nonatomic, copy) NSString *addtime	;//				订单提交日期
@property (nonatomic, copy) NSString *order_date_n	;//			预约日期
@property (nonatomic, copy) NSString *desc;//					预约描述

@property (nonatomic, copy) NSString *truename;//				患者名称
@property (nonatomic, copy) NSString *sex	;//					性别
@property (nonatomic, copy) NSString *age		;//			年龄
@property (nonatomic, copy) NSString *pic	;//					医生头像
@property (nonatomic, copy) NSString *mobile	;//				患者电话
@end
