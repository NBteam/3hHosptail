//
//  WithdrawalViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//
extern NSInteger payIndex;
#import "WithdrawalViewController.h"
#import "AppDelegate.h"
#import "WIthFinishViewController.h"

#import "WXApi.h"
#import "CommonUtil.h"
#import "GDataXMLNode.h"

/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
NSString * const WXAppId = @"wx0863c23f9e3f8d86";

/**
 *  申请微信支付成功后，发给你的邮件里的微信支付商户号
 */
NSString * const WXPartnerId = @"1295948201";

/** API密钥 去微信商户平台设置--->账户设置--->API安全， 参与签名使用 */
NSString * const WXAPIKey = @"cygcDzUzi6y2POstWmOBa7EitvsPOTTW";

/** 获取prePayId的url, 这是官方给的接口 */
NSString * const getPrePayIdUrl = @"https://api.mch.weixin.qq.com/pay/unifiedorder";


@interface WithdrawalViewController ()
@property (nonatomic, strong) UILabel * labPrice;
@property (nonatomic, strong) UITextField * textPrice;
@property (nonatomic, strong) UILabel * labText;
@property (nonatomic, strong) UIView * whiteView;
@property (nonatomic, strong) UILabel * labLine1;
@property (nonatomic, strong) UILabel * labLine2;
@property (nonatomic, strong) UILabel * labLine3;
@property (nonatomic, strong) UIButton * btnZHB;
@property (nonatomic, strong) UIButton * btnWX;
@property (nonatomic, strong) UILabel * labZHB;
@property (nonatomic, strong) UILabel * labWX;
@property (nonatomic, strong) UIImageView * imgZFB;
@property (nonatomic, strong) UILabel * labZFB;
@property (nonatomic, strong) UIImageView * imgWX;
@property (nonatomic, strong) UILabel * labWXInfo;
@property (nonatomic, strong) UIButton * btnSure;

@property (nonatomic, strong) NSString * priceStr;
@end

@implementation WithdrawalViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"CZ" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"保存"];
    [self.view addSubview:self.labPrice];
    [self.view addSubview:self.textPrice];
    [self.view addSubview:self.labText];
    [self.view addSubview:self.whiteView];
    [self.whiteView addSubview:self.labLine1];
    [self.whiteView addSubview:self.labLine2];
    [self.whiteView addSubview:self.labLine3];
    [self.whiteView addSubview:self.btnZHB];
    [self.whiteView addSubview:self.btnWX];
    [self.whiteView addSubview:self.imgZFB];
    [self.whiteView addSubview:self.labZFB];
    [self.whiteView addSubview:self.imgWX];
    [self.whiteView addSubview:self.labWXInfo];
    [self.view addSubview:self.btnSure];
    payIndex = 1;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CZAction) name:@"CZ" object:nil];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableKey)];
    [self.tableView addGestureRecognizer:tap];
}

- (void)rightAction{
    [self getWeChatPayWithOrderName:@"郑彦华" price:@"1"];
    //getWeChatPayWithOrderName
    
}

