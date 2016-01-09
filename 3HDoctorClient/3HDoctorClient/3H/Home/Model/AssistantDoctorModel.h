//
//  AssistantDoctorModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 16/1/9.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface AssistantDoctorModel : BaseModel



@property (nonatomic, copy) NSString *id;//					助理ID
@property (nonatomic, copy) NSString *truename	;//			名称
@property (nonatomic, copy) NSString *job_title	;//				职称
@property (nonatomic, copy) NSString *hospital;//					医院
@property (nonatomic, copy) NSString *department;//				科室
@property (nonatomic, copy) NSString *pic;//						头像
@property (nonatomic, copy) NSString *desc	;//				助理简介
@property (nonatomic, copy) NSString *mobile;//					助理手机号
@property (nonatomic, copy) NSString *req_status;//				请求状态，（-1拒绝，0请求待处理，1通过请求）
@end
