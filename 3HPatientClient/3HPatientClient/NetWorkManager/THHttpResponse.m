//
//  THHttpResponse.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "THHttpResponse.h"

@implementation THHttpResponse

/**
 *  解析服务端返回的数据
 *
 *  @param data resonsedata
 *
 *  @return 响应对象
 */
+ (THHttpResponse *)kyHttpResponseParse:(id)data
{
    /*
     //  gbk 编码
     NSString *dataStr = [[NSString alloc] initWithData:data encoding:-2147482062];
     NSLog(@"返回数据:%@", dataStr);
     NSDictionary *dic = [dataStr objectFromJSONString];
     
     JYHttpResponse *httpResponse = [[JYHttpResponse alloc] init];
     
     if (dic) {
     httpResponse.responseCode = [dic objectForKey:kresponseCode];
     httpResponse.message = [dic objectForKey:kerrorMessage];
     
     NSString *dataStr = [dic objectForKey:kdata];
     if (dataStr.length > 0) {
     httpResponse.dataDic = [dataStr objectFromJSONString];
     }
     }
     return httpResponse;
     */
    THHttpResponse *httpResponse = [[THHttpResponse alloc] init];
    NSDictionary *dic = data;
    if (dic) {
        /*
         接口所有参数值都要进行urlencode编码，
         返回格式为json格式，通常正常返回为：{"data":"","info":"Test OK.","status":"1"}，status 不等于1 为各种错误状态，info为状态说明，data返回接口请求的数据
         访问所有接口，如果返回 {"data":"","info":"…","status":"-99"} status为 -99 则表示需要登录或重新登录
         
         所有鉴权接口，每次请求需要传入token参数。
         
         */
        
        
        httpResponse.responseCode = [dic[@"status"] integerValue];
        httpResponse.message = [dic objectForKey:@"info"];
        id data = [dic objectForKey:@"data"];
        if ([data isKindOfClass:[NSArray class]]) {
            httpResponse.dataArray = data;
        } else if ([data isKindOfClass:[NSDictionary class]]) {
            httpResponse.dataDic = data;
        } else {
            //  如果data = nil 把原始字典返回
            httpResponse.dataDic = dic;
        }
    }
    
    return httpResponse;
    
}
/**
 *  通过返回数据的字典解析model
 *
 *  @param dic        返回数据的字典
 *  @param classModel 解析成指导model
 *
 *  @return 返回解析后的model
 */
- (id)thParseDataFromDic:(NSDictionary *)dic andModel:(Class)classModel;
{
    id class = nil;
    
    if (dic.allKeys) {
        NSError *error = nil;
        class = [MTLJSONAdapter modelOfClass:classModel fromJSONDictionary:dic error:&error];
        if (error) {
            NSLog(@"--解析model错误，%@",error);
        }
    }
    
    return class;
}

@end
