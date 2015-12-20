//
//  AppointTimeModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/20.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface AppointTimeModel : BaseModel
@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong) NSArray * times;
@end
