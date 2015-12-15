//
//  MessageListModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
@interface MessageListModel : BaseModel
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *use_level;
@property (nonatomic, copy) NSString *use_method;
@property (nonatomic, copy) NSString *use_num;
@property (nonatomic, copy) NSString *use_time;
@property (nonatomic, copy) NSString *name;
@end
