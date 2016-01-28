//
//  THNetWorkManager.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
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

#pragma mark 登陆
//http://123.57.231.12:85/api.php?a=login&mobile=13355667788&password=123
- (void)patientLoginMobile:(NSString *)mobile
                  Password:(NSString *)password
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"login",@"mobile":mobile,@"password":password};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 注册
- (void)getRegMobile:(NSString *)mobile
            Password:(NSString *)password
            Sms_code:(NSString *)sms_code
            Fromcode:(NSString *)fromcode
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
          andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"reg",@"mobile":mobile,@"password":password,@"sms_code":sms_code,@"fromcode":fromcode};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取验证码
- (void)getMobilecode:(NSString *)mobile andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
          andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMobilecode",@"mobile":mobile};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 找回密码的短信验证码
- (void)getPwdMobilecode:(NSString *)mobile andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPwdMobilecode",@"mobile":mobile};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 获取我的病史
- (void)getMySickHistoryCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                                        andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMySickHistory",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取首页信息
- (void)getHomeInfoCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                                   andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getHomeInfo"};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 获取文章列表
- (void)getArtListPage:(NSInteger)page
CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
            andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getArtList",@"page":@(page),@"pos":@"health_news"};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 获取健康资讯轮播
- (void)getHealthTopsCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                                     andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getHealthTops"};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 获取健康资讯轮播获取文章详情【20151101更新】
- (void)getArtInfoIds:(NSString *)ids CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
           andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getArtInfo",@"id":ids,@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 39	添加医生【20151118添加】
- (void)addDoctorIds:(NSString *)ids CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
          andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"addDoctor",@"doctor_id":ids,@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark获取用户资料接口【20151112更新】
- (void)getUserinfoToken:(NSString *)token CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
              andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getuserinfo",@"token":token};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark上传用户头像
- (void)getUploadFaceFile:(NSData *)file faceString:(NSString *)faceString andCompletionBlockWithSuccess:(uploadfaceBlockWithSuccess)success andFailure:(uploadfaceFailureBlock)failure andProgress:(uploadProgressBlock)progress{
    NSString *urlPath = [thServerHost stringByAppendingString:@""];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameter=@{@"a":@"uploadface",@"token":GetToken};
    [manager POST:urlPath parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:file name:@"头像.png" fileName:faceString mimeType:@"image/png"];
    } success:success failure:failure ];
}

#pragma mark 修改用户资料接口
- (void)updateUserInfoNickname:(NSString *)nickname
                      Truename:(NSString *)truename
                           Sex:(NSString *)sex
                         Birth:(NSString *)birth
                       Address:(NSString *)address
                           Tel:(NSString *)tel
                       Card_id:(NSString *)card_id
    CompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                    andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"updateuserinfo",@"token":GetToken,@"nickname":nickname,@"truename":truename,@"sex":sex,@"birth":birth,@"address":address,@"tel":tel,@"card_id":card_id};

    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取我的化验列表
- (void)getMyAssayListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyAssayList",@"token":GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取我的检查列表
- (void)getMyCheckListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success
                andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyCheckList",@"token":GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取我的化验详情【20151213更新】
