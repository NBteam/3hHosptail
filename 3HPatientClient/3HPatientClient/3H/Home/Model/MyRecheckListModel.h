//
//  MyRecheckListModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/17.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface MyRecheckListModel : BaseModel
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *check_date;
@property (nonatomic, copy) NSString *check_time;
@property (nonatomic, copy) NSString *hospital;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *prj_name;

@end
