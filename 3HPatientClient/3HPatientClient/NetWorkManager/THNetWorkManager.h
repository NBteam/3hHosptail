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

#pragma mark 获取商品列表【20151021添加】
- (void)getGoodsListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取商品详情【20151023更新】
- (void)getGoodsFlashId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 评论文章接口【20151104更新】
- (void)getCmtArtId:(NSString *)id content:(NSString *)content andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 配送地址——列表【20151217更新】
- (void)getAddressListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 配送地址——添加【20151217更新】
- (void)getAddAddressName:(NSString *)name mobile:(NSString *)mobile area_ids:(NSString *)area_ids address:(NSString *)address zipcode:(NSString *)zipcode is_default:(NSString *)is_default andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 设置默认【20151208添加】
- (void)setDefaultAddressId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取城市列表
- (void)getCityListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取二级城市列表
- (void)getAreaListId:(NSString *)id suball:(NSInteger)suball andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 配送地址——删除【20151208添加】
- (void)getRemoveAddressId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【收费会员权限】电话预约——提交预约【20151216更新】
- (void)getAddOrderTelOrder_tel_id:(NSString *)order_tel_id	desc  :(NSString *)desc andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【收费会员权限】我的医生列表【20151118添加】
- (void)getMyDoctorsPage:(NSInteger )page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取医生某天预约情况列表【20151112添加】
- (void)getDoctorTelTimeitemsDoctor_id:(NSString *)doctor_id date:(NSString *)date andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取文章评论列表【20151104更新】
- (void)getArtCmtListId:(NSString *)id page:(NSInteger )page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
@end
