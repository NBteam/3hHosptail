//
//  DoctorInfoModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface DoctorInfoModel : BaseModel
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *hospital;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *job_title;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *truename;

@end
