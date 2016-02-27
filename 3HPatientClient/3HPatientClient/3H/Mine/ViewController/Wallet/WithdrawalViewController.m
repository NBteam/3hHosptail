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
   
    if (![WXApi isWXAppInstalled]) {//检查用户是否安装微信
        
        NSLog(@"未安装微信客户端");
        //...处理
        
        return;
    }
    
    //请求APP后台服务器下单接口，该接口返回orderDic(订单信息)和payDic(支付账号信息，包括：appID,商户号，APIKey)
    [lhSharePay addActivityView:self.view];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rechargeEvent:) name:@"recharge" object:nil];
    NSDictionary * dic = @{@"rechargeRule_id":@"1",
                           @"users_id":@"a38d4da064054e99840efdd91280ee35",
                           @"money":@"1000",
                           @"way":@"2"};//请求字段
    [[lhSharePay alloc] HTTPPOSTNormalRequestForURL:@"填写app服务器的请求接口" parameters:dic method:@"POST" name:@"recharge"];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
