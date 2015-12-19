//
//  AddressListModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface AddressListModel : BaseModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * area_ids;
@property (nonatomic, copy) NSString * area_names;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * zipcode;
@property (nonatomic, copy) NSString * is_default;

@end
//	id					地址ID
//	name				收货人
//	mobile				手机号
//	area_ids				省市ID，以英文逗号间隔
//	area_names			area_ids	对应省市名称
//	address				地址
//	zipcode				邮编
//	is_default			是否默认