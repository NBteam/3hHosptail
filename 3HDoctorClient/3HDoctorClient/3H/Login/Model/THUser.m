//
//  THUserModel.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "THUser.h"

@implementation THUser

#pragma mark -- MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return nil;
}

#pragma mark -- NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    
    [aCoder encodeObject:self.account forKey:@"account"];
    [aCoder encodeObject:self.area_ids forKey:@"area_ids"];
    [aCoder encodeObject:self.area_names forKey:@"area_names"];
    [aCoder encodeObject:self.check_pic1 forKey:@"check_pic1"];
    [aCoder encodeObject:self.check_pic2 forKey:@"check_pic2"];
    [aCoder encodeObject:self.department forKey:@"department"];
    [aCoder encodeObject:self.hospital forKey:@"hospital"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.invite_code forKey:@"invite_code"];
    [aCoder encodeObject:self.job_title forKey:@"job_title"];
    [aCoder encodeObject:self.md5_id forKey:@"md5_id"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.pic forKey:@"pic"];
    [aCoder encodeObject:self.points forKey:@"points"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.sign_word forKey:@"sign_word"];
    [aCoder encodeObject:self.truename forKey:@"truename"];
    [aCoder encodeObject:self.work_week forKey:@"work_week"];
    [aCoder encodeObject:self.work_week forKey:@"work_price"];
 
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.account = [aDecoder decodeObjectForKey:@"account"];
        self.area_ids = [aDecoder decodeObjectForKey:@"area_ids"];
        self.area_names = [aDecoder decodeObjectForKey:@"area_names"];
        self.check_pic1 = [aDecoder decodeObjectForKey:@"check_pic1"];
        self.check_pic2 = [aDecoder decodeObjectForKey:@"check_pic2"];
        self.department = [aDecoder decodeObjectForKey:@"department"];
        self.hospital = [aDecoder decodeObjectForKey:@"hospital"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.invite_code = [aDecoder decodeObjectForKey:@"invite_code"];
        self.job_title = [aDecoder decodeObjectForKey:@"job_title"];
        self.md5_id = [aDecoder decodeObjectForKey:@"md5_id"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.pic = [aDecoder decodeObjectForKey:@"pic"];
        self.points = [aDecoder decodeObjectForKey:@"points"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.sign_word = [aDecoder decodeObjectForKey:@"sign_word"];
        self.truename = [aDecoder decodeObjectForKey:@"truename"];
        self.work_week = [aDecoder decodeObjectForKey:@"work_week"];
        self.work_week = [aDecoder decodeObjectForKey:@"work_price"];

 
        
        
    }
    return self;
}

+ (void)writeUserToLacalPath:(NSString *)path andFileName:(NSString *)fileName andWriteClass:(THUser *)user
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    
    [userData writeToFile:[path stringByAppendingPathComponent:fileName] atomically:YES];
}

+ (THUser *)ReadLocalUserDataForPath:(NSString *)path
{
    THUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return user;
}

+ (void)removeUserDataWithPath:(NSString *)path andFileName:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExit = [fileManager fileExistsAtPath:[path stringByAppendingPathComponent:fileName]];
    if (isExit) {
        [fileManager removeItemAtPath:[path stringByAppendingPathComponent:fileName] error:nil];
    }
}

- (NSString *)defaultImageName
{
    //    NSString *imageName = @"doctor_defaultphoto_male";
    //
    //    if (self.gender == 1) {
    //        imageName = @"doctor_defaultphoto_male";
    //    } else if (self.gender == 2) {
    //        imageName = @"doctor_defaultphoto_female";
    //    }
    return nil;
}

@end
