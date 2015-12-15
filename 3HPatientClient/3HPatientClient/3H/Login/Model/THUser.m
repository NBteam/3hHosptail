//
//  THUser.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
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
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.birth forKey:@"birth"];
    [aCoder encodeObject:self.card_id forKey:@"card_id"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.invite_c forKey:@"invite_c"];
    [aCoder encodeObject:self.md5_id forKey:@"md5_id"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.pic forKey:@"pic"];
    [aCoder encodeObject:self.points forKey:@"points"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.mobile forKey:@"tel"];
    [aCoder encodeObject:self.truename forKey:@"truename"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.account = [aDecoder decodeObjectForKey:@"account"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.birth = [aDecoder decodeObjectForKey:@"birth"];
        self.card_id = [aDecoder decodeObjectForKey:@"card_id"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.invite_c = [aDecoder decodeObjectForKey:@"invite_c"];
        self.md5_id = [aDecoder decodeObjectForKey:@"md5_id"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.pic = [aDecoder decodeObjectForKey:@"pic"];
        self.points = [aDecoder decodeObjectForKey:@"points"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.tel = [aDecoder decodeObjectForKey:@"tel"];
        self.truename = [aDecoder decodeObjectForKey:@"truename"];
        
        
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
