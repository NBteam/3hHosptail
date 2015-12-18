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

typedef void (^uploadfaceBlockWithSuccess) (AFHTTPRequestOperation *operation, id responseObject);

typedef void (^uploadfaceFailureBlock) (AFHTTPRequestOperation *operation, NSError *error);
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

#pragma mark 获取验证码
- (void)getMobilecode:(NSString *)mobile andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                andFailure:(FailureBlock) failure;

#pragma mark 注册
- (void)getRegMobile:(NSString *)mobile
            Password:(NSString *)password
            Sms_code:(NSString *)sms_code
            Fromcode:(NSString *)fromcode
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
          andFailure:(FailureBlock) failure;

#pragma mark 获取我的病史
- (void)getMySickHistoryCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                                        andFailure:(FailureBlock) failure;
#pragma mark 获取首页信息
- (void)getHomeInfoCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                                   andFailure:(FailureBlock) failure;

#pragma mark 获取文章列表
- (void)getArtListPage:(NSInteger)page
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                andFailure:(FailureBlock) failure;

#pragma mark 获取健康资讯轮播
- (void)getHealthTopsCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                                   andFailure:(FailureBlock) failure;

#pragma mark 获取健康资讯轮播获取文章详情【20151101更新】
- (void)getArtInfoIds:(NSString *)ids CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                                     andFailure:(FailureBlock) failure;

#pragma mark 39	添加医生【20151118添加】
- (void)addDoctorIds:(NSString *)ids CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
           andFailure:(FailureBlock) failure;

#pragma mark获取用户资料接口【20151112更新】
- (void)getUserinfoToken:(NSString *)token CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
          andFailure:(FailureBlock) failure;



#pragma mark上传用户头像
- (void)getUploadFaceFile:(NSData *)file faceString:(NSString *)faceString andCompletionBlockWithSuccess:(uploadfaceBlockWithSuccess)success andFailure:(uploadfaceFailureBlock)failure andProgress:(uploadProgressBlock)progress;


#pragma mark 修改用户资料接口
- (void)updateUserInfoNickname:(NSString *)nickname
                      Truename:(NSString *)truename
                           Sex:(NSString *)sex
                         Birth:(NSString *)birth
                       Address:(NSString *)address
                           Tel:(NSString *)tel
                       Card_id:(NSString *)card_id
    CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                    andFailure:(FailureBlock) failure;

#pragma mark 获取我的化验列表
- (void)getMyAssayListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                andFailure:(FailureBlock) failure;

#pragma mark 获取我的检查列表
- (void)getMyCheckListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                andFailure:(FailureBlock) failure;

#pragma mark 获取我的化验详情【20151213更新】
- (void)getMyAssayId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                andFailure:(FailureBlock) failure;

#pragma mark 获取我的用药提醒列表【20151130添加】
- (void)getMyDrugListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取我的诊断列表【20151127添加】
- (void)getMyDiagnosisListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取我的诊断详情【20151127添加】
- (void)getMyDiagnosisIdx:(NSString *)idx andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取我的复查提醒列表【20151130添加】
- (void)getMyRecheckListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 文章点赞接口【20151030添加】
- (void)voteArtId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取医生详情【20151109更新】
- (void)getDoctorInfoId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取医生列表【20151106添加】
- (void)getDoctorListPage:(NSInteger)page kw:(NSString *)kw andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 我的预约挂号列表【20151212添加】
- (void)getMyOrderguahaoListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 电话预约——我的预约列表【20151216更新】
- (void)getMyOrderTelListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;


@end
