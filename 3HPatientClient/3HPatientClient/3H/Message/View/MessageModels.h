//
//  MessageModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 16/1/25.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModels : BaseModel


@property (nonatomic, strong) NSNumber *preorder_msg_num;//		【整数】预约提醒——未读数量
@property (nonatomic, copy) NSString *preorder_msg_info;//		消息简介

@property (nonatomic, strong) NSNumber *drug_msg_num;//			【整数】用药提醒——未读数量
@property (nonatomic, copy) NSString *drug_msg_info;//			消息简介

@property (nonatomic, strong) NSNumber *recheck_msg_num;//		【整数】复查提醒——未读数量
@property (nonatomic, copy) NSString *recheck_msg_info;//		消息简介

@property (nonatomic, strong) NSNumber *order_msg_num;//			【整数】订单提醒——未读数量
@property (nonatomic, copy) NSString *order_msg_info;//			消息简介

@property (nonatomic, strong) NSNumber *sys_msg_num	;//		【整数】系统消息——未读数量
@property (nonatomic, copy) NSString *sys_msg_info;//			消息简介
@end
