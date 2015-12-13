//
//  THHttpResponse.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THHttpResponse : NSObject

/// 响应码
@property (nonatomic ,assign) NSInteger responseCode;
/// 响应信息
@property (nonatomic ,copy) NSString *message;
/// 解析完成的data对应的数组数据，如果是数组 取值用这个属性
@property (nonatomic ,strong) NSArray *dataArray;
/// 解析完成的data对应的字典数据，如果是字典 取值用这个属性
@property (nonatomic ,strong) NSDictionary *dataDic;


///  解析返回成功的data数据
+ (THHttpResponse *)kyHttpResponseParse:(id)data;
///  通过返回数据的字典解析model
- (id)thParseDataFromDic:(NSDictionary *)dic andModel:(Class)classModel;
@end
