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
    NSDictionary *paramDic = @{@"a":@"getGoodsInfo",@"id":id};
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
    NSDictionary *paramDic = @{@"a":@"addAddress",@"token":GetToken,@"mobile":mobile,@"area_ids":area_ids,@"address":address,@"zipcode":zipcode,@"is_default":is_default};
    [self GETRequestOperationWithUrlPort:@"" params:paramDic successBlock:success failureBlock:failure];
}
@end
