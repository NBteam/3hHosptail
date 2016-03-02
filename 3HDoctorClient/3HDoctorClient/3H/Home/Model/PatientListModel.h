//
//  PatientListModel.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface PatientListModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *truename;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *sick_desc;
//环信群聊id
@property (nonatomic, copy) NSString *group_id;
@property (nonatomic, copy) NSString *md5_id;
//是否是助理的患者 1 是 0 不是
@property (nonatomic, copy) NSString *is_assist_patient;

//是否有消息
@property (nonatomic, assign) BOOL isMessages;
@end
