//
//  ConsultingUnFinishedModel.h
//  3HDoctorClient
//
//  Created by 郑彦华 on 15/12/27.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface ConsultingUnFinishedModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *truename;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *chat_desc;
@property (nonatomic, copy) NSString *addtime;

@end
//	id				患者ID
//	truename		姓名
//	sex				性别（如：保密、男、女）
//	age				年龄
//	pic				头像
//	chat_desc		聊天内容简介
//	addtime			咨询日期
