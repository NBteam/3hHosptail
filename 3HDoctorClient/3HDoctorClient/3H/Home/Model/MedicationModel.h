//
//  MedicationModel.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
//id				记录ID
//name			药物名称
//use_level		剂量
//use_num		次数
//use_time		用药时间（饭前、饭后）
//use_method		用药途径
//start_time		开始时间（YYYY-mm-dd）
//end_time		结束时间（YYYY-mm-dd）
@interface MedicationModel : BaseModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * use_level;
@property (nonatomic, copy) NSString * use_num;
@property (nonatomic, copy) NSString * use_time;
@property (nonatomic, copy) NSString * use_method;
@property (nonatomic, copy) NSString * start_time;
@property (nonatomic, copy) NSString * end_time;
@end
