//
//  DiagnosisListModel.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
//idx				序号（1-10）【整数】
//diag_name		诊断名称
@interface DiagnosisListModel : BaseModel
@property (nonatomic, copy) NSString * idx;
@property (nonatomic, copy) NSString * diag_name;
@end
