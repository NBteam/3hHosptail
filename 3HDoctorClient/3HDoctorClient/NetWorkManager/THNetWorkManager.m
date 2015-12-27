//
//  THNetWorkManager.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "THNetWorkManager.h"
@interface THNetWorkManager ()
{
    NSString *URLPath;
}
@property (nonatomic,strong) AFHTTPSessionManager *httpSessionManager;
//  保存上一个请一个对象
@property (nonatomic,strong) NSURLSessionDataTask *previousURLSessionDataTask;

@end

static THNetWorkManager *thNetWorkManager = nil;
@implementation THNetWorkManager

+ (id)shareNetWork
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thNetWorkManager = [[THNetWorkManager alloc] init];
    });
    return thNetWorkManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thNetWorkManager = [super allocWithZone:zone];
    });
    return thNetWorkManager;
}

- (instancetype)init
{
    thNetWorkManager = [super init];
    if (thNetWorkManager) {
        
    }
    return thNetWorkManager;
}

- (id)copy
{
    return [[self class] shareNetWork];
}

- (id)mutableCopy
{
    return [[self class] shareNetWork];
}

- (AFHTTPSessionManager *)httpSessionManager
{
    if (!_httpSessionManager) {
        _httpSessionManager = [AFHTTPSessionManager manager];
        
        //返回json
        _httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        //   配置响应序列化器的可接受内容类型acceptableContentTypes
        _httpSessionManager.responseSerializer.acceptableContentTypes = [_httpSessionManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"text/plain", @"text/html", nil]];
        _httpSessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        _httpSessionManager.securityPolicy.allowInvalidCertificates = YES;//  不验证ssl证书
        
        _httpSessionManager.requestSerializer.timeoutInterval = 10;
        
    }
    return _httpSessionManager;
}

- (void)addHeadFieldParamsDic:(NSDictionary *)headerFieldParamsDic
{
    if (headerFieldParamsDic) {
        for (NSString *key in headerFieldParamsDic.allKeys) {
            [self.httpSessionManager.requestSerializer setValue:[headerFieldParamsDic stringForKey:key] forHTTPHeaderField:key];
        }
    }
}

- (NSDictionary *)defaultHeaderField
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:Token];
    if (token == nil) {
        token = @"aaa";
    }
    return @{@"token":token,@"uuid":UUID};
}

//POST一个请求
- (void)POSTRequestOperationWithUrlPort:(NSString *)urlPort
                                 params:(NSDictionary *)params
                           successBlock:(CompletionBlockWithSuccess)successBlock
                           failureBlock:(FailureBlock)failureBlock
{
    NSString *urlPath = [thServerHost stringByAppendingString:urlPort];
    
    [self requestOperation:urlPath andParams:params andHeaderFieldParams:nil andHttpRequestMethod:HttpRequestMethodPOST andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask,THHttpResponse *response){
        
        if (successBlock) {
            successBlock(urlSessionDataTask,response);
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask,NSError *error){
        if (failureBlock) {
            failureBlock(urlSessionDataTask,error);
        }
    }];
}

- (NSURLSessionDataTask *)requestOperation:(NSString *)requestUrl andParams:(NSDictionary *)paramDic andHeaderFieldParams:(NSDictionary *)headerFieldParamsDic andHttpRequestMethod:(HttpRequestMethod)httpRequestMethod andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure;
{
    
    //  添加header请求头
    if (headerFieldParamsDic) {
        [self addHeadFieldParamsDic:headerFieldParamsDic];
    }
    
    //  默认添加UUID和token参数
    [self addHeadFieldParamsDic:[self defaultHeaderField]];
    
    NSURLSessionDataTask *urlSessionDataTask = nil;
    if (httpRequestMethod == HttpRequestMethodPOST) {
        
        urlSessionDataTask = [self.httpSessionManager POST:requestUrl parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if (success) {
                
                THHttpResponse *response = [THHttpResponse kyHttpResponseParse:responseObject];
                WeakSelf(THNetWorkManager);
                //访问所有接口，如果返回 {"data":"","info":"…","status":"-99"} status为 -99 则表示需要登录或重新登录
                
                //所有鉴权接口，每次请求需要传入token参数。
                if (response.responseCode == -99) {
                    //  保存上一次请求
                    self.previousURLSessionDataTask = urlSessionDataTask;
                    
                    [weakSelf getTokenForCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
                        
                        if (response.responseCode == 1 ) {
                            [weakSelf.previousURLSessionDataTask resume];
                        }
                        self.previousURLSessionDataTask = nil;
                        
                    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
                        if (failure) {
                            failure(urlSessionDataTask,error);
                        }
                    }];
                    return ;
                    
                }
                success(task,response);
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(task,error);
            }
        }];
        
    } else if (httpRequestMethod == HttpRequestMethodGET) {
        
        urlSessionDataTask = [self.httpSessionManager GET:requestUrl parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if (success) {
                THHttpResponse *response = [THHttpResponse kyHttpResponseParse:responseObject];
                
                WeakSelf(THNetWorkManager);
                //访问所有接口，如果返回 {"data":"","info":"…","status":"-99"} status为 -99 则表示需要登录或重新登录
                
                //所有鉴权接口，每次请求需要传入token参数。
                if (response.responseCode == -99) {
                    //  保存上一次请求
                    self.previousURLSessionDataTask = urlSessionDataTask;
                    
                    [weakSelf getTokenForCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
                        
                        if (response.responseCode == 1 ) {
                            [weakSelf.previousURLSessionDataTask resume];
                        }
                        self.previousURLSessionDataTask = nil;
                        
                    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
                        if (failure) {
                            failure(urlSessionDataTask,error);
                        }
                    }];
                    return ;
                    
                }
                success(task,response);
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(task,error);
            }
        }];
        
    }
    //  请求接口
    //    [urlSessionDataTask resume];
    
    return urlSessionDataTask;
    
}

