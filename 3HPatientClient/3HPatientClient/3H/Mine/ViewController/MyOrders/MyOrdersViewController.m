//
//  MyOrdersViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//
extern NSInteger payIndex;
#import "MyOrdersViewController.h"
#import "MyOrdersTableViewCell.h"
#import "OrderModel.h"
#import "OrderListNewModel.h"
#import "AppDelegate.h"
#import "ShopDetailViewController.h"
#import "ShopBuyFinishViewController.h"

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
@interface MyOrdersViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>
@property (nonatomic, copy) NSString * priceStr;
@property (nonatomic, strong) UIAlertView * alertView;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) UIActionSheet * actionSheet;
@end

@implementation MyOrdersViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"allOrder" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    payIndex = 3;
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.height = self.tableView.height - 44;
    self.isOpenFooterRefresh = YES;
    self.isOpenHeaderRefresh = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allOrderAction) name:@"allOrder" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(zfFailureAction) name:@"zfFailure" object:nil];
    [self getNetWork];
    
}

- (UIActionSheet *)actionSheet{
    if (!_actionSheet) {
        _actionSheet =[ [UIActionSheet alloc]initWithTitle:@"支付方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"支付宝支付" otherButtonTitles:@"微信支付", nil];
    }
    return _actionSheet;
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PersonalHeadTableViewCell";
    MyOrdersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyOrdersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WeakSelf(MyOrdersViewController);
    [cell setConfirmBlock:^(NSInteger index) {
        weakSelf.indexPath = indexPath;
        OrderListNewModel * model1 = weakSelf.dataArray[self.indexPath.section];
        if (index == 0 ){
             [weakSelf.actionSheet showInView:weakSelf.view];
        }else if (index == 1 ){
            ShopDetailViewController * ShopDetailVc = [[ShopDetailViewController alloc]initWithTableViewStyle:UITableViewStyleGrouped];
            ShopDetailVc.id = model1.ilist[0][@"goods_id"];
            [weakSelf.navigationController pushViewController:ShopDetailVc animated:YES];
        }else if (index == 2 || index == 3){
            [weakSelf.alertView show];
        }
    }];
    OrderListNewModel * model = self.dataArray[indexPath.section];
    [cell confingWithModel:model];
    return cell;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    OrderListNewModel * model1 = self.dataArray[self.indexPath.section];
    NSString * price = [NSString stringWithFormat:@"%.2f",[model1.ilist[0][@"price"] doubleValue]* [model1.ilist[0][@"qty"] doubleValue]];
    if (buttonIndex == 0) {
        AppDelegate * app = [UIApplication sharedApplication].delegate;
        self.priceStr = price;
        [app sendPay_demoName:model1.ilist[0][@"goods_name"] price:price desc:@"desc" order_sn:model1.order_sn];
    }else if (buttonIndex == 1){
        double folat = [price doubleValue] *100;
        [self getWeChatPayWithOrderName:model1.ilist[0][@"goods_name"]  price:[NSString stringWithFormat:@"%.0f",folat]];
    }else if (buttonIndex == 2){
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 205;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(MyOrdersViewController);
    [[THNetWorkManager shareNetWork]getOrderListPage:self.pageNO kw:@"" type:@"" andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in response.dataDic[@"list"]) {
                OrderListNewModel * model = [response thParseDataFromDic:dic andModel:[OrderListNewModel class]];
//                for (NSDictionary * infoDict in model.ilist) {
//                    OrderModel * oModel = [response thParseDataFromDic:infoDict andModel:[OrderModel class]];
//                    [weakSelf.dataArray addObject:oModel];
//                }
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
            //  结束头部刷新
            [weakSelf.tableView.header endRefreshing];
            //  结束尾部刷新
            [weakSelf.tableView.footer endRefreshing];
        }else{
            //  结束头部刷新
            [weakSelf.tableView.header endRefreshing];
            //  结束尾部刷新
            [weakSelf.tableView.footer endRefreshing];
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    [self getNetWork];
}
- (void)footerRequestWithData
{
    [self getNetWork];
}
- (void)orderReceiveNetWorkId:(NSString *)ids{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(MyOrdersViewController);
    [[THNetWorkManager shareNetWork]orderReceiveOrder_id:ids andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            [weakSelf getNetWork];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
    
}
- (void)allOrderAction{
    ShopBuyFinishViewController * shopBuyFinishVc = [[ShopBuyFinishViewController alloc]init];
    shopBuyFinishVc.priceStr = self.priceStr;
    [self.navigationController pushViewController:shopBuyFinishVc animated:YES];
}
- (UIAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确认收货" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    }
    return _alertView;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        OrderListNewModel * model1 = self.dataArray[self.indexPath.section];
        [self orderReceiveNetWorkId:model1.id];
    }
}

- (void)zfFailureAction{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                    message:@"支付失败"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
    
}
- (NSString *)title{
    return @"我的订单";
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
