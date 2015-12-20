//
//  PhoneAppointTDetailModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/20.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface PhoneAppointTDetailModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *member_id;
@property (nonatomic, copy) NSString *member_n;
@property (nonatomic, copy) NSString *start_time;

@end
