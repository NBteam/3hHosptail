//
//  LoginViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginInputView.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "UMSocial.h"
#import "ForgetPossWordViewController.h"
#import "EaseMob.h"
#import "UMSocial.h"


@interface LoginViewController ()
//蓝色背景
@property (nonatomic, strong) UIView *viewBlue;
//appLogo
@property (nonatomic, strong) UIImageView *imgLogo;
//白色波浪
@property (nonatomic, strong) UIImageView *imgWhite;
//注册按钮
@property (nonatomic, strong) UIButton *btnRegister;
//用户名
@property (nonatomic, strong) UITextField *txtUserName;
//下划线
@property (nonatomic, strong) UILabel *labLineUserName;
//密码
@property (nonatomic, strong) UITextField *txtPassWord;
//下划线
@property (nonatomic, strong) UILabel *labLinePassWord;

//记住我
@property (nonatomic, strong) UIButton * btnRemember;
//忘记密码
@property (nonatomic, strong) UIButton *btnForgetPassWord;
//立即登陆
@property (nonatomic, strong) UIButton *btnLogin;

//线
@property (nonatomic, strong) UILabel *labLine;
@property (nonatomic, strong) UILabel *labLoginName;

//其他登录
@property (nonatomic, strong) UILabel * labOtherLogin;
//线1 线2
@property (nonatomic, strong) UILabel * labline1;
@property (nonatomic, strong) UILabel * labline2;
//第三方登录按钮
@property (nonatomic, copy) UIButton * btn1;
@property (nonatomic, strong) UIButton * btn2;
@property (nonatomic, strong) UIButton * btn3;

//第三方
//昵称
@property (nonatomic, copy) NSString *nicknameString;
//第三方用户统一ID
@property (nonatomic, copy) NSString *openedString;
//第三方类型（weixin、qq、weibo）
@property (nonatomic, copy) NSString *open_typeString;
//头像地址
@property (nonatomic, copy) NSString *picString;
//性别，0保密，1男，2女
@property (nonatomic, copy) NSString *sexString;

@end

@implementation LoginViewController

- (void)loadView{
    [super loadView];
    self.view = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHEX:0xffffff];
    [self.viewBlue addSubview:self.imgLogo];
    [self.viewBlue addSubview:self.imgWhite];
    self.viewBlue.height = self.imgWhite.bottom;
    [self.view addSubview:self.viewBlue];
    [self.view addSubview:self.btnRegister];
    [self.view addSubview:self.txtUserName];
    [self.view addSubview:self.labLineUserName];
    [self.view addSubview:self.txtPassWord];
    [self.view addSubview:self.labLinePassWord];
    [self.view addSubview:self.btnRemember];
    [self.view addSubview:self.btnForgetPassWord];
    [self.view addSubview:self.btnLogin];
    [self.view addSubview:self.labOtherLogin];
    [self.view addSubview:self.labline1];
    [self.view addSubview:self.labline2];
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    
    //[self customShareButtons];
}

#pragma mark -UI

- (UIView *)viewBlue{
    if (!_viewBlue) {
        _viewBlue = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0)];
        _viewBlue.backgroundColor = AppDefaultColor;
    }
    return _viewBlue;
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake((DeviceSize.width - 376/2)/2, 80, 376/2, 293/2)];
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