#pragma mark - 充值结果
- (void)rechargeEvent:(NSNotification *)noti
{
    [lhSharePay addActivityView:self.view];
    NSLog(@"请求结果 %@",noti.userInfo);
    [[NSNotificationCenter defaultCenter]removeObserver:self name:noti.name object:nil];
    if (!noti.userInfo || [noti.userInfo class] == [[NSNull alloc]class]) {
        NSLog(@"请求失败，网络或服务器异常");
    }
    else if ([[noti.userInfo objectForKey:@"flag"]integerValue] == 1) {
        
        NSDictionary * pDic = [noti.userInfo objectForKey:@"data"];
        NSMutableDictionary * tempDi = [NSMutableDictionary dictionary];
        NSString * productStr = [NSString stringWithFormat:@"The One逗币充值(%@)",@"10元=120逗币"];
        [tempDi setObject:[pDic objectForKey:@"id"] forKey:@"id"];
        [tempDi setObject:@"1000" forKey:@"money"];
        [tempDi setObject:@"2000" forKey:@"present"];
        [tempDi setObject:productStr forKey:@"productName"];
        [tempDi setObject:productStr forKey:@"productDescription"];
        [tempDi setObject:[pDic objectForKey:@"orderNo"] forKey:@"orderCode"];
        
        NSDictionary * orderDic = tempDi;
        
        NSMutableDictionary * payDic = [NSMutableDictionary dictionaryWithDictionary:[pDic objectForKey:@"wxParams"]];
        [payDic setObject:[payDic objectForKey:@"recharge_notify_url"] forKey:@"notify_url"];
        
#warning payDic和orderDic配置
        /*
         //payDic和orderDic请求实例
         NSDictionary * payDic = @{
         @"api_key":@"在商户平台自己设置的API秘钥",
         @"app_id":@"appID",
         @"app_secret":@"appSecret(可不要)",
         @"mch_id":@"腾讯发商户号",
         @"notify_url":@"回调页面（支付成功后微信会请求改回调页面，服务器需要在该页面中对支付成功进行处理。例如为余额充值，则要给用户增加余额；例如为购买商品，则要为用户增加订单（一般这儿是把之前已生成的订单改一个状态））"
         };
         NSDictionary * orderDic = @{
         @"enable":@"1",
         @"id":@"df2b38795ccd40cea71c2e859aec7e5c",
         @"money":@"1000",
         @"orderCode":@"RE20150713135304624",
         @"rechargeRule_id":@"1",
         @"remark":@"微信充值",
         @"status":@"",
         @"successTime":@"",
         @"time":@"1436766784625",
         @"users_id":@"a38d4da064054e99840efdd91280ee35",
         @"way":@"2",
         @"productName":@"微信充值（自定义）",
         @"productDescription":@"微信充值（自定义）"};
         */
        
        //下单成功，调用微信支付
        [[lhSharePay sharePay]wxPayWithPayDic:payDic OrderDic:orderDic];
        
    }
    else{
        NSLog(@"请求失败，服务器处理异常");
    }
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UILabel *)labPrice{
    if (!_labPrice) {
        _labPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, DeviceSize.width - 20 , 15)];
        _labPrice.text = @"充值金额";
        _labPrice.font = [UIFont systemFontOfSize:15];
        _labPrice.textAlignment = NSTextAlignmentLeft;
    }
    return _labPrice;
}
- (UITextField *)textPrice{
    if (!_textPrice) {
        _textPrice = [[UITextField alloc]initWithFrame:CGRectMake(10, self.labPrice.bottom + 10, DeviceSize.width - 20, 46)];
        _textPrice.textAlignment = NSTextAlignmentLeft;
        _textPrice.font = [UIFont systemFontOfSize:15];
        _textPrice.placeholder = @"请输入充值金额";
        _textPrice.layer.masksToBounds = YES;
        _textPrice.layer.cornerRadius = 6.0;
        _textPrice.layer.borderWidth = 0.5;
        _textPrice.layer.borderColor = [AppDefaultColor CGColor];
        _textPrice.leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        _textPrice.backgroundColor = [UIColor whiteColor];
        _textPrice.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textPrice;
}
- (UILabel *)labText{
    if (!_labText) {
        _labText = [[UILabel alloc]initWithFrame:CGRectMake(10, self.textPrice.bottom + 10, DeviceSize.width - 20, 15)];
        _labText.text = @"请选择充值方式";
        _labText.font = [UIFont systemFontOfSize:15];
        _labText.textAlignment = NSTextAlignmentLeft;
    }
    return _labText;
}
- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, self.labText.bottom + 10, DeviceSize.width, 92)];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
- (UILabel *)labLine1{
    if (!_labLine1) {
        _labLine1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
        _labLine1.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine1;
}
- (UILabel *)labLine2{
    if (!_labLine2) {
        _labLine2 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.whiteView.height/2, DeviceSize.width, 0.5)];
        _labLine2.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine2;
}
- (UILabel *)labLine3{
    if (!_labLine3) {
        _labLine3 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.whiteView.height- 0.5, DeviceSize.width, 0.5)];
        _labLine3.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine3;
}
- (UIButton *)btnZHB{
    if (!_btnZHB) {
        _btnZHB = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnZHB.frame = CGRectMake(0, 0, DeviceSize.width, 45.5);
        [_btnZHB addTarget:self action:@selector(btnZFBAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnZHB;
}
- (UIButton *)btnWX{
    if (!_btnWX) {
        _btnWX = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWX.frame = CGRectMake(0, self.labLine2.bottom, DeviceSize.width, 45.5);
        [_btnWX addTarget:self action:@selector(btnWXAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnWX;
}
- (UIImageView *)imgZFB{
    if (!_imgZFB) {
        _imgZFB = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.labLine1.bottom +16, 13, 13)];
        _imgZFB.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_支付-点击状态"];
    }
    return _imgZFB;
}
- (UILabel *)labZFB{
    if (!_labZFB) {
        _labZFB = [[UILabel alloc] initWithFrame:CGRectMake(self.imgZFB.right +10, self.labLine1.bottom +15, DeviceSize.width/2, 15)];
        _labZFB.textColor = [UIColor colorWithHEX:0x333333];
        _labZFB.font = [UIFont systemFontOfSize:15];
        _labZFB.text = @"支付宝支付";
    }
    return _labZFB;
}
- (void)btnZFBAction{
    self.imgZFB.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_支付-点击状态"];
    self.imgWX.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_点击-非点击状态"];

}
- (UIImageView *)imgWX{
    if (!_imgWX) {
        _imgWX = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.labLine2.bottom +16, 13, 13)];
        _imgWX.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_点击-非点击状态"];
    }
    return _imgWX;
}
- (UILabel *)labWXInfo{
    if (!_labWXInfo) {
        _labWXInfo = [[UILabel alloc] initWithFrame:CGRectMake(self.imgWX.right +10, self.labLine2.bottom +15, DeviceSize.width/2, 15)];
        _labWXInfo.textColor = [UIColor colorWithHEX:0x333333];
        _labWXInfo.font = [UIFont systemFontOfSize:15];
        _labWXInfo.text = @"微信支付";
    }
    return _labWXInfo;
}
- (void)btnWXAction{
    self.imgWX.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_支付-点击状态"];
    self.imgZFB.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_点击-非点击状态"];
}
- (UIButton *)btnSure{
    if (!_btnSure) {
        _btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSure.frame = CGRectMake(10, self.whiteView.bottom + 20 , DeviceSize.width - 20, 45);
        _btnSure.layer.cornerRadius = 6.f;
        _btnSure.layer.masksToBounds = YES;
        _btnSure.backgroundColor = AppDefaultColor;
        [_btnSure setTitle:@"充值" forState:UIControlStateNormal];
        [_btnSure addTarget:self action:@selector(btnSureClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSure;
}
- (void)btnSureClick{
    [self getNetWork];
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(WithdrawalViewController);
    if ([self.textPrice.text isEqualToString:@""]) {
        [self showHudAuto:@"请输入金额" andDuration:@"2"];
    }else{
        AppDelegate * app = [UIApplication sharedApplication].delegate;
        [[THNetWorkManager shareNetWork]getPostChargeTotal:self.textPrice.text andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
            [weakSelf removeMBProgressHudInManaual];
            if (response.responseCode == 1) {
                [app sendPay_demoName:@"余额充值" price:response.dataDic[@"total"] desc:@"余额充值" order_sn:response.dataDic[@"order_sn"]];
                weakSelf.priceStr = response.dataDic[@"total"];
            }else{
                [weakSelf showHudAuto:response.message andDuration:@"2"];
            }
        } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
            [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        }];
    }
    
}
- (void)CZAction{
    WIthFinishViewController * WIthFinishVc = [[WIthFinishViewController alloc]init];
    WIthFinishVc.priceStr = self.priceStr;
    [self.navigationController pushViewController:WIthFinishVc animated:YES];
}
- (NSString *)title{
    return @"充值";
}
- (void)tableKey{
    [self.textPrice resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 调起微信支付，传进来商品名称和价格
- (void)getWeChatPayWithOrderName:(NSString *)name
                            price:(NSString*)price

{
    
    //----------------------------获取prePayId配置------------------------------
    // 订单标题，展示给用户
    NSString* orderName = name;
    // 订单金额,单位（分）, 1是0.01元
    NSString* orderPrice = price;
    // 支付类型，固定为APP
    NSString* orderType = @"APP";
    // 随机数串
    NSString *noncestr  = [self genNonceStr];
    // 商户订单号
    NSString *orderNO   = [self genOutTradNo];
    
    //================================
    //预付单参数订单设置
    //================================
    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
    
    [packageParams setObject: WXAppId      forKey:@"appid"];       //开放平台appid
    [packageParams setObject: WXPartnerId  forKey:@"mch_id"];      //商户号
    [packageParams setObject: noncestr     forKey:@"nonce_str"];   //随机串
    [packageParams setObject: orderType    forKey:@"trade_type"];  //支付类型，固定为APP
    [packageParams setObject: orderName    forKey:@"body"];        //订单描述，展示给用户
    [packageParams setObject: orderNO      forKey:@"out_trade_no"];//商户订单号
    [packageParams setObject: orderPrice   forKey:@"total_fee"];   //订单金额，单位为分
    [packageParams setObject: [CommonUtil getIPAddress:YES] forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: @"http://weixin.qq.com"  forKey:@"notify_url"];  //支付结果异步通知
    NSString *prePayid;
    prePayid = [self sendPrepay:packageParams];
    //---------------------------获取prePayId结束------------------------------
    
    
    
    
    
    if(prePayid){
        NSString *timeStamp = [self genTimeStamp];
        // 调起微信支付
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = WXPartnerId;
        request.prepayId = prePayid;
        request.package = @"Sign=WXPay";
        request.nonceStr = noncestr;
        request.timeStamp = [timeStamp intValue];
        
        // 这里要注意key里的值一定要填对， 微信官方给的参数名是错误的，不是第二个字母大写
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: WXAppId               forKey:@"appid"];
        [signParams setObject: WXPartnerId           forKey:@"partnerid"];
        [signParams setObject: request.nonceStr      forKey:@"noncestr"];
        [signParams setObject: request.package       forKey:@"package"];
        [signParams setObject: timeStamp             forKey:@"timestamp"];
        [signParams setObject: request.prepayId      forKey:@"prepayid"];
        
        //生成签名
        NSString *sign  = [self genSign:signParams];
        
        //添加签名
        request.sign = sign;
        
        [WXApi sendReq:request];
        
        
    } else{
        NSLog(@"获取prePayId失败！");
    }
    
    
    
}




// 获取package带参数的签名包
- (NSString *)genPackage:(NSMutableDictionary*)packageParams
{
    NSString *sign;
    NSMutableString *reqPars = [NSMutableString string];
    
    // 生成签名
    sign = [self genSign:packageParams];
    
    // 生成xml格式的数据, 作为post给微信的数据
    NSArray *keys = [packageParams allKeys];
    [reqPars appendString:@"<xml>"];
    for (NSString *categoryId in keys) {
        [reqPars appendFormat:@"<%@>%@</%@>"
         , categoryId, [packageParams objectForKey:categoryId],categoryId];
    }
    [reqPars appendFormat:@"<sign>%@</sign></xml>", sign];
    
    return [NSString stringWithString:reqPars];
}




// 提交预支付, 获取prePayId
- (NSString *)sendPrepay:(NSMutableDictionary *)prePayParams
{
    
    // 获取提交预支付的xml格式数据
    NSString *send = [self genPackage:prePayParams];
    // 打印检查， 格式应该是xml格式的字符串
    NSLog(@"%@", send);
    
    // 转换成NSData
    NSData *data_send = [send dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:getPrePayIdUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data_send];
    
    NSError *error = nil;
    // 拿到data后, 用xml解析， 这里随便用什么方法解析
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (!error) {
        // 1.根据data初始化一个GDataXMLDocument对象
        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
        // 2.拿出根节点
        GDataXMLElement *rootElement = [document rootElement];
        GDataXMLElement *return_code = [[rootElement elementsForName:@"return_code"] lastObject];
        GDataXMLElement *return_msg = [[rootElement elementsForName:@"return_msg"] lastObject];
        GDataXMLElement *result_code = [[rootElement elementsForName:@"result_code"] lastObject];
        GDataXMLElement *prepay_id = [[rootElement elementsForName:@"prepay_id"] lastObject];
        // 如果return_code和result_code都为SUCCESS, 则说明成功
        NSLog(@"return_code---%@", [return_code stringValue]);
        // 返回信息，通常返回一些错误信息
        NSLog(@"return_msg---%@", [return_msg stringValue]);
        NSLog(@"result_code---%@", [result_code stringValue]);
        // 拿到这个就成功一大半啦
        NSLog(@"prepay_id---%@", [prepay_id stringValue]);
        
        return [prepay_id stringValue];
    } else {
        return nil;
    }
    
    
    
}

#pragma mark - 生成各种参数

- (NSString *)genTimeStamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

/**
 * 注意：商户系统内部的订单号,32个字符内、可包含字母,确保在商户系统唯一
 */
- (NSString *)genNonceStr
{
    return [CommonUtil md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}

/**
 * 建议 traceid 字段包含用户信息及订单信息，方便后续对订单状态的查询和跟踪
 */
- (NSString *)genTraceId
{
    return [NSString stringWithFormat:@"myt_%@", [self genTimeStamp]];
}

- (NSString *)genOutTradNo
{
    return [CommonUtil md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}


#pragma mark - 签名
/** 签名 */
- (NSString *)genSign:(NSDictionary *)signParams
{
    // 排序, 因为微信规定 ---> 参数名ASCII码从小到大排序
    NSArray *keys = [signParams allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //生成 ---> 微信规定的签名格式
    NSMutableString *sign = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [sign appendString:key];
        [sign appendString:@"="];
        [sign appendString:[signParams objectForKey:key]];
        [sign appendString:@"&"];
    }
    NSString *signString = [[sign copy] substringWithRange:NSMakeRange(0, sign.length - 1)];
    
    // 拼接API密钥
    NSString *result = [NSString stringWithFormat:@"%@&key=%@", signString, WXAPIKey];
    // 打印检查
    NSLog(@"result = %@", result);
    // md5加密
    NSString *signMD5 = [CommonUtil md5:result];
    // 微信规定签名英文大写
    signMD5 = signMD5.uppercaseString;
    // 打印检查
    NSLog(@"signMD5 = %@", signMD5);
    return signMD5;
}




@end
