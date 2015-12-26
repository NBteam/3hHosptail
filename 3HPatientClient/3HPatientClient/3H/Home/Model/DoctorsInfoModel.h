//
//  DoctorsInfoModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/26.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface DoctorsInfoModel : BaseModel
@property (nonatomic, copy) NSString *afternoon_enable;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *date_num;
@property (nonatomic, copy) NSString *forenoon_enable;
@property (nonatomic, copy) NSString *week_n;

@end
