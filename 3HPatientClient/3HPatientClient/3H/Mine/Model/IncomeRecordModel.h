//
//  IncomeRecordModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/29.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface IncomeRecordModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *memo;
@end
//id				记录ID
//total				金额
//addtime			消费日期
//memo			消费项目