- (UIButton *)btnRegister{
    if (!_btnRegister) {
        _btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRegister.frame = CGRectMake(DeviceSize.width - 40 - 25, 11 +20, 40, 20);
        [_btnRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnRegister.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnRegister setTitle:@"注册" forState:UIControlStateNormal];
        UILabel *labLine = [[UILabel alloc] initWithFrame:CGRectMake(5, 18, 30, 1)];
        labLine.backgroundColor = [UIColor whiteColor];
        [_btnRegister addSubview:labLine];
        [_btnRegister addTarget:self action:@selector(btnRegisterAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnRegister;
}

- (void)btnRegisterAction{
    RegisterViewController * RegisterVc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:RegisterVc animated:YES];
}

- (UITextField *)txtUserName{
    if (!_txtUserName) {
        _txtUserName = [[UITextField alloc] initWithFrame:CGRectMake(15, self.viewBlue.bottom +10, DeviceSize.width -30, 30)];
        if ([SGSaveFile getObjectFromSystemWithKey:RememberMe]&&[[SGSaveFile getObjectFromSystemWithKey:UserName] length]>0) {
            _txtUserName.text = [SGSaveFile getObjectFromSystemWithKey:UserName];
        }
        //是否纠错
        _txtUserName.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtUserName.keyboardType = UIKeyboardTypeNumberPad;
        _txtUserName.font = [UIFont systemFontOfSize:15];
        _txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtUserName.textColor = AppDefaultColor;
    }
    return _txtUserName;
}

- (UILabel *)labLineUserName{
    if (!_labLineUserName) {
        _labLineUserName = [[UILabel alloc] initWithFrame:CGRectMake(self.txtUserName.left, self.txtUserName.bottom +10, self.txtUserName.width, 1)];
        _labLineUserName.backgroundColor = [UIColor colorWithHEX:0x888888];
    }
    return _labLineUserName;
}

- (UITextField *)txtPassWord{
    if (!_txtPassWord) {
        _txtPassWord = [[UITextField alloc] initWithFrame:CGRectMake(15, self.labLineUserName.bottom +10, DeviceSize.width -30, 30)];
        if ([SGSaveFile getObjectFromSystemWithKey:RememberMe] &&[[SGSaveFile getObjectFromSystemWithKey:UserPassword] length]>0) {
            _txtPassWord.text = [SGSaveFile getObjectFromSystemWithKey:UserPassword];
        }
        //是否纠错
        _txtPassWord.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtPassWord.secureTextEntry = YES;
        _txtPassWord.font = [UIFont systemFontOfSize:15];
        _txtPassWord.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtPassWord.textColor = AppDefaultColor;
    }
    return _txtPassWord;
}

- (UILabel *)labLinePassWord{
    if (!_labLinePassWord) {
        _labLinePassWord = [[UILabel alloc] initWithFrame:CGRectMake(self.txtPassWord.left, self.txtPassWord.bottom +10, self.txtPassWord.width, 1)];
        _labLinePassWord.backgroundColor = [UIColor colorWithHEX:0x888888];
    }
    return _labLinePassWord;
}

- (UIButton *)btnRemember{
    if (!_btnRemember) {
        _btnRemember = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRemember.frame = CGRectMake(15, self.labLinePassWord.bottom +10, 100, 20);
        [_btnRemember setImage:[UIImage imageNamed:@"3H-注册_选框"] forState:UIControlStateNormal];
        [_btnRemember setImage:[UIImage imageNamed:@"3H-注册_全选"] forState:UIControlStateSelected];
        _btnRemember.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnRemember setTitle:@" 记住我" forState:UIControlStateNormal];
        [_btnRemember setTitleColor:[UIColor colorWithHEX:0x888888] forState:UIControlStateNormal];
        [_btnRemember addTarget:self action:@selector(btnRememberClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnRemember.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        if ([SGSaveFile getObjectFromSystemWithKey:RememberMe]) {
            _btnRemember.selected = YES;
        }
    }
    return _btnRemember;
}

- (void)btnRememberClick:(UIButton *)button{
    
    button.selected = !button.selected;
}

- (UIButton *)btnForgetPassWord{
    if (!_btnForgetPassWord) {
        _btnForgetPassWord = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnForgetPassWord.frame = CGRectMake(15, self.labLinePassWord.bottom +10, 0, 20);
        [_btnForgetPassWord setTitleColor:[UIColor colorWithHEX:0x888888] forState:UIControlStateNormal];
        _btnForgetPassWord.titleLabel.font = [UIFont systemFontOfSize:12];
        [_btnForgetPassWord setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_btnForgetPassWord sizeToFit];
        _btnForgetPassWord.left = self.labLinePassWord.right - _btnForgetPassWord.width;
        [_btnForgetPassWord addTarget:self action:@selector(btnForgetPassWordAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnForgetPassWord;
}

- (void)btnForgetPassWordAction{
    ForgetPossWordViewController * ForgetPossWordVc = [[ForgetPossWordViewController alloc]init];
    ForgetPossWordVc.index = 0;
    [self.navigationController pushViewController:ForgetPossWordVc animated:YES];
}

- (UIButton *)btnLogin{
    if (!_btnLogin) {
        _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLogin.frame = CGRectMake(15, self.btnForgetPassWord.bottom +15, self.labLinePassWord.width, 45);
        [_btnLogin setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        _btnLogin.titleLabel.font = [UIFont systemFontOfSize:17];
        [_btnLogin setTitle:@"立即登录" forState:UIControlStateNormal];
        _btnLogin.layer.masksToBounds = YES;
        _btnLogin.layer.cornerRadius = 5;
        _btnLogin.backgroundColor = AppDefaultColor;
        
        [_btnLogin addTarget:self action:@selector(btnLoginAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnLogin;
}
- (UILabel *)labOtherLogin{
    if (!_labOtherLogin) {
        _labOtherLogin = [[UILabel alloc]initWithFrame:CGRectMake(0, self.btnLogin.bottom+20, 100, 13)];
        _labOtherLogin.text = @"使用以下账户登录";
        _labOtherLogin.font = [UIFont systemFontOfSize:13];
        _labOtherLogin.textColor = [UIColor colorWithHEX:0x999999];
        [_labOtherLogin sizeToFit];
        _labOtherLogin.left = (DeviceSize.width - _labOtherLogin.width)/2;
        _labOtherLogin.top = self.btnLogin.bottom+20;
    }
    return _labOtherLogin;
}
- (UILabel *)labline1{
    if (!_labline1) {
        _labline1 = [[UILabel alloc]initWithFrame:CGRectMake(15, self.labOtherLogin.top+self.labOtherLogin.height/2, DeviceSize.width/2-20-self.labOtherLogin.width/2, 0.5)];
        _labline1.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labline1;
}
- (UILabel *)labline2{
    if (!_labline2) {
        _labline2 = [[UILabel alloc]initWithFrame:CGRectMake(DeviceSize.width/2+self.labOtherLogin.width/2+5, self.labOtherLogin.top+self.labOtherLogin.height/2, DeviceSize.width/2-20-self.labOtherLogin.width/2, 0.5)];
        _labline2.backgroundColor = [UIColor  colorWithHEX:0xcccccc];
    }
    return _labline2;
}
- (UIButton *)btn1{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(((DeviceSize.width - 30)-3*35)/4+15,self.labline1.bottom + 20, 35, 35);
        [_btn1 setImage:[UIImage imageNamed:@"3H医生端-登录_新浪微博"] forState:UIControlStateNormal];
        [_btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}
- (UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(((DeviceSize.width - 30)-3*35)/4+self.btn1.right,self.labline1.bottom + 20, 35, 35);
        [_btn2 setImage:[UIImage imageNamed:@"3H医生端-登录_QQ"] forState:UIControlStateNormal];
        [_btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}
- (UIButton *)btn3{
    if (!_btn3) {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3.frame = CGRectMake(((DeviceSize.width - 30)-3*35)/4+self.btn2.right,self.labline1.bottom + 20, 35, 35);
        [_btn3 setImage:[UIImage imageNamed:@"3H医生端-登录_微信"] forState:UIControlStateNormal];
        [_btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}
- (void)btnLoginAction{
    if ([self.txtUserName.text isEqualToString:@""]) {
        [self showHudAuto:@"请输入手机号" andDuration:@"2"];
    }else if ([self.txtPassWord.text isEqualToString:@""]){
        [self showHudAuto:@"请输入密码" andDuration:@"2"];
    }else{
        [self showHudWaitingView:WaitPrompt];
        WeakSelf(LoginViewController);
        [[THNetWorkManager shareNetWork] patientLoginMobile:self.txtUserName.text Password:self.txtPassWord.text CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
            [weakSelf removeMBProgressHudInManaual];
            NSLog(@"查看%@",response.dataDic);
            if (response.responseCode == 1) {
                
                if (weakSelf.btnRemember.selected) {
                    [SGSaveFile saveObjectToSystem:RememberMe forKey:RememberMe];
                    [SGSaveFile saveObjectToSystem:self.txtUserName.text forKey:UserName];
                    [SGSaveFile saveObjectToSystem:self.txtPassWord.text forKey:UserPassword];
                }
                
                [SGSaveFile saveObjectToSystem:response.dataDic[@"token"] forKey:Token];
                [weakSelf getUserInfoToken:response.dataDic[@"token"] pwd:weakSelf.txtPassWord.text];
                
            }else{
                [weakSelf showHudAuto:response.message andDuration:@"1"];
            }
        } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
            [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"1"];
        } ];
    }
    
}
- (void)getUserInfoToken:(NSString *)token pwd:(NSString *)pwd{
    WeakSelf(LoginViewController);
    [SGSaveFile saveObjectToSystem:token forKey:Token];
    [[THNetWorkManager shareNetWork] getUserinfoToken:token CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        
        if (response.responseCode == 1) {
            
            THUser *user = [MTLJSONAdapter modelOfClass:[THUser class] fromJSONDictionary:response.dataDic error:nil];
            
            
            if (user) {
                [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:user.md5_id password:[user.md5_id substringToIndex:10] withCompletion:^(NSString *username, NSString *password, EMError *error) {
                    if (!error) {
                        NSLog(@"注册成功");
                        
                        BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
                        if (!isAutoLogin) {
                            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:user.md5_id password:[user.md5_id substringToIndex:10] completion:^(NSDictionary *loginInfo, EMError *error) {
                                if (!error) {
                                    // 设置自动登录
                                    [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:NO];
                                    [(AppDelegate*)[UIApplication sharedApplication].delegate setWindowRootViewControllerIsTabBar];
                                }
                                if (error.errorCode == EMErrorServerTooManyOperations) {
                                    [(AppDelegate*)[UIApplication sharedApplication].delegate setWindowRootViewControllerIsTabBar];
                                }
                            } onQueue:nil];
                        }else{
                            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:user.md5_id  password:[user.md5_id substringToIndex:10] completion:^(NSDictionary *loginInfo, EMError *error) {
                                if (!error && loginInfo) {
                                    NSLog(@"登陆成功");
                                    [(AppDelegate*)[UIApplication sharedApplication].delegate setWindowRootViewControllerIsTabBar];
                                }
                                if (error.errorCode == EMErrorServerTooManyOperations) {
                                    [(AppDelegate*)[UIApplication sharedApplication].delegate setWindowRootViewControllerIsTabBar];
                                }
                            } onQueue:nil];
                            
                        }
                    }else{
                        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:user.md5_id  password:[user.md5_id substringToIndex:10] completion:^(NSDictionary *loginInfo, EMError *error) {
                            if (!error && loginInfo) {
                                NSLog(@"登陆成功");
                                [(AppDelegate*)[UIApplication sharedApplication].delegate setWindowRootViewControllerIsTabBar];
                            }
                            if (error.errorCode == EMErrorServerTooManyOperations) {
                                [(AppDelegate*)[UIApplication sharedApplication].delegate setWindowRootViewControllerIsTabBar];
                            }
                        } onQueue:nil];
                    }
                } onQueue:nil];
                
                //  写入本地
                [THUser writeUserToLacalPath:UserPath andFileName:@"User" andWriteClass:user];
            }
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    } ];
}
#pragma mark -环信注册
- (void)HXReg{
    WeakSelf(LoginViewController);
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.user.md5_id password:[self.user.md5_id substringToIndex:10] withCompletion:^(NSString *username, NSString *password, EMError *error) {
        if (!error) {
            NSLog(@"注册成功");
            [weakSelf HXLogin];
            
        }else{
            [weakSelf HXLogin];
        }
        
    } onQueue:nil];
}
#pragma mark -环信登陆
- (void)HXLogin{
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.user.md5_id password:[self.user.md5_id substringToIndex:10] completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            NSLog(@"环信登陆成功");
        }else{
            
        }
    } onQueue:nil];
}


- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(35, self.btnLogin.bottom +30, DeviceSize.width -70, 1)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
        _labLine.layer.masksToBounds = NO;
    }
    return _labLine;
}

- (UILabel *)labLoginName{
    if (!_labLoginName) {
        _labLoginName = [[UILabel alloc] init];
        _labLoginName.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _labLoginName.text = @"使用以下账户直接登录";
        _labLoginName.textAlignment = NSTextAlignmentCenter;
        _labLoginName.textColor = [UIColor colorWithHEX:0x999999];
        _labLoginName.font = [UIFont systemFontOfSize:13];
        [_labLoginName sizeToFit];
        
    _labLoginName.frame = CGRectMake(self.labLine.left +(self.labLine.width -_labLoginName.width -30)/2, self.labLine.top -6, _labLoginName.width +30, 13);
        
    }
    return _labLoginName;
}

- (void)customShareButtons{
    NSArray *arr = @[@"3H医生端-登录_新浪微博",@"3H医生端-登录_QQ",@"3H医生端-登录_微信"];
    CGFloat f = (DeviceSize.width -35*3 -90)/2;
    for (int i = 0; i <arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(f +(35 +45)*i, self.labLoginName.bottom +15, 35, 35);
        [btn setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 +i;
        [self.view addSubview:btn];
        
    }
}

- (void)btnAction:(UIButton *)button{
    if (button.tag == 1000) {//新浪微博
        [self btn1Click];
    }else if(button.tag == 1001){//QQ登录
        [self btn2Click];
    }else{//微信登录
        [self btn3Click];
    }
}


- (void)btn1Click{
    WeakSelf(LoginViewController);
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.openId);
            //得到的数据在回调Block对象形参respone的data属性
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                NSLog(@"SnsInformation is %@",response.data);
                //昵称
                weakSelf.nicknameString = response.data[@"screen_name"];
                //第三方用户统一ID
                weakSelf.openedString = response.data[@"openid"];
                //第三方类型（weixin、qq、weibo）
                weakSelf.open_typeString = @"weibo";
                //头像地址
                weakSelf.picString = response.data[@"profile_image_url"];
                //性别，0保密，1男，2女
                weakSelf.sexString = [NSString stringWithFormat:@"%@",response.data[@"gender"]];
                
                weakSelf.openedString = response.data[@"uid"];
                [weakSelf openLoginFornickname];
            }];
        }
        
    });
    
    
}
- (void)btn2Click{
    WeakSelf(LoginViewController);
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            //得到的数据在回调Block对象形参respone的data属性
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
                NSLog(@"SnsInformation is %@",response.data);
                //昵称
                weakSelf.nicknameString = response.data[@"screen_name"];
                
                //第三方类型（weixin、qq、weibo）
                weakSelf.open_typeString = @"qq";
                //头像地址
                weakSelf.picString = response.data[@"profile_image_url"];
                //性别，0保密，1男，2女
                weakSelf.sexString = [NSString stringWithFormat:@"%@",response.data[@"gender"]];
                weakSelf.openedString = response.data[@"openid"];
                
                [weakSelf openLoginFornickname];
            }];
            
            
        }});
}
- (void)btn3Click{
    
    WeakSelf(LoginViewController);
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"%@",response);
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            //得到的数据在回调Block对象形参respone的data属性
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
                NSLog(@"SnsInformation is %@",response.data);
                //昵称
                weakSelf.nicknameString = response.data[@"screen_name"];
                //第三方用户统一ID
                weakSelf.openedString = response.data[@"openid"];
                //第三方类型（weixin、qq、weibo）
                weakSelf.open_typeString = @"weixin";
                //头像地址
                weakSelf.picString = response.data[@"profile_image_url"];
                //性别，0保密，1男，2女
                weakSelf.sexString = [NSString stringWithFormat:@"%@",response.data[@"gender"]];
                [weakSelf openLoginFornickname];
            }];
            
            
            
            
        }
        
    });
    
    
    
}

- (void)openLoginFornickname{
    WeakSelf(LoginViewController);
    [[THNetWorkManager shareNetWork] openLoginFornickname:self.nicknameString opened:self.openedString open_type:self.open_typeString pic:self.picString sex:self.sexString andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        
        [weakSelf getUserInfoToken:response.dataDic[@"token"] pwd:self.txtPassWord.text
         ];
        NSLog(@"查看%@",response.dataDic);
        
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        
    }];
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
