//
//  RegisterViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "RegisterViewController.h"
////app用户协议
//#import "AppAgreementViewController.h"
//神马是邀请码
//#import "WhatInvitationViewController.h"
#import "LoginInputView.h"
#import "EaseMob.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    NSInteger  buttonIndex;
}
//蓝色背景
@property (nonatomic, strong) UIView *viewBlue;
//appLogo
@property (nonatomic, strong) UIImageView *imgLogo;
//白色波浪
@property (nonatomic, strong) UIImageView *imgWhite;
//注册按钮
@property (nonatomic, strong) UIButton *btnLogin;
//用户名
@property (nonatomic, strong) UITextField * textUserName;
//下划线
@property (nonatomic, strong) UILabel *labLineUserName;
//验证码
@property (nonatomic, strong) UITextField *txtCode;
//下划线
@property (nonatomic, strong) UILabel *labLineCode;
//验证码view
@property (nonatomic, strong) UIView * viewCode;
//获取验证码
@property (nonatomic, strong) UIButton *btnGetCode;
//密码
@property (nonatomic, strong) UITextField *txtPassWord;
//下划线
@property (nonatomic, strong) UILabel *labLinePassWord;
//用户协议
@property (nonatomic, strong) UIButton *btnAgreement;
//注册按钮
@property (nonatomic, strong) UIButton *btnRegister;
//邀请码
@property (nonatomic, strong) UITextField *textInvitation;

//定时器
@property (nonatomic,retain) NSTimer * timer;

//下划线
@property (nonatomic, strong) UILabel *labInvitation;
@end

@implementation RegisterViewController

- (UILabel *)labLinePassWord{
    if (!_labLinePassWord) {
        _labLinePassWord = [[UILabel alloc] initWithFrame:CGRectMake(self.txtPassWord.left, self.txtPassWord.bottom +10, self.txtPassWord.width, 1)];
        _labLinePassWord.backgroundColor = [UIColor colorWithHEX:0x888888];
    }
    return _labLinePassWord;
}

- (void)dealloc{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)loadView{
    [super loadView];
    self.view = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    buttonIndex = 60;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHEX:0xffffff];;
    [self.viewBlue addSubview:self.imgLogo];
    [self.viewBlue addSubview:self.imgWhite];
    
    self.viewBlue.height = self.imgWhite.bottom;
    [self.view addSubview:self.viewBlue];
    [self.view addSubview:self.textUserName];
    [self.view addSubview:self.labLineUserName];
    [self.view addSubview:self.txtCode];
    [self.view addSubview:self.btnGetCode];
    [self.view addSubview:self.labLineCode];
    [self.view addSubview:self.txtPassWord];
    [self.view addSubview:self.labLinePassWord];
    [self.view addSubview:self.textInvitation];
    [self.view addSubview:self.labInvitation];
    [self.view addSubview:self.btnAgreement];
    [self.view addSubview:self.btnRegister];
    //[self.view addSubview:self.btnLogin];
    [self.view addSubview:self.btnLogin];
    
//
}

#pragma mark -UI

- (UILabel *)labInvitation{
    if (!_labInvitation) {
        _labInvitation = [[UILabel alloc] initWithFrame:CGRectMake(self.txtPassWord.left, self.textInvitation.bottom +10, self.txtPassWord.width, 1)];
        _labInvitation.backgroundColor = [UIColor colorWithHEX:0x888888];
    }
    return _labInvitation;
}

- (UIView *)viewBlue{
    if (!_viewBlue) {
        _viewBlue = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0)];
        _viewBlue.backgroundColor = AppDefaultColor;
    }
    return _viewBlue;
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake((DeviceSize.width -172)/2, 80, 172, 132)];
        _imgLogo.image = [UIImage imageNamed:@"3H-注册_3H (2)"];
    }
    return _imgLogo;
}

- (UIImageView *)imgWhite{
    if (!_imgWhite) {
        _imgWhite = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.imgLogo.bottom, DeviceSize.width, 48)];
        _imgWhite.image = [UIImage imageNamed:@"thLOGOdoctor"];
    }
    return _imgWhite;
}