- (void)getMyCheckId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyCheck",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 获取我的化验详情【20151213更新】
- (void)getMyAssayId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyAssay",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取我的用药提醒列表【20151130添加】
- (void)getMyDrugListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyDrugList",@"token":GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取我的诊断列表【20151127添加】
- (void)getMyDiagnosisListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyDiagnosisList",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取我的诊断详情【20151127添加】
- (void)getMyDiagnosisIdx:(NSString *)idx andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyDiagnosis",@"token":GetToken,@"idx":idx};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取我的复查提醒列表【20151130添加】
- (void)getMyRecheckListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyRecheckList",@"token":GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 文章点赞接口【20151030添加】
- (void)voteArtId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"voteArt",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 我的预约挂号列表【20151212添加】
- (void)getMyOrderguahaoListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyOrderguahaoList",@"token":GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 电话预约——我的预约列表【20151216更新】
- (void)getMyOrderTelListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyOrderTelList",@"token":GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取医生列表【20151106添加】
- (void)getDoctorListPage:(NSInteger)page kw:(NSString *)kw andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getDoctorList",@"token":GetToken,@"page":@(page),@"kw":kw};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取医生详情【20151109更新】
- (void)getDoctorInfoId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getDoctorInfo",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取商品列表【20151021添加】
- (void)getGoodsListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getGoodsList",@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取商品详情【20151023更新】
- (void)getGoodsFlashId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getGoodsInfo",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 评论文章接口【20151104更新】
- (void)getCmtArtId:(NSString *)id content:(NSString *)content andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"cmtArt",@"token":GetToken,@"id":id,@"content":content};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 配送地址——列表【20151217更新】
- (void)getAddressListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getAddressList",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 配送地址——添加【20151217更新】
- (void)getAddAddressName:(NSString *)name mobile:(NSString *)mobile area_ids:(NSString *)area_ids address:(NSString *)address zipcode:(NSString *)zipcode is_default:(NSString *)is_default andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"addAddress",@"token":GetToken,@"mobile":mobile,@"area_ids":area_ids,@"address":address,@"zipcode":zipcode,@"is_default":is_default,@"name":name};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 设置默认【20151208添加】
- (void)setDefaultAddressId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"addAddress",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取城市列表
- (void)getCityListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getareaList"};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 获取二级城市列表
- (void)getAreaListId:(NSString *)id suball:(NSInteger)suball andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getareaList",@"id":id,@"suball":@(suball)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 配送地址——删除【20151208添加】
- (void)getRemoveAddressId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"removeAddress",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【收费会员权限】电话预约——提交预约【20151216更新】
- (void)getAddOrderTelOrder_tel_id:(NSString *)order_tel_id	desc  :(NSString *)desc andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"addOrderTel",@"token":GetToken,@"order_tel_id":order_tel_id,@"desc":desc};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【收费会员权限】我的医生列表【20151118添加】
- (void)getMyDoctorsPage:(NSInteger )page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"mydoctors",@"token":GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark #pragma mark 获取医生某天预约情况列表【20151112添加】
- (void)getDoctorTelTimeitemsDoctor_id:(NSString *)doctor_id date:(NSString *)date andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getDoctorTelTimeitems",@"token":GetToken,@"doctor_id":doctor_id,@"date":date};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 获取文章评论列表【20151104更新】
- (void)getArtCmtListId:(NSString *)id page:(NSInteger )page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getArtCmtList",@"id":id,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取某个医生挂号预约时间表【20151217更新】
- (void)getDoctorGuahaoDatesDoctor_id:(NSString *)doctor_id page_week:(NSInteger )page_week andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getDoctorGuahaoDates",@"doctor_id":doctor_id,@"token":GetToken,@"page_week":@(page_week)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【收费会员权限】挂号预约——提交预约【20151212添加】
- (void)orderGuahaoDoctor_id:(NSString *)doctor_id date:(NSString *)date date_type:(NSString *)date_type andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"orderGuahao",@"doctor_id":doctor_id,@"token":GetToken,@"date":date,@"date_type":date_type};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark （公共）找回密码-修改密码
- (void)getPwdMobile:(NSString *)mobile sms_code:(NSString *)sms_code	password:(NSString *)password andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getPwd",@"mobile":mobile,@"sms_code":sms_code,@"password":password};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 挂号预约——余额支付【20151221更新】
- (void)getOrderGuahaoAccountPayOrder_sn:(NSString *)order_sn andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"orderGuahao",@"order_sn":order_sn,@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 电话预约——余额支付【20151221更新】
- (void)getOrderTelAccountPayOrder_sn:(NSString *)order_sn andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"orderTelAccountPay",@"order_sn":order_sn,@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 鉴权】健康日程¬——获取某月状况【20151221添加】
- (void)getHeathMonthTipdate_m:(NSString *)date_m andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getHeathMonthTip",@"date_m":date_m,@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 【鉴权】健康日程¬——获取某日提醒【20151221添加】
- (void)getHeathDayTipdate:(NSString *)date andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getHeathDayTip",@"date":date,@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 【鉴权】收藏商品——提交收藏【20151223添加】
- (void)favGoodsgoods_id:(NSString *)goods_id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"favGoods",@"goods_id":goods_id,@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 【鉴权】收藏商品——列表【20151223添加】
- (void)getFavGoodsListPage:(NSInteger )page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getFavGoodsList",@"page":@(page),@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 【（公共）第三方登录接口【20151210更新】
//	nickname			昵称
//	opened				第三方用户统一ID
//	open_type			第三方类型（weixin、qq、weibo）
//	pic					头像地址
//	sex					性别，0保密，1男，2女
- (void)openLoginFornickname:(NSString *)nickname opened:(NSString *)opened open_type:(NSString *)open_type pic:(NSString *)pic sex:(NSString *)sex andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"openLogin",@"nickname":nickname,@"openid":opened,@"open_type":open_type,@"pic":pic,@"sex":sex};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【鉴权】健康档案——获取【20151226添加】
- (void)getHealthInfoCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getHealthInfo",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 健康档案——获取【20151226添加】
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
            andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"updateHealthInfo",@"token":GetToken,@"first_access_date":first_access_date,@"truename":truename,@"sex":sex,@"birth_date":birth_date,@"marry_info":marry_info,@"born_info":born_info,@"child_info":child_info,@"hight":hight,@"weight":weight,@"blood_sugar":blood_sugar,@"blood_pressure":blood_pressure,@"job":job,@"mobile":mobile,@"email":email,@"weixin":weixin,@"qq":qq,@"address":address,@"interest":interest,@"huafen_guomin":huafen_guomin,@"flower_fav":flower_fav,@"smoke":smoke,@"food":food,@"family":family,@"sick_his":sick_his,@"waike_his":waike_his,@"guomin_his":guomin_his,@"big_sick":big_sick,@"latest_health":latest_health};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【鉴权】消费记录——列表【20151223添加】