- (void)getTokenForCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock)failure
{
    NSString *urlPath = [thServerHost stringByAppendingPathComponent:@"getToken.json"];
    
    NSDictionary *headDic = @{@"uuid":UUID};
    
    [self requestOperation:urlPath andParams:nil andHeaderFieldParams:headDic andHttpRequestMethod:HttpRequestMethodPOST andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        
        //  保存访问token?""
        NSString *token = [response.dataDic stringForKey:@"token"];
        if (token.length>0) {
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:Token];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        if (success) {
            success(urlSessionDataTask,response);
        }
        
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        if (failure) {
            failure(urlSessionDataTask,error);
        }
    }];
}


/// 转换枚举类型对应的请求方式
- (NSString *)convertHttpPostMethodEnum:(HttpRequestMethod) httpRequestMethod
{
    if (httpRequestMethod == HttpRequestMethodGET) {
        return @"GET";
    } else if (httpRequestMethod == HttpRequestMethodPOST) {
        return @"POST";
    }
    return @"GET";
}

//GET请求方式

- (void)GETRequestOperationWithUrlPort:(NSString *)urlPort
                                 params:(NSDictionary *)params
                           successBlock:(CompletionBlockWithSuccess)successBlock
                           failureBlock:(FailureBlock)failureBlock
{
    NSString *urlPath = [thServerHost stringByAppendingString:urlPort];
    
    [self requestOperation:urlPath andParams:params andHeaderFieldParams:nil andHttpRequestMethod:HttpRequestMethodGET andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask,THHttpResponse *response){
        
        if (successBlock) {
            successBlock(urlSessionDataTask,response);
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask,NSError *error){
        if (failureBlock) {
            failureBlock(urlSessionDataTask,error);
        }
    }];
}

#pragma mark 获取城市列表
- (void)getCityListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getcityList"};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
    
}
/**
 *	获取客户端版本
 */
- (void)getDeviceVersiontypeCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getclientver",@"type":@"2"};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 *	注册
 * @param mobile      手机号
 * @param code        验证码
 * @param password    密码
 * @param fromcode    邀请码
 */
- (void)getRegisteredMobile:(NSString *)mobile password:(NSString *)password code:(NSString *)code fromcode:(NSString *)fromcode andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"reg",@"mobile":mobile,@"password":password,@"sms_code":code};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 *	获取验证码
 * @param mobile      手机号
 */
- (void)getCodeMobile:(NSString *)mobile andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMobilecode",@"mobile":mobile};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 登录
 * @param mobile      手机号
 * @param password    密码
 */
- (void)getLoginMobile:(NSString *)mobile password:(NSString *)password andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"login",@"mobile":mobile,@"password":password};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取首页信息
 *
 */
- (void)getHomeCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getHomeInfo"};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取职称列表
 *
 */
- (void)getJobposListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getJobposList"};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取医院科室
 *
 */
- (void)getHospitalDeptLisPid:(NSString *)pid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getHospitalDeptList",@"pid":pid};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取医院列表
 *
 */
- (void)getHospitalLisPid:(NSString *)pid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getHospitalList",@"pid":pid};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 我的钱包
 *
 */
- (void)getMyAccountCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyAccount",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取患者病史
 *
 */
