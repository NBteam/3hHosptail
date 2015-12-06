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
@end
