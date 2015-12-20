//
//  CommentsListModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/20.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface CommentsListModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, retain) NSArray *pics;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *utype;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *upic;
@property (nonatomic, copy) NSString *addtime;
@end
//	id					记录ID
//	title					标题
//	content				评论
//	pics					图集（数组）
//	uid					用户ID
//	utype				用户类型，0患者，1医生
//	uname				用户名
//	upic					用户头像
//addtime				日期，yyyy-mm-dd
