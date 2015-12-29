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
- (void)getArtListPage:(NSInteger)page pos:(NSString *)pos andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
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
- (void)getUserInfoToken:(NSString *)token CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
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
- (void)getUpdateUserInfoTruename:(NSString *)truename sex:(NSString *)sex hospital:(NSString *)hospital department:(NSString *)department job_title:(NSString *)job_title sign_word:(NSString *)sign_word	work_week:(NSString *)work_week work_price:(NSString *)work_price area_ids:(NSString *)area_ids andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
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

#pragma mark 添加患者化验
- (void)addPatientAssayMid:(NSString *)mid Name:(NSString *)name Hospital:(NSString *)hospital Time:(NSString *)time File:(NSMutableArray *)files faceString:(NSMutableArray *)faceString andCompletionBlockWithSuccess:(uploadfaceBlockWithSuccess)success andFailure:(uploadfaceFailureBlock)failure andProgress:(uploadProgressBlock)progress;

#pragma mark 添加患者检查
- (void)addPatientCheckMid:(NSString *)mid Name:(NSString *)name Hospital:(NSString *)hospital Time:(NSString *)time File:(NSMutableArray *)files faceString:(NSMutableArray *)faceString andCompletionBlockWithSuccess:(uploadfaceBlockWithSuccess)success andFailure:(uploadfaceFailureBlock)failure andProgress:(uploadProgressBlock)progress;


#pragma mark 获取患者化验和检查详情【20151213更新】
- (void)getPatientCheckIds:(NSString *)ids Index:(NSInteger)index  CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 添加患者用药提醒【20151130更新】

- (void)addPatientDrugMid:(NSString *)mid
                     Name:(NSString *)name
                Use_level:(NSString *)use_level
                  Use_num:(NSString *)use_num
                 Use_time:(NSString *)use_time
               Use_method:(NSString *)use_method
               Start_time:(NSString *)start_time
                 End_time:(NSString *)end_time
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
               andFailure:(FailureBlock) failure;

#pragma mark 电话预约——编辑某天设置【20151105添加】

- (void)addTimeItemsdate:(NSString *)date
              start_time:(NSString *)start_time
                end_time:(NSString *)end_time
                 minutes:(NSString *)minutes
                   price:(CGFloat)price
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
               andFailure:(FailureBlock) failure;

#pragma mark 电话预约¬——获取某天设置【20151105添加】
- (void)getOrderTelSetdate:(NSString *)date
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                andFailure:(FailureBlock) failure;


#pragma mark 添加患者复查提醒【20151129添加】
- (void)addPatientRechecktmid:(NSString *)mid
                   check_date:(NSString *)check_date
                   check_time:(NSString *)check_time
                     hospital:(NSString *)hospital
                     prj_name:(NSString *)prj_name
   CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                   andFailure:(FailureBlock) failure;

#pragma mark 患者诊断——详情
- (void)getPatientDiagnosismid:(NSString *)mid
                   idx:(NSString *)idx
   CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                   andFailure:(FailureBlock) failure;
#pragma mark 疾病列表
- (void)getSickListshort:(NSString *)shorts
    CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                    andFailure:(FailureBlock) failure;

#pragma mark 疾病详情
- (void)getSickInfoId:(NSString *)ids
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
              andFailure:(FailureBlock) failure;

#pragma mark 编辑患者诊断【20151127添加】
- (void)editPatientDiagnosismid:(NSString *)mid
                            idx:(NSString *)idx
                        sick_id:(NSString *)sick_id
                      diag_name:(NSString *)diag_name
                           desc:(NSString *)desc
     CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
           andFailure:(FailureBlock) failure;


#pragma mark 电话预约¬——获取某月日历【20151217更新】
- (void)getOrderTelMonthListdate_m:(NSString *)date_m

     CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                     andFailure:(FailureBlock) failure;

#pragma mark 评论文章接口【20151104更新】
- (void)getCmtArtId:(NSString *)id content:(NSString *)content andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取文章评论列表【20151104更新】
- (void)getArtCmtListId:(NSString *)id page:(NSInteger )page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;


#pragma mark 电话预约——预约列表
- (void)getMyOrdertelListPage:(NSInteger )page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 电话预约——详情【20151216添加】
- (void)getMyOrdertelInfoId:(NSString *)ids andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 电话预约——处理请求【20151216添加】
- (void)processMyOrdertelId:(NSString *)ids opt:(NSInteger)opt reason:(NSString *)reason andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 公共）提交意见反馈
- (void)feedbackcontent:(NSString *)content andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark【鉴权】患者诊断——删除【20151213添加】
- (void)delPatientDiagnosismid:(NSString *)mid idx:(NSString *)idx andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark （公共）找回密码-修改密码
- (void)getPwdMobile:(NSString *)mobile sms_code:(NSString *)sms_code password:(NSString *)password andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 患者用药提醒——删除【20151213添加】
- (void)delPatientDrugId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 患者复查提醒——删除【20151213添加】
- (void)delPatientRecheckId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 患者化验——删除【20151213添加】
- (void)delPatientAssayId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 患者检查——删除【20151213添加】
- (void)delPatientCheckId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 电话预约——删除某天设置【20151105添加】
- (void)removeTimeItemsDate:(NSString *)date andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 我的银行卡——列表【20151201添加】
- (void)myBankCardListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 我的银行卡——添加【20151201添加】
- (void)addBankCardBank_id:(NSString *)bank_id bank_account:(NSString *)bank_account bank_username:(NSString *)bank_username bank_type:(NSString *)bank_type bank_bind_mobile:(NSString *)bank_bind_mobile andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 我的银行卡——删除【20151201添加】
- (void)delteBankCardId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】提现申请【20151202添加】
- (void)applyCashD_bank_id:(NSString *)d_bank_id cash:(NSString *)cash andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 患者医生咨询——未回复列表【20151218添加】
- (void)getChatNotReplyListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess)success andFailure:(FailureBlock)failure;

#pragma mark 患者医生咨询——已回复列表【20151218添加】
- (void)getChatReplyListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess)success andFailure:(FailureBlock)failure;

#pragma mark 【鉴权】我的银行卡——修改【20151201添加】
- (void)addBankCardId:(NSString *)id bank_id:(NSString *)bank_id bank_account:(NSString *)bank_account bank_username:(NSString *)bank_username bank_type:(NSString *)bank_type bank_bind_mobile:(NSString *)bank_bind_mobile andCompletionBlockWithSuccess:(CompletionBlockWithSuccess)success andFailure:(FailureBlock)failure;

#pragma mark 【（公共）第三方登录接口【20151210更新】
- (void)openLoginFornickname:(NSString *)nickname opened:(NSString *)opened open_type:(NSString *)open_type pic:(NSString *)pic sex:(NSString *)sex andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

@end
