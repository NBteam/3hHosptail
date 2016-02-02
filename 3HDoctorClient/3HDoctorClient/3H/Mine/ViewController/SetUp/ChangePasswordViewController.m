//
//  ChangePasswordViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/23.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
{
    NSInteger  buttonIndex;
}
//用户名
@property (nonatomic, strong) UITextField *txtUserName;
//验证码
@property (nonatomic, strong) UITextField *txtCode;
//button
@property (nonatomic, strong) UIButton *btnCode;
//验证码
@property (nonatomic, strong) UITextField *txtPassWord;

@property (nonatomic, strong) UIButton *btnLogin;
//定时器
@property (nonatomic,retain) NSTimer * timer;
@end

@implementation ChangePasswordViewController

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
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.txtUserName];
    [self.view addSubview:self.txtCode];
    [self.view addSubview:self.btnCode];
    [self.view addSubview:self.txtPassWord];
    [self.view addSubview:self.btnLogin];
}

- (UITextField *)txtUserName{
    if (!_txtUserName) {
        _txtUserName = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, DeviceSize.width -30, 40)];
        //是否纠错
        _txtUserName.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtUserName.keyboardType = UIKeyboardTypeNumberPad;
        _txtUserName.font = [UIFont systemFontOfSize:15];
        _txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtUserName.textColor = AppDefaultColor;
        _txtUserName.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtUserName.layer.borderWidth = 0.5;
        _txtUserName.layer.masksToBounds = YES;
        _txtUserName.layer.cornerRadius = 4;
        _txtUserName.backgroundColor = [UIColor colorWithHEX:0xffffff];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _txtUserName.leftView = img;
        
        _txtUserName.leftViewMode = UITextFieldViewModeAlways;
    }
    return _txtUserName;
}

- (UITextField *)txtCode{
    if (!_txtCode) {
        _txtCode = [[UITextField alloc] initWithFrame:CGRectMake(15, self.txtUserName.bottom +15, DeviceSize.width -30 -70 -15, 40)];
        //是否纠错
        _txtCode.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtCode.keyboardType = UIKeyboardTypeNumberPad;
        _txtCode.font = [UIFont systemFontOfSize:15];
        _txtCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtCode.textColor = AppDefaultColor;
        _txtCode.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtCode.layer.borderWidth = 0.5;
        _txtCode.layer.masksToBounds = YES;
        _txtCode.layer.cornerRadius = 4;
        _txtCode.backgroundColor = [UIColor colorWithHEX:0xffffff];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _txtCode.leftView = img;
        
        _txtCode.leftViewMode = UITextFieldViewModeAlways;
    }
    return _txtCode;
}

- (UIButton *)btnCode{
    if (!_btnCode) {
        _btnCode = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCode.frame = CGRectMake(self.txtCode.right +15, self.txtUserName.bottom +15, 70, 40);
        [_btnCode setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        _btnCode.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnCode setTitle:@"获取" forState:UIControlStateNormal];
        _btnCode.layer.masksToBounds = YES;
        _btnCode.layer.cornerRadius = 5;
        _btnCode.backgroundColor = AppDefaultColor;
        
        [_btnCode addTarget:self action:@selector(btnCodeAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _btnCode;
}

- (void)btnCodeAction{
    if ([self.txtUserName.text isEqualToString:@""]) {
        [self showHudAuto:@"请输入手机号" andDuration:@"1"];
    }else{
        if (buttonIndex==60) {
            [self showHudWaitingView:@"正在努力操作"];
            WeakSelf(ChangePasswordViewController);
            [[THNetWorkManager shareNetWork] getPwdMobilecode:self.txtUserName.text andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
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
                [weakSelf showHudAuto:@"验证码获取失败，请重试" andDuration:@"1"];
            }];
        }
    }
}

- (UITextField *)txtPassWord{
    if (!_txtPassWord) {
        _txtPassWord = [[UITextField alloc] initWithFrame:CGRectMake(15, self.txtCode.bottom +15, DeviceSize.width -30, 40)];
        //是否纠错
        _txtPassWord.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtPassWord.font = [UIFont systemFontOfSize:15];
        _txtPassWord.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtPassWord.textColor = AppDefaultColor;
        _txtPassWord.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtPassWord.layer.borderWidth = 0.5;
        _txtPassWord.layer.masksToBounds = YES;
        _txtPassWord.layer.cornerRadius = 4;
        _txtPassWord.backgroundColor = [UIColor colorWithHEX:0xffffff];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _txtPassWord.leftView = img;
        
        _txtPassWord.leftViewMode = UITextFieldViewModeAlways;
    }
    return _txtPassWord;
}

- (UIButton *)btnLogin{
    if (!_btnLogin) {
        _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLogin.frame = CGRectMake(15, self.txtPassWord.bottom +30, DeviceSize.width -30, 45);
        [_btnLogin setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        _btnLogin.titleLabel.font = [UIFont systemFontOfSize:17];
        [_btnLogin setTitle:@"确认" forState:UIControlStateNormal];
        _btnLogin.layer.masksToBounds = YES;
        _btnLogin.layer.cornerRadius = 5;
        _btnLogin.backgroundColor = AppDefaultColor;
        
        [_btnLogin addTarget:self action:@selector(btnLoginAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnLogin;
}

- (void)btnLoginAction{
    if ([self.txtUserName.text isEqualToString:@""]) {
        [self showHudAuto:@"请输入手机号" andDuration:@"2"];
    }else if ([self.txtCode.text isEqualToString:@""]){
        [self showHudAuto:@"请输入验证码" andDuration:@"2"];
    }else if ([self.txtPassWord.text isEqualToString:@""]){
        [self showHudAuto:@"请输入密码" andDuration:@"2"];
    }else{
        [self getPwdNetWork];
    }
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creatTimer
{
    _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(appAction) userInfo:nil repeats:YES];
}
- (void)appAction
{
    [self.btnCode setTitle:[NSString stringWithFormat:@"%ld秒",(long)buttonIndex--] forState:UIControlStateNormal];
    if (buttonIndex<=0) {
        [_timer setFireDate:[NSDate distantFuture]];
        [self.btnCode setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
        buttonIndex=60;
    }
}
- (void)getPwdNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ChangePasswordViewController);
    [[THNetWorkManager shareNetWork]getPwdMobile:self.txtUserName.text sms_code:self.txtCode.text password:self.txtPassWord.text andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}

- (NSString *)title{
    return @"修改密码";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
