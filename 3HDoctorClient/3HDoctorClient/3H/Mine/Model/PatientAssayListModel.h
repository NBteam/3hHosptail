//
//  PatientAssayListModel.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
//id				记录ID
//name			名称
//hospital			医院
//pic				图片地址
@interface PatientAssayListModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *hospital;
@property (nonatomic, copy) NSString *pic;
@end
