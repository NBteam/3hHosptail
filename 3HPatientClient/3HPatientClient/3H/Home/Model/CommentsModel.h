//
//  CommentsModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/12.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface CommentsModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *utype;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *upic;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *star;

//	id					记录ID
//	content				评论
//	uid					用户ID
//	utype				用户类型，0患者，1医生
//	uname				用户名
//	upic					用户头像
//	addtime				添加日期\
//	star					星级，1很差，2不好，3一般，4不错，5很好
@end