- (void)getPatientSickHistoryMid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPatientSickHistory",@"mid":mid,@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 编辑患者病史
 * @param mid         患者ID
 * @param guomin      过敏史
 * @param blood_type  血型
 * @param desc        病情描述
 */
- (void)editPatientSickHistoryMid:(NSString *)mid guomin:(NSString *)guomin blood_type:(NSString *)blood_type desc:(NSString *)desc andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"editPatientSickHistory",@"mid":mid,@"guomin":guomin,@"blood_type":blood_type,@"desc":desc,@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取文章列表
 * @param page        分页
 * @param pos         分页位置
 */
- (void)getArtListPage:(NSInteger)page pos:(NSString *)pos andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getArtList",@"page":@(page),@"pos":pos};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取文章详情
 * @param id        id
 */
- (void)getArtInfoId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getArtInfo",@"id":id,Token:GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 我的患者列表
 * @param page        分页
 */
- (void)getMyPatientsPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"myPatients",@"page":@(page),Token:GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 文章点赞接口
 * @param id        文章Id
 */
- (void)getVoteArtId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"voteArt",@"id":id,Token:GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取用户资料接口
 */
- (void)getUserInfoCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getuserinfo",Token:GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
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
- (void)getUpdateUserInfoTruename:(NSString *)truename sex:(NSString *)sex hospital:(NSString *)hospital department:(NSString *)department job_title:(NSString *)job_title sign_word:(NSString *)sign_word	work_week:(NSString *)work_week work_price:(NSString *)work_price area_ids:(NSString *)area_ids andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"updateuserinfo",Token:GetToken,@"truename":truename,@"sex":sex,@"hospital":hospital,@"department":department,@"job_title":job_title,@"work_week":work_week,@"work_price":work_price,@"area_ids":area_ids,@"sign_word":sign_word};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 我的患者请求列表
 * @param page  分页
 */
- (void)getmyPatientReqsPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"myPatientReqs",Token:GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取患者化验列表
 * @param page  分页
 * @param mid   患者ID
 */
- (void)getPatientAssayListPage:(NSInteger)page mid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPatientAssayList",Token:GetToken,@"page":@(page),@"mid":mid};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取患者检查列表
 * @param page  分页
 * @param mid   患者ID
 */
- (void)getPatientCheckListPage:(NSInteger)page mid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPatientCheckList",Token:GetToken,@"page":@(page),@"mid":mid};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取患者用药提醒列表
 * @param page  分页
 * @param mid   患者ID
 */
- (void)getPatientDrugListPage:(NSInteger)page mid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPatientDrugList",Token:GetToken,@"page":@(page),@"mid":mid};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取患者复查提醒列表
 * @param page  分页
 * @param mid   患者ID
 */
- (void)getPatientRecheckListPage:(NSInteger)page mid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPatientRecheckList",Token:GetToken,@"page":@(page),@"mid":mid};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 处理患者添加请求
 * @param req_id    请求ID
 * @param process	1通过，-1拒绝
 */
- (void)getMyPatientReqProcessReq_id:(NSString *)req_id process:(NSInteger)process andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"myPatientReqProcess",Token:GetToken,@"process":@(process),@"req_id":req_id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取患者化验详情
 * @param mid   患者ID
 * @param id	记录ID
 */
- (void)getPatientAssayMid:(NSString *)mid id:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPatientAssay",Token:GetToken,@"id":id,@"mid":mid};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取患者检查详情
 * @param mid   患者ID
 * @param id	记录ID
 */
- (void)getPatientCheckMid:(NSString *)mid id:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPatientCheck",Token:GetToken,@"id":id,@"mid":mid};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取患者诊断列表
 * @param mid   患者ID
 */
- (void)getPatientDiagnosisListMid:(NSString *)mid andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPatientDiagnosisList",Token:GetToken,@"mid":mid};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 获取医疗资讯轮播
 */
- (void)getDoctorTopsCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getDoctorTops"};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 我的预约挂号列表
 * @param page   分页
 */
- (void)getMyOrderguahaoListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyOrderguahaoList",Token:GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 我的预约挂号详情
 * @param id   id
 */
- (void)getMyOrderguahaoInfoId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyOrderguahaoInfo",Token:GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 我的挂号预约——处理请求
 * @param id   id
 * @param opt  1同意，-1拒绝
 */