- (void)getMyAccLogListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"myAccLogList",@"page":@(page),@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 【鉴权】配送地址——修改【20151217更新】
- (void)addAddressName:(NSString *)name id:(NSString *)id mobile:(NSString *)mobile area_ids:(NSString *)area_ids address:(NSString *)address zipcode:(NSString *)zipcode is_default:(NSString *)is_default andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"editAddress",@"token":GetToken,@"mobile":mobile,@"area_ids":area_ids,@"address":address,@"zipcode":zipcode,@"is_default":is_default,@"name":name,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【鉴权】【收费会员权限】预约住院【20151109添加】
- (void)orderHospitalContent:(NSString *)content andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"orderHospital",@"token":GetToken,@"content":content};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 获取商品频道轮播【20151021添加】
- (void)getGoodsFlashCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getGoodsFlash",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark【鉴权】购物车——加入商品【20151226添加】
- (void)addCartGoods_id:(NSString *)goods_id qty:(NSString *)qty andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"addCart",@"token":GetToken,@"goods_id":goods_id,@"qty":qty};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【鉴权】购物车——商品列表【20160104更新】
- (void)getCartListCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getCartList",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【鉴权】购物车——商品数量加1【20160104添加】
- (void)addCartNumGoods_id:(NSString *)goods_id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"addCartNum",@"token":GetToken,@"goods_id":goods_id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【鉴权】购物车——商品数量减1【20160104添加】
- (void)decreaseCartNumGoods_id:(NSString *)goods_id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"decreaseCartNum",@"token":GetToken,@"goods_id":goods_id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark【鉴权】购物车——删除商品【20160104添加】
- (void)removeCartCids:(NSString *)cids andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"removeCart",@"token":GetToken,@"cids":cids};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark【鉴权】订单——列表【20151226添加】
- (void)getOrderListPage:(NSInteger)page kw:(NSString *)kw type:(NSString *)type andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getOrderList",@"token":GetToken,@"page":@(page),@"kw":kw,@"type":type};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark【鉴权】直接购买商品【20151208更新】
- (void)getBuyGoodsId:(NSString *)id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"BuyGoods",@"token":GetToken,@"id":id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark【鉴权】直接购买商品——提交订单【20151208更新】
- (void)getBuyGoodsPostId:(NSString *)id qty:(NSString *)qty address_id:(NSString *)address_id	 andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"BuyGoodsPost",@"token":GetToken,@"id":id,@"qty":qty,@"address_id":address_id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【鉴权】购物车——提交订单【20151226添加】
- (void)getCartPostAddress_id:(NSString *)address_id cart_ids:(NSString *)cart_ids andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"cartPost",@"token":GetToken,@"cart_ids":cart_ids,@"address_id":address_id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【鉴权】购物车——提交订单【20151226添加】
- (void)getPostChargeTotal:(NSString *)total andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"postCharge",@"token":GetToken,@"total":total};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark  获取帐号余额【20160105更新】
- (void)getMyAccountCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyAccount",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark 预约住院——预约列表【20151221更新】
- (void)getMyOrderHospitalListPage:(NSInteger)page andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMyOrderHospitalList",@"token":GetToken,@"page":@(page)};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
#pragma mark 【鉴权】订单——确认收货【20151226添加】
- (void)orderReceiveOrder_id:(NSString *)order_id andCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"orderReceive",@"token":GetToken,@"order_id":order_id};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark【鉴权】消息——首页【20151222添加】
- (void)sgetMsgHomeandCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMsgHome",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}

#pragma mark【鉴权】消息——获取未读消息数【20160114更新】
- (void)getMsgNumandCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"getMsgNum",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
    
}
#pragma mark【鉴权】消息——所有消息已读【20151222添加】
- (void)readAllMsgandCompletionBlockWithSuccess:(CompletionBlockWithSuccess) success andFailure:(FailureBlock) failure{
    NSDictionary *paramDic = @{@"a":@"readAllMsg",@"token":GetToken};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
@end
