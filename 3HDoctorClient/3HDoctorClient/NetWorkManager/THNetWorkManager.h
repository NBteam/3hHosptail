//
//  THNetWorkManager.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
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

#pragma mark 获取城市列表
- (void)getCityListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 *	获取客户端版本
 */
- (void)getDeviceVersiontypeCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 *	注册
 * @param mobile      手机号
 * @param code        验证码
 * @param password    密码
 * @param fromcode    邀请码
 */
- (void)getRegisteredMobile:(NSString *)mobile password:(NSString *)password code:(NSString *)code fromcode:(NSString *)fromcode andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 *	获取验证码
 * @param mobile      手机号
 */
- (void)getCodeMobile:(NSString *)mobile andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 登录
 * @param mobile      手机号
 * @param password    密码
 */
- (void)getLoginMobile:(NSString *)mobile password:(NSString *)password andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取首页信息
 *
 */
- (void)getHomeCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取职称列表
 *
 */
- (void)getJobposListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取医院科室
 *
 */
- (void)getHospitalDeptLisPid:(NSString *)pid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取医院列表
 *
 */
- (void)getHospitalLisPid:(NSString *)pid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 我的钱包
 *
 */
- (void)getMyAccountCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取患者病史
 *
 */
- (void)getPatientSickHistoryMid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 编辑患者病史
 * @param mid         患者ID
 * @param guomin      过敏史
 * @param blood_type  血型
 * @param desc        病情描述
 */
- (void)editPatientSickHistoryMid:(NSString *)mid guomin:(NSString *)guomin blood_type:(NSString *)blood_type desc:(NSString *)desc andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取文章列表
 * @param page        分页
 * @param pos         分页位置
 */
- (void)getArtListPage:(NSInteger)page pos:(NSInteger)pos andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取文章详情
 * @param id        id
 */
- (void)getArtInfoId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 我的患者列表
 * @param page        分页
 */
- (void)getMyPatientsPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 文章点赞接口
 * @param id        文章Id
 */
- (void)getVoteArtId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取用户资料接口
 */
- (void)getUserInfoCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取用户资料接口
 * @param  真实姓名
 * @param    sex					0保密，1男，2女
 * @param   hospital				医院
 * @param   department			科室
 * @param	job_title				职称
 * @param	sign_word			个性签名
 * @param	work_week			门诊时间，格式如：周一上午,周一下午,周三下午,周五上午
 * @param   area_ids				城市id，格式：1,2  (省份ID,城市ID)
 */
- (void)getUpdateUserInfoTruename:(NSString *)truename sex:(NSString *)sex hospital:(NSString *)hospital department:(NSString *)department job_title:(NSString *)job_title sign_word:(NSString *)sign_word	work_week:(NSString *)work_week area_ids:(NSString *)area_ids andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 我的患者请求列表
 * @param page  分页
 */
- (void)getmyPatientReqsPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取患者化验列表
 * @param page  分页
 * @param mid   患者ID
 */
- (void)getPatientAssayListPage:(NSInteger)page mid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取患者检查列表
 * @param page  分页
 * @param mid   患者ID
 */
- (void)getPatientCheckListPage:(NSInteger)page mid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取患者用药提醒列表
 * @param page  分页
 * @param mid   患者ID
 */
- (void)getPatientDrugListPage:(NSInteger)page mid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取患者复查提醒列表
 * @param page  分页
 * @param mid   患者ID
 */
- (void)getPatientRecheckListPage:(NSInteger)page mid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 处理患者添加请求
 * @param req_id    请求ID
 * @param process	1通过，-1拒绝
 */
- (void)getMyPatientReqProcessReq_id:(NSString *)req_id process:(NSInteger)process andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取患者化验详情
 * @param mid   患者ID
 * @param id	记录ID
 */
- (void)getPatientAssayMid:(NSString *)mid id:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取患者检查详情
 * @param mid   患者ID
 * @param id	记录ID
 */
- (void)getPatientCheckMid:(NSString *)mid id:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取患者诊断列表
 * @param mid   患者ID
 */
- (void)getPatientDiagnosisListMid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 获取医疗资讯轮播
 */
- (void)getDoctorTopsCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 我的预约挂号列表
 * @param page   分页
 */
- (void)getMyOrderguahaoListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 我的预约挂号详情
 * @param id   id
 */
- (void)getMyOrderguahaoInfoId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 我的挂号预约——处理请求
 * @param id   id
 * @param opt  1同意，-1拒绝
 */
- (void)processMyOrderguahaoId:(NSString *)id opt:(NSInteger)opt andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
/**
 * 上传用户头像
 */
- (void)getUploadFaceFile:(NSData *)file faceString:(NSString *)faceString andCompletionBlockWithSuccess:(uploadfaceBlockWithSuccess)success andFailure:(uploadfaceFailureBlock)failure andProgress:(uploadProgressBlock)progress;
@end
