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

@interface RegisterViewController ()<UITextFieldDelegate>
//蓝色背景
@property (nonatomic, strong) UIView *viewBlue;
//appLogo
@property (nonatomic, strong) UIImageView *imgLogo;
//白色波浪
@property (nonatomic, strong) UIImageView *imgWhite;
//注册按钮
@property (nonatomic, strong) UIButton *btnLogin;
//用户名
@property (nonatomic, strong) LoginInputView * textUserName;
//验证码
@property (nonatomic, strong) UITextField *txtCode;
//验证码view
@property (nonatomic, strong) UIView * viewCode;
//获取验证码
@property (nonatomic, strong) UIButton *btnGetCode;
//密码
@property (nonatomic, strong) LoginInputView *txtPassWord;

//用户协议
@property (nonatomic, strong) UIButton *btnAgreement;
//注册按钮
@property (nonatomic, strong) UIButton *btnRegister;



@end

@implementation RegisterViewController

- (void)loadView{
    [super loadView];
    self.view = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHEX:0xff9358];;
    [self.viewBlue addSubview:self.imgLogo];
    [self.viewBlue addSubview:self.imgWhite];
    self.viewBlue.height = self.imgWhite.bottom;
    [self.view addSubview:self.viewBlue];
    [self.view addSubview:self.textUserName];
    [self.view addSubview:self.viewCode];
    [self.viewCode addSubview:self.txtCode];
    [self.view addSubview:self.btnGetCode];
    [self.view addSubview:self.txtPassWord];
    [self.view addSubview:self.btnAgreement];
    [self.view addSubview:self.btnRegister];
    [self.view addSubview:self.btnLogin];
//
}

#pragma mark -UI

- (UIView *)viewBlue{
    if (!_viewBlue) {
        _viewBlue = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0)];
//        _viewBlue.backgroundColor = AppDefaultColor;
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
- (LoginInputView *)textUserName{
    if (!_textUserName) {
        _textUserName = [[LoginInputView alloc]initWithFrame:CGRectMake(0, self.viewBlue.bottom, DeviceSize.width, 90/2) title:@"" placeholder:@"请输入手机号"];
        _textUserName.textField.delegate = self;
        _textUserName.textField.keyboardType=UIKeyboardTypePhonePad;
    }
    return _textUserName;
}
- (UIView *)viewCode{
    if (!_viewCode) {
        _viewCode = [[UIView alloc]initWithFrame:CGRectMake(15, self.textUserName.bottom+10, DeviceSize.width-30-100, 90/2)];
        _viewCode.backgroundColor = [UIColor whiteColor];
        _viewCode.layer.masksToBounds = YES;
        _viewCode.layer.cornerRadius = 3;
    }
    return _viewCode;
}
- (UITextField *)txtCode{
    if (!_txtCode) {
        _txtCode = [[UITextField alloc] initWithFrame:CGRectMake(15, 90/2/2-15, DeviceSize.width -30 - 90 -10, 30)];
        //是否纠错
        _txtCode.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtCode.keyboardType = UIKeyboardTypeNumberPad;
        _txtCode.font = [UIFont systemFontOfSize:15];
        _txtCode.placeholder = @"验证码";
//        _txtCode.textColor = AppDefaultColor;
    }
    return _txtCode;
}

- (UIButton *)btnGetCode{
    if (!_btnGetCode) {
        _btnGetCode = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnGetCode.frame = CGRectMake(self.txtCode.right +10, self.textUserName.bottom +10, 90, 90/2);
        _btnGetCode.backgroundColor = [UIColor orangeColor];
        _btnGetCode.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnGetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnGetCode setTitle:@"免费获取" forState:UIControlStateNormal];
        [_btnGetCode addTarget:self action:@selector(btnGetCodeAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _btnGetCode;
}

- (void)btnGetCodeAction{
    
}
- (LoginInputView *)txtPassWord{
    if (!_txtPassWord) {
        _txtPassWord = [[LoginInputView alloc] initWithFrame:CGRectMake(0, self.viewCode.bottom +10, DeviceSize.width, 90/2) title:@"" placeholder:@"请输入密码"];
        
        //是否纠错
        _txtPassWord.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtPassWord.textField.font = [UIFont systemFontOfSize:15];
        _txtPassWord.textField.secureTextEntry = YES;
//        _txtPassWord.textColor = AppDefaultColor;
    }
    return _txtPassWord;
}



- (UIButton *)btnAgreement{
    if (!_btnAgreement) {
        _btnAgreement = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAgreement.frame = CGRectMake(15, self.txtPassWord.bottom +5, 0, 20);
        _btnAgreement.backgroundColor = [UIColor clearColor];
        [_btnAgreement setTitleColor:[UIColor colorWithHEX:0x888888] forState:UIControlStateNormal];
        _btnAgreement.titleLabel.font = [UIFont systemFontOfSize:12];
        [_btnAgreement setTitle:@"本人已阅读并同意《北京中瑞康服务条款》" forState:UIControlStateNormal];
        [_btnAgreement sizeToFit];
        [_btnAgreement addTarget:self action:@selector(btnAgreementAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _btnAgreement;
}

- (void)btnAgreementAction{
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
        _btnRegister.frame = CGRectMake(15, self.btnAgreement.bottom +10, DeviceSize.width-30, 45);
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
        _btnLogin.frame = CGRectMake(15, self.btnRegister.bottom+10, DeviceSize.width-30, 20);
        
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"已有账号？马上登陆"];
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,title.length)];
        NSRange titleRange = {title.length-4,4};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [_btnLogin setAttributedTitle:title forState:UIControlStateNormal];
        _btnLogin.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnLogin addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLogin;
}
- (void)btnRegisterAction{
    
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
