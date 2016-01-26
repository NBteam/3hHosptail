//
//  HospitalModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/26.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface HospitalModel : BaseModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * addtime;
//id					记录ID
//content				描述
//addtime				提交时间，YYYY-mm-dd
@end