- (void)btnLoginAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITextField *)textUserName{
    if (!_textUserName) {
        _textUserName = [[UITextField alloc] initWithFrame:CGRectMake(15, self.viewBlue.bottom, DeviceSize.width -30, 30)];
        
        //是否纠错
        _textUserName.autocorrectionType = UITextAutocorrectionTypeNo;
        _textUserName.keyboardType = UIKeyboardTypeNumberPad;
        _textUserName.font = [UIFont systemFontOfSize:15];
        _textUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _textUserName.textColor = AppDefaultColor;
    }
    return _textUserName;
}

- (UILabel *)labLineUserName{
    if (!_labLineUserName) {
        _labLineUserName = [[UILabel alloc] initWithFrame:CGRectMake(self.textUserName.left, self.textUserName.bottom +10, self.textUserName.width, 1)];
        _labLineUserName.backgroundColor = [UIColor colorWithHEX:0x888888];
    }
    return _labLineUserName;
}

//- (UIView *)viewCode{
//    if (!_viewCode) {
//        _viewCode = [[UIView alloc]initWithFrame:CGRectMake(15, self.textUserName.bottom+10, DeviceSize.width-30-100, 90/2)];
//        _viewCode.backgroundColor = [UIColor whiteColor];
//        _viewCode.layer.masksToBounds = YES;
//        _viewCode.layer.cornerRadius = 3;
//    }
//    return _viewCode;
//}
- (UITextField *)txtCode{
    if (!_txtCode) {
        _txtCode = [[UITextField alloc] initWithFrame:CGRectMake(15, self.labLineUserName.bottom +10, DeviceSize.width -30 - 90 -10, 30)];
        
        //是否纠错
        _txtCode.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtCode.keyboardType = UIKeyboardTypeNumberPad;
        _txtCode.font = [UIFont systemFontOfSize:15];
        _txtCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtCode.textColor = AppDefaultColor;
    }
    return _txtCode;
}

- (UILabel *)labLineCode{
    if (!_labLineCode) {
        _labLineCode = [[UILabel alloc] initWithFrame:CGRectMake(self.txtCode.left, self.txtCode.bottom +10, self.labLineUserName.width, 1)];
        _labLineCode.backgroundColor = [UIColor colorWithHEX:0x888888];
    }
    return _labLineCode;
}

