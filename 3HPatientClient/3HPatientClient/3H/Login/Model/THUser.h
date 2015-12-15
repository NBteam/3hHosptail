//
//  THUser.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface THUser : BaseModel<NSCoding>


@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *birth;
@property (nonatomic, copy) NSString *card_id;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *invite_c;
@property (nonatomic, copy) NSString *md5_id;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *points;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *truename;

//  读取本地文件加载实例
+ (THUser *)ReadLocalUserDataForPath:(NSString *)path;
//  写入本地文件
+ (void)writeUserToLacalPath:(NSString *)path andFileName:(NSString *)fileName andWriteClass:(THUser *)user;
//  删除本地文件
+ (void)removeUserDataWithPath:(NSString *)path andFileName:(NSString *)fileName;

//  默认头像
- (NSString *)defaultImageName;
@end