- (void)processMyOrderguahaoId:(NSString *)id opt:(NSInteger)opt andCompletionBlockWithSuccess:(CompletionBlockWithSuccess)success andFailure:(FailureBlock)failure{
    NSDictionary *paramDic = @{@"a":@"processMyOrderguahao",Token:GetToken,@"id":id,@"opt":@(opt)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
/**
 * 上传用户头像
 */
- (void)getUploadFaceFile:(NSData *)file faceString:(NSString *)faceString andCompletionBlockWithSuccess:(uploadfaceBlockWithSuccess)success andFailure:(uploadfaceFailureBlock)failure andProgress:(uploadProgressBlock)progress{
    NSString *urlPath = [thServerHost stringByAppendingString:@""];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameter=@{@"a":@"uploadface",Token:GetToken};
    [manager POST:urlPath parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:file name:@"头像.png" fileName:faceString mimeType:@"image/png"];
        
    } success:success failure:failure ];
}

#pragma mark 添加患者化验
- (void)addPatientAssayMid:(NSString *)mid Name:(NSString *)name Hospital:(NSString *)hospital Time:(NSString *)time File:(NSMutableArray *)files faceString:(NSMutableArray *)faceString andCompletionBlockWithSuccess:(uploadfaceBlockWithSuccess)success andFailure:(uploadfaceFailureBlock)failure andProgress:(uploadProgressBlock)progress{
    
    NSString *urlPath = [thServerHost stringByAppendingString:@""];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameter=@{@"a":@"addPatientAssay",Token:GetToken,@"mid":mid,@"name":name,@"hospital":hospital,@"addtime":time};
    
    [manager POST:urlPath parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i<files.count; i++) {
            NSString *str = [NSString stringWithFormat:@"img%i",i];
            [formData appendPartWithFileData:faceString[i] name:str fileName:files[i] mimeType:@"image/png"];
        }
        
    } success:success failure:failure ];
    
}

#pragma mark 添加患者检查
- (void)addPatientCheckMid:(NSString *)mid Name:(NSString *)name Hospital:(NSString *)hospital Time:(NSString *)time File:(NSMutableArray *)files faceString:(NSMutableArray *)faceString andCompletionBlockWithSuccess:(uploadfaceBlockWithSuccess)success andFailure:(uploadfaceFailureBlock)failure andProgress:(uploadProgressBlock)progress{
    NSString *urlPath = [thServerHost stringByAppendingString:@""];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameter=@{@"a":@"addPatientCheck",Token:GetToken,@"mid":mid,@"name":name,@"hospital":hospital,@"addtime":time};
    
    [manager POST:urlPath parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i<files.count; i++) {
            NSString *str = [NSString stringWithFormat:@"img%i",i];
            [formData appendPartWithFileData:faceString[i] name:str fileName:files[i] mimeType:@"image/png"];
        }
        
    } success:success failure:failure ];
}

#pragma mark 获取患者化验和检查详情【20151213更新】
- (void)getPatientCheckIds:(NSString *)ids Index:(NSInteger)index  CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic;
    if (index == 0) {//化验
        paramDic = @{@"a":@"getPatientAssay",Token:GetToken,@"id":ids};
    }else{//检查
        paramDic = @{@"a":@"getPatientCheck",Token:GetToken,@"id":ids};
    }
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

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
               andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"addPatientDrug",Token:GetToken,@"mid":mid,@"name":name,@"use_level":use_level,@"use_num":use_num,@"use_time":use_time,@"use_method":use_method,@"start_time":start_time,@"end_time":end_time};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 电话预约——编辑某天设置【20151105添加】

- (void)addTimeItemsdate:(NSString *)date
              start_time:(NSString *)start_time
                end_time:(NSString *)end_time
                 minutes:(NSString *)minutes
                   price:(CGFloat)price
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
              andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"addTimeItems",Token:GetToken,@"date":date,@"start_time":start_time,@"end_time":end_time,@"minutes":minutes,@"price":@(price)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
    
}

#pragma mark 电话预约¬——获取某天设置【20151105添加】
- (void)getOrderTelSetdate:(NSString *)date
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getOrderTelSet",Token:GetToken,@"date":date};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 添加患者复查提醒【20151129添加】
- (void)addPatientRechecktmid:(NSString *)mid
                   check_date:(NSString *)check_date
                   check_time:(NSString *)check_time
                     hospital:(NSString *)hospital
                     prj_name:(NSString *)prj_name
   CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                   andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"addPatientRecheck",Token:GetToken,@"mid":mid,@"check_date":check_date,@"check_time":check_time,@"hospital":hospital,@"prj_name":prj_name};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 患者诊断——详情
- (void)getPatientDiagnosismid:(NSString *)mid
                           idx:(NSString *)idx
    CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                    andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPatientDiagnosis",Token:GetToken,@"mid":mid,@"idx":idx};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 疾病列表
- (void)getSickListshort:(NSString *)shorts
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
              andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getSickList",@"short":shorts};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 疾病详情
