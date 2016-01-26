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
