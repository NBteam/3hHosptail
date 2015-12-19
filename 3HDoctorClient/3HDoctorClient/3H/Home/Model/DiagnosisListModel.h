//
//  DiagnosisListModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface DiagnosisListModel : BaseModel
//名称
@property (nonatomic, copy) NSString *id;
//记录ID
@property (nonatomic, copy) NSString *name;
//名称拼音缩写
//@property (nonatomic, copy) NSString *//名称;
@end