- (void)getSickInfoId:(NSString *)ids
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
           andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getSickInfo",@"id":ids};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 编辑患者诊断【20151127添加】
- (void)editPatientDiagnosismid:(NSString *)mid
                            idx:(NSString *)idx
                        sick_id:(NSString *)sick_id
                      diag_name:(NSString *)diag_name
                           desc:(NSString *)desc
     CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                     andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"editPatientDiagnosis",Token:GetToken,@"mid":mid,@"idx":idx,@"sick_id":sick_id,@"diag_name":diag_name,@"desc":desc};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 电话预约¬——获取某月日历【20151217更新】
- (void)getOrderTelMonthListdate_m:(NSString *)date_m

        CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                        andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getOrderTelMonthList",Token:GetToken,@"date_m":date_m};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 评论文章接口【20151104更新】
- (void)getCmtArtId:(NSString *)id content:(NSString *)content andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"cmtArt",@"token":GetToken,@"id":id,@"content":content};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 获取文章评论列表【20151104更新】
- (void)getArtCmtListId:(NSString *)id page:(NSInteger )page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getArtCmtList",@"id":id,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 电话预约——预约列表
- (void)getMyOrdertelListPage:(NSInteger )page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyOrdertelList",@"token":GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
    
}

#pragma mark 电话预约——详情【20151216添加】

- (void)getMyOrdertelInfoId:(NSString *)ids andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyOrdertelInfo",@"token":GetToken,@"id":ids};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 电话预约——处理请求【20151216添加】1同意，-1拒绝
- (void)processMyOrdertelId:(NSString *)ids opt:(NSInteger)opt reason:(NSString *)reason andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic;
    if (opt == 1) {
        paramDic = @{@"a":@"processMyOrdertel",@"token":GetToken,@"id":ids,@"opt":@(opt)};
    }else{
        paramDic = @{@"a":@"processMyOrdertel",@"token":GetToken,@"id":ids,@"opt":@(opt),@"reason":reason};
    }
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 公共）提交意见反馈
- (void)feedbackcontent:(NSString *)content andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"feedback",@"token":GetToken,@"content":content};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark【鉴权】患者诊断——删除【20151213添加】
- (void)delPatientDiagnosismid:(NSString *)mid idx:(NSString *)idx andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"delPatientDiagnosis",@"token":GetToken,@"mid":mid,@"idx":idx};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark （公共）找回密码-修改密码
- (void)getPwdMobile:(NSString *)mobile sms_code:(NSString *)sms_code	password:(NSString *)password andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPwd",@"mobile":mobile,@"sms_code":sms_code,@"password":password};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 患者用药提醒——删除【20151213添加】
- (void)delPatientDrugId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"delPatientDrug",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 患者复查提醒——删除【20151213添加】
- (void)delPatientRecheckId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"delPatientRecheck",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 患者化验——删除【20151213添加】
- (void)delPatientAssayId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"delPatientAssay",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 患者检查——删除【20151213添加】
- (void)delPatientCheckId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"delPatientCheck",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 电话预约——删除某天设置【20151105添加】
- (void)removeTimeItemsDate:(NSString *)date andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"removeTimeItems",@"token":GetToken,@"date":date};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 我的银行卡——列表【20151201添加】
- (void)myBankCardListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"myBankCardList",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 我的银行卡——添加【20151201添加】
- (void)addBankCardBank_id:(NSString *)bank_id bank_account:(NSString *)bank_account bank_username:(NSString *)bank_username bank_type:(NSString *)bank_type bank_bind_mobile:(NSString *)bank_bind_mobile andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"addBankCard",@"token":GetToken,@"bank_id":bank_id,@"bank_username":bank_username,@"bank_type":bank_type,@"bank_bind_mobile":bank_bind_mobile,@"bank_account":bank_account};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 我的银行卡——删除【20151201添加】
- (void)delteBankCardId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"delteBankCard",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【鉴权】提现申请【20151202添加】
- (void)applyCashD_bank_id:(NSString *)d_bank_id cash:(NSString *)cash andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"delteBankCard",@"token":GetToken,@"d_bank_id":d_bank_id,@"cash":cash};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 患者医生咨询——未回复列表【20151218添加】
- (void)getChatNotReplyListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess)success andFailure:(FailureBlock)failure{
    NSDictionary *paramDic = @{@"a":@"getChatNotReplyList",@"token":GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 患者医生咨询——已回复列表【20151218添加】
- (void)getChatReplyListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess)success andFailure:(FailureBlock)failure{
    NSDictionary *paramDic = @{@"a":@"getChatReplyList",@"token":GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
@end
