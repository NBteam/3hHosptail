//
//  LoginViewController.m
//  3HPatientClient
//
//  Created by kanzhun on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginInputView.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
//背景
@property (nonatomic, strong) UIImageView * imgBack;
@property (nonatomic, strong) LoginInputView * textUserName;
@property (nonatomic, strong) LoginInputView * textUserPwd;
//记住我
@property (nonatomic, strong) UIButton * btnRemember;
//登录
@property (nonatomic, strong) UIButton * btnLogin;
//忘记密码
@property (nonatomic, strong) UIButton * btnForget;
//注册
@property (nonatomic, strong) UIButton * btnRegistered;
//其他登录
@property (nonatomic, strong) UILabel * labOtherLogin;
//线1 线2
@property (nonatomic, strong) UILabel * labline1;
@property (nonatomic, strong) UILabel * labline2;
//第三方登录按钮
@property (nonatomic, strong) UIButton * btn1;
@property (nonatomic, strong) UIButton * btn2;
@property (nonatomic, strong) UIButton * btn3;
@end

@implementation LoginViewController
- (void)loadView{
    [super loadView];
    self.view = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.imgBack];
    [self.view addSubview:self.textUserName];
    [self.view addSubview:self.textUserPwd];
    [self.view addSubview:self.btnRemember];
    [self.view addSubview:self.btnForget];
    [self.view addSubview:self.btnLogin];
    [self.view addSubview:self.btnRegistered];
    [self.view addSubview:self.labOtherLogin];
    [self.view addSubview:self.labline1];
    [self.view addSubview:self.labline2];
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    // Do any additional setup after loading the view.
}
#pragma mark -- UI
- (UIImageView *)imgBack{
    if (!_imgBack) {
        _imgBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, -20, DeviceSize.width, DeviceSize.height)];
        _imgBack.image = [UIImage imageNamed:@""];
        _imgBack.userInteractionEnabled = YES;
        _imgBack.backgroundColor = [UIColor orangeColor];
    }
    return _imgBack;
}
- (LoginInputView *)textUserName{
    if (!_textUserName) {
        _textUserName = [[LoginInputView alloc]initWithFrame:CGRectMake(0, 480/2, DeviceSize.width, 96/2) title:@"" placeholder:@"请输入手机号"];
        _textUserName.textField.delegate = self;
        _textUserName.textField.keyboardType=UIKeyboardTypePhonePad;
    }
    return _textUserName;
}
- (LoginInputView *)textUserPwd{
    if (!_textUserPwd) {
        _textUserPwd = [[LoginInputView alloc]initWithFrame:CGRectMake(0, self.textUserName.bottom+15, DeviceSize.width, 96/2) title:@"" placeholder:@"请输入密码"];
        _textUserPwd.textField.delegate = self;
        _textUserPwd.textField.keyboardType=UIKeyboardTypePhonePad;
    }
    return _textUserPwd;
}
- (UIButton *)btnRemember{
    if (!_btnRemember) {
        _btnRemember = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRemember.frame = CGRectMake(15, self.textUserPwd.bottom+10, 100, 20);
        [_btnRemember setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _btnRemember.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnRemember setTitle:@"记住我" forState:UIControlStateNormal];
        [_btnRemember addTarget:self action:@selector(btnRememberClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnForget.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _btnRemember;
}
- (UIButton *)btnForget{
    if (!_btnForget) {
        _btnForget = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnForget.frame = CGRectMake(DeviceSize.width-15-100, self.textUserPwd.bottom+10, 100, 20);
        [_btnForget setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _btnForget.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnForget addTarget:self action:@selector(btnForgetClick:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"忘记密码？"];
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,title.length)];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [_btnForget setAttributedTitle:title forState:UIControlStateNormal];
        _btnForget.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _btnForget;
}
- (UIButton *)btnLogin{
    if (!_btnLogin) {
        _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLogin.frame = CGRectMake(15, self.btnRemember.bottom+10, DeviceSize.width-30, 96/2);
        _btnLogin.backgroundColor = [UIColor redColor];
        _btnLogin.layer.cornerRadius = 3;
        _btnLogin.layer.masksToBounds = YES;
        [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
        [_btnLogin addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLogin;
}
- (UIButton *)btnRegistered{
    if (!_btnRegistered) {
        _btnRegistered = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRegistered.frame = CGRectMake(15, self.btnLogin.bottom+10, DeviceSize.width-30, 20);

        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"还有没有账号？马上注册"];
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,title.length)];
        NSRange titleRange = {title.length-4,4};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [_btnRegistered setAttributedTitle:title forState:UIControlStateNormal];
        _btnRegistered.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnRegistered addTarget:self action:@selector(btnRegisteredClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRegistered;
}
- (UILabel *)labOtherLogin{
    if (!_labOtherLogin) {
        _labOtherLogin = [[UILabel alloc]initWithFrame:CGRectMake(0, self.btnRegistered.bottom+20, 100, 13)];
        _labOtherLogin.text = @"使用以下账户登录";
        _labOtherLogin.font = [UIFont systemFontOfSize:13];
        _labOtherLogin.textColor = [UIColor whiteColor];
        [_labOtherLogin sizeToFit];
        _labOtherLogin.left = (DeviceSize.width - _labOtherLogin.width)/2;
        _labOtherLogin.top = self.btnRegistered.bottom+20;
    }
    return _labOtherLogin;
}
- (UILabel *)labline1{
    if (!_labline1) {
        _labline1 = [[UILabel alloc]initWithFrame:CGRectMake(15, self.labOtherLogin.top+self.labOtherLogin.height/2, DeviceSize.width/2-20-self.labOtherLogin.width/2, 0.5)];
        _labline1.backgroundColor = [UIColor whiteColor];
    }
    return _labline1;
}
- (UILabel *)labline2{
    if (!_labline2) {
        _labline2 = [[UILabel alloc]initWithFrame:CGRectMake(DeviceSize.width/2+self.labOtherLogin.width/2+5, self.labOtherLogin.top+self.labOtherLogin.height/2, DeviceSize.width/2-20-self.labOtherLogin.width/2, 0.5)];
        _labline2.backgroundColor = [UIColor whiteColor];
    }
    return _labline2;
}
- (UIButton *)btn1{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(((DeviceSize.width - 30)-3*35)/4+15,self.labline1.bottom + 20, 35, 35);
        [_btn1 setImage:[UIImage imageNamed:@"新浪微博"] forState:UIControlStateNormal];
        [_btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}
- (UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(((DeviceSize.width - 30)-3*35)/4+self.btn1.right,self.labline1.bottom + 20, 35, 35);
        [_btn2 setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
        [_btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}
- (UIButton *)btn3{
    if (!_btn3) {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3.frame = CGRectMake(((DeviceSize.width - 30)-3*35)/4+self.btn2.right,self.labline1.bottom + 20, 35, 35);
        [_btn3 setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
        [_btn3 addTarget:self action:@selector(btn3Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}
- (void)btnRememberClick:(UIButton *)button{

}
- (void)btnLoginClick:(UIButton *)button{
 
}
- (void)btn1Click:(UIButton *)button{
    
}
- (void)btn2Click:(UIButton *)button{
    
}
- (void)btn3Click:(UIButton *)button{
    
}
- (void)btnRegisteredClick:(UIButton *)button{
    RegisterViewController * RegisterVc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:RegisterVc animated:YES];
}
- (void)btnForgetClick:(UIButton *)button{
    
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
