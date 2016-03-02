//
//  THUserModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface THUser : BaseModel<NSCoding>


@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *area_ids;
@property (nonatomic, copy) NSString *area_names;
@property (nonatomic, copy) NSString *check_pic1;
@property (nonatomic, copy) NSString *check_pic2;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) NSString *hospital;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *invite_code;
@property (nonatomic, copy) NSString *job_title;
@property (nonatomic, copy) NSString *md5_id;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *points;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *sign_word;
@property (nonatomic, copy) NSString *truename;
@property (nonatomic, copy) NSString *work_week;

@property (nonatomic, copy) NSString *work_price;
@property (nonatomic, copy) NSString *is_checked;

// 环信使用的
@property (nonatomic, strong) NSMutableDictionary *dictHX;

//  读取本地文件加载实例
+ (THUser *)ReadLocalUserDataForPath:(NSString *)path;
//  写入本地文件
+ (void)writeUserToLacalPath:(NSString *)path andFileName:(NSString *)fileName andWriteClass:(THUser *)user;
//  删除本地文件
+ (void)removeUserDataWithPath:(NSString *)path andFileName:(NSString *)fileName;

//  默认头像
- (NSString *)defaultImageName;
@end
