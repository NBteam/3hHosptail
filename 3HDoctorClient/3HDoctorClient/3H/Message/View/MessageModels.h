//
//  MessageModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 16/1/25.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModels : BaseModel


@property (nonatomic, strong) NSNumber *guahao_msg_num;//		【整数】挂号预约——未处理数量
@property (nonatomic, copy) NSString *guahao_msg_info;//			消息简介

@property (nonatomic, strong) NSNumber *otel_msg_num;//			【整数】电话预约——未处理数量
@property (nonatomic, copy) NSString *otel_msg_info;//			消息简介

@property (nonatomic, strong) NSNumber *chat_msg_num;//			【整数】咨询消息——未回复数量
@property (nonatomic, copy) NSString *chat_msg_info;//			消息简介

@property (nonatomic, strong) NSNumber *user_add_msg_num;//		【整数】患者添加——未处理数量
@property (nonatomic, copy) NSString *user_add_msg_info;//		消息简介

@property (nonatomic, strong) NSNumber *assi_add_msg_num;//		【整数】助理添加——未处理数量
@property (nonatomic, copy) NSString *assi_add_msg_info;//		消息简介

@property (nonatomic, strong) NSNumber *sys_msg_num	;//		【整数】系统消息——未读数量
@property (nonatomic, copy) NSString *sys_msg_info	;//		消息简介
@end
