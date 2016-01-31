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
@property (nonatomic, copy) NSString *md5_id	;//				职称
@property (nonatomic, copy) NSString *hid;//					医院	
@property (nonatomic, copy) NSString *pic;//						头像

@end
