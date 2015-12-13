//
//  THNetWorkManager.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "THHttpResponse.h"

typedef NS_ENUM(NSUInteger, HttpRequestMethod) {
    HttpRequestMethodGET = 1,
    HttpRequestMethodPOST = 2
};

typedef void (^CompletionBlockWithSuccess) (NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response);

typedef void (^FailureBlock) (NSURLSessionDataTask *urlSessionDataTask, NSError *error);

/**
 *	网络上传进度
 *	@param bytesWritten              写入的字节
 *	@param totalBytesWritten         总写入的字节
 *	@param totalBytesExpectedToWrite 要写入的总字节
 */
typedef void (^uploadProgressBlock)(long long bytesSent, long long totalBytesSent, long long totalBytesExpectedToSend);

/// 网络请求类
@interface THNetWorkManager : NSObject

+ (id)shareNetWork;

- (AFHTTPRequestOperation *)requestOperation:(NSString *)requestUrl andParams:(NSDictionary *)paramDic andHeaderFieldParams:(NSDictionary *)headerFieldParamsDic andHttpRequestMethod:(HttpRequestMethod)httpRequestMethod andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

//登陆

#pragma mark 登陆
- (void)patientLoginMobile:(NSString *)mobile
                  Password:(NSString *)password
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                andFailure:(FailureBlock) failure;

#pragma mark 获取我的病史
- (void)getMySickHistoryCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                                        andFailure:(FailureBlock) failure;




@end