- (UIButton *)btnGetCode{
    if (!_btnGetCode) {
        _btnGetCode = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnGetCode.frame = CGRectMake(self.txtCode.right +10, self.labLineUserName.bottom +15, 90, 25);
        _btnGetCode.backgroundColor = [UIColor orangeColor];
        _btnGetCode.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnGetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        _btnGetCode.layer.masksToBounds = YES;
        _btnGetCode.layer.cornerRadius = 25/2;
        [_btnGetCode addTarget:self action:@selector(btnGetCodeAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _btnGetCode;
}
- (void)creatTimer
{
    _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(appAction) userInfo:nil repeats:YES];
}
- (void)appAction
{
    [self.btnGetCode setTitle:[NSString stringWithFormat:@"%ld秒",(long)buttonIndex--] forState:UIControlStateNormal];
    if (buttonIndex<=0) {
        [_timer setFireDate:[NSDate distantFuture]];
        [self.btnGetCode setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
        buttonIndex=60;
    }
}

- (void)btnGetCodeAction{
    if ([self.textUserName.text isEqualToString:@""]) {
        [self showHudAuto:@"请输入手机号" andDuration:@"2"];
    }else{
        if (buttonIndex==60) {
            [self getMobilecode];
        }
        
    }
}
- (UITextField *)txtPassWord{
    if (!_txtPassWord) {
        _txtPassWord = [[UITextField alloc] initWithFrame:CGRectMake(15, self.labLineCode.bottom +10, DeviceSize.width -30, 30)];
        
        //是否纠错
        _txtPassWord.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtPassWord.font = [UIFont systemFontOfSize:15];
        _txtPassWord.secureTextEntry = YES;
        _txtPassWord.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtPassWord.textColor = AppDefaultColor;
    }
    return _txtPassWord;
}
- (UITextField *)textInvitation{
    if (!_textInvitation) {
        _textInvitation = [[UITextField alloc] initWithFrame:CGRectMake(15, self.labLinePassWord.bottom +10, DeviceSize.width -30, 30)];
        
        //是否纠错
        _textInvitation.autocorrectionType = UITextAutocorrectionTypeNo;
        _textInvitation.font = [UIFont systemFontOfSize:15];
        _textInvitation.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邀请码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _textInvitation.textColor = AppDefaultColor;
    }
    return _textInvitation;

}


- (UIButton *)btnAgreement{
    if (!_btnAgreement) {
        _btnAgreement = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAgreement.frame = CGRectMake(15, self.labInvitation.bottom +15, 0, 20);
        _btnAgreement.backgroundColor = [UIColor clearColor];
        [_btnAgreement setTitleColor:[UIColor colorWithHEX:0x999999] forState:UIControlStateNormal];
        _btnAgreement.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [_btnAgreement setImage:[UIImage imageNamed:@"3H-注册_选框"] forState:UIControlStateNormal];
        [_btnAgreement setImage:[UIImage imageNamed:@"3H-注册_全选"] forState:UIControlStateSelected];
        [_btnAgreement setTitle:@"本人已阅读并同意《北京中瑞康服务条款》" forState:UIControlStateNormal];
        [_btnAgreement sizeToFit];
        _btnAgreement.width = _btnAgreement.width +10;
        [_btnAgreement addTarget:self action:@selector(btnAgreementAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _btnAgreement;
}

- (void)btnAgreementAction{
    if (self.btnAgreement.selected) {
        self.btnAgreement.selected = NO;
    }else{
        self.btnAgreement.selected = YES;
    }
//    AppAgreementViewController *appAgreementVc = [[AppAgreementViewController  alloc] init];
//    [self.navigationController pushViewController:appAgreementVc animated:YES];
}


- (void)btnWhatInvitationAction{
//    WhatInvitationViewController *whatInvitationVc = [[WhatInvitationViewController alloc] init];
//    [self.navigationController pushViewController:whatInvitationVc animated:YES];
}

- (UIButton *)btnRegister{
    if (!_btnRegister) {
        _btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRegister.frame = CGRectMake(15, self.btnAgreement.bottom +15, DeviceSize.width-30, 45);
        [_btnRegister setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        _btnRegister.backgroundColor = AppDefaultColor;
        _btnRegister.titleLabel.font = [UIFont systemFontOfSize:17];
        [_btnRegister setTitle:@"立即注册" forState:UIControlStateNormal];
        _btnRegister.layer.masksToBounds = YES;
        _btnRegister.layer.cornerRadius = 5;
//        _btnRegister.backgroundColor = AppDefaultColor;
        
        [_btnRegister addTarget:self action:@selector(btnRegisterAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnRegister;
}
- (UIButton *)btnLogin{
    if (!_btnLogin) {
        _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLogin.frame = CGRectMake(DeviceSize.width - 40 - 25, 11 +20, 40, 20);
        [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnLogin.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
        UILabel *labLine = [[UILabel alloc] initWithFrame:CGRectMake(5, 18, 30, 1)];
        labLine.backgroundColor = [UIColor whiteColor];
        [_btnLogin addSubview:labLine];
        [_btnLogin addTarget:self action:@selector(btnLoginAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnLogin;
}
- (void)btnRegisterAction{
    if ([self.textUserName.text isEqualToString:@""]) {
        [self showHudAuto:@"请输入手机号" andDuration:@"2"];
    }else if ([self.txtCode.text isEqualToString:@""]){
        [self showHudAuto:@"请输入验证码" andDuration:@"2"];
    }else if ([self.txtPassWord.text isEqualToString:@""]){
        [self showHudAuto:@"请输入密码" andDuration:@"2"];
    }else if ([self.textInvitation.text isEqualToString:@""]){
        [self showHudAuto:@"请输入邀请码" andDuration:@"2"];
    }else if (!self.btnAgreement.selected){
        [self showHudAuto:@"请同意协议" andDuration:@"2"];
    }
    else{
        [self getNetWork];
    }
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(RegisterViewController);
    [[THNetWorkManager shareNetWork]getRegMobile:self.textUserName.text Password:self.txtPassWord.text Sms_code:self.txtCode.text Fromcode:self.textInvitation.text CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        NSLog(@"查看%@",response.dataDic);
        if (response.responseCode == 1) {
            [SGSaveFile saveObjectToSystem:response.dataDic[@"token"] forKey:Token];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (void)getMobilecode{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(RegisterViewController);
    [[THNetWorkManager shareNetWork]getMobilecode:self.textUserName.text andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.timer==nil) {
                [weakSelf creatTimer];
            }else{
                [weakSelf.timer setFireDate:[NSDate distantPast]];
            }
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (void)btnLoginClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
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
