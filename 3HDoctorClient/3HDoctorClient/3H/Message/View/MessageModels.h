//
//  MessageModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 16/1/25.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel
@property (nonatomic, copy) NSString *chat_msg_info;
@property (nonatomic, strong) NSNumber *chat_msg_num;
@property (nonatomic, copy) NSString *guahao_msg_info;
@property (nonatomic, strong) NSNumber *guahao_msg_num;
@property (nonatomic, copy) NSString *otel_msg_info;
@property (nonatomic, strong) NSNumber *otel_msg_num;
@property (nonatomic, copy) NSString *sys_msg_info;
@property (nonatomic, strong) NSNumber *sys_msg_num;
@property (nonatomic, copy) NSString *user_add_msg_info;
@property (nonatomic, strong) NSNumber *user_add_msg_num;
@end
