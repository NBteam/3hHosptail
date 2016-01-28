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
- (void)getMobilecode:(NSString *)mobile andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 找回密码的短信验证码
- (void)getPwdMobilecode:(NSString *)mobile andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;


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
#pragma mark 获取我的检查详情【20151213更新】
- (void)getMyCheckId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
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

#pragma mark 获取某个医生挂号预约时间表【20151217更新】
- (void)getDoctorGuahaoDatesDoctor_id:(NSString *)doctor_id page_week:(NSInteger )page_week andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【收费会员权限】挂号预约——提交预约【20151212添加】
- (void)orderGuahaoDoctor_id:(NSString *)doctor_id date:(NSString *)date date_type:(NSString *)date_type andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark （公共）找回密码-修改密码
- (void)getPwdMobile:(NSString *)mobile sms_code:(NSString *)sms_code	password:(NSString *)password andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 挂号预约——余额支付【20151221更新】
- (void)getOrderGuahaoAccountPayOrder_sn:(NSString *)order_sn andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 电话预约——余额支付【20151221更新】
- (void)getOrderTelAccountPayOrder_sn:(NSString *)order_sn andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 鉴权】健康日程¬——获取某月状况【20151221添加】
- (void)getHeathMonthTipdate_m:(NSString *)date_m andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】健康日程¬——获取某日提醒【20151221添加】
- (void)getHeathDayTipdate:(NSString *)date andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】收藏商品——提交收藏【20151223添加】
- (void)favGoodsgoods_id:(NSString *)goods_id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】收藏商品——列表【20151223添加】
- (void)getFavGoodsListPage:(NSInteger )page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【（公共）第三方登录接口【20151210更新】
- (void)openLoginFornickname:(NSString *)nickname opened:(NSString *)opened open_type:(NSString *)open_type pic:(NSString *)pic sex:(NSString *)sex andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】健康档案——获取【20151226添加】
- (void)getHealthInfoCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 健康档案——更新【20151226添加】
- (void)updateHealthInfoFirst_access_date:(NSString *)first_access_date
                                 truename:(NSString *)truename
                                      sex:(NSString *)sex
                               birth_date:(NSString *)birth_date
                               marry_info:(NSString *)marry_info
                                born_info:(NSString *)born_info
                               child_info:(NSString *)child_info
                                    hight:(NSString *)hight
                                   weight:(NSString *)weight
                              blood_sugar:(NSString *)blood_sugar
                           blood_pressure:(NSString *)blood_pressure
                                      job:(NSString *)job
                                   mobile:(NSString *)mobile
                                    email:(NSString *)email
                                   weixin:(NSString *)weixin
                                       qq:(NSString *)qq
                                  address:(NSString *)address
                                 interest:(NSString *)interest
                            huafen_guomin:(NSString *)huafen_guomin
                               flower_fav:(NSString *)flower_fav
                                    smoke:(NSString *)smoke
                                     food:(NSString *)food
                                   family:(NSString *)family
                                 sick_his:(NSString *)sick_his
                                waike_his:(NSString *)waike_his
                               guomin_his:(NSString *)guomin_his
                                 big_sick:(NSString *)big_sick
                            latest_health:(NSString *)latest_health
            andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】消费记录——列表【20151223添加】
- (void)getMyAccLogListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】配送地址——修改【20151217更新】
- (void)addAddressName:(NSString *)name id:(NSString *)id mobile:(NSString *)mobile area_ids:(NSString *)area_ids address:(NSString *)address zipcode:(NSString *)zipcode is_default:(NSString *)is_default andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】【收费会员权限】预约住院【20151109添加】
- (void)orderHospitalContent:(NSString *)content andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 获取商品频道轮播【20151021添加】
- (void)getGoodsFlashCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark【鉴权】购物车——加入商品【20151226添加】
- (void)addCartGoods_id:(NSString *)goods_id qty:(NSString *)qty andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】购物车——商品列表【20160104更新】
- (void)getCartListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】购物车——商品数量加1【20160104添加】
- (void)addCartNumGoods_id:(NSString *)goods_id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】购物车——商品数量减1【20160104添加】
- (void)decreaseCartNumGoods_id:(NSString *)goods_id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark【鉴权】购物车——删除商品【20160104添加】
- (void)removeCartCids:(NSString *)cids andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark【鉴权】订单——列表【20151226添加】
- (void)getOrderListPage:(NSInteger)page kw:(NSString *)kw type:(NSString *)type andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark【鉴权】直接购买商品【20151208更新】
- (void)getBuyGoodsId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark【鉴权】直接购买商品——提交订单【20151208更新】
- (void)getBuyGoodsPostId:(NSString *)id qty:(NSString *)qty address_id:(NSString *)address_id	 andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】购物车——提交订单【20151226添加】
- (void)getCartPostAddress_id:(NSString *)address_id cart_ids:(NSString *)cart_ids andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】充值——提交订单【20151223添加】
- (void)getPostChargeTotal:(NSString *)total andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark  获取帐号余额【20160105更新】
- (void)getMyAccountCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 预约住院——预约列表【20151221更新】
- (void)getMyOrderHospitalListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark 【鉴权】订单——确认收货【20151226添加】
- (void)orderReceiveOrder_id:(NSString *)order_id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;

#pragma mark【鉴权】消息——首页【20151222添加】
- (void)sgetMsgHomeandCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
#pragma mark【鉴权】消息——获取未读消息数【20160114更新】
- (void)getMsgNumandCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
#pragma mark【鉴权】消息——所有消息已读【20151222添加】
- (void)readAllMsgandCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
@end
