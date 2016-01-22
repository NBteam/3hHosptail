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
#import "AppDelegate.h"
#import "UMSocial.h"
#import "ForgetPossWordViewController.h"
#import "EaseMob.h"

@interface LoginViewController ()<UITextFieldDelegate,UMSocialUIDelegate>
//背景
@property (nonatomic, strong) UIImageView * imgLogo;
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
    
    self.view.backgroundColor = [UIColor colorWithHEX:0xff9358];
    [self.view addSubview:self.imgLogo];
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

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake((DeviceSize.width -172)/2, 80, 172, 132)];
        _imgLogo.image = [UIImage imageNamed:@"3H-注册_3H (2)"];
    }
    return _imgLogo;
}
- (LoginInputView *)textUserName{
    if (!_textUserName) {
        _textUserName = [[LoginInputView alloc]initWithFrame:CGRectMake(0, 480/2, DeviceSize.width, 96/2) title:@"" placeholder:@"请输入手机号"];
        _textUserName.textField.delegate = self;
        _textUserName.textField.keyboardType=UIKeyboardTypePhonePad;
        _textUserName.textField.textColor = AppDefaultColor;
        _textUserName.textField.text = @"18911412662";
    }
    return _textUserName;
}
- (LoginInputView *)textUserPwd{
    if (!_textUserPwd) {
        _textUserPwd = [[LoginInputView alloc]initWithFrame:CGRectMake(0, self.textUserName.bottom+15, DeviceSize.width, 96/2) title:@"" placeholder:@"请输入密码"];
        _textUserPwd.textField.delegate = self;
        _textUserPwd.textField.keyboardType=UIKeyboardTypePhonePad;
        _textUserPwd.textField.textColor = AppDefaultColor;
        _textUserPwd.textField.text = @"123456";
    }
    return _textUserPwd;
}
- (UIButton *)btnRemember{
    if (!_btnRemember) {
        _btnRemember = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRemember.frame = CGRectMake(15, self.textUserPwd.bottom+10, 100, 20);
        [_btnRemember setImage:[UIImage imageNamed:@"3H-注册_选框"] forState:UIControlStateNormal];
        [_btnRemember setImage:[UIImage imageNamed:@"3H-注册_全选"] forState:UIControlStateSelected];
        _btnRemember.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnRemember setTitle:@" 记住我" forState:UIControlStateNormal];
        [_btnRemember addTarget:self action:@selector(btnRememberClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnRemember.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
        _btnLogin.backgroundColor = AppDefaultColor;
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
    if (button.selected) {
        button.selected = NO;
    }else{
        button.selected = YES;
    }
}
- (void)btnLoginClick:(UIButton *)button{
    
    if ([self.textUserName.textField.text isEqualToString:@""]) {
        [self showHudAuto:@"请输入手机号" andDuration:@"2"];
    }else if ([self.textUserPwd.textField.text isEqualToString:@""]){
        [self showHudAuto:@"请输入密码" andDuration:@"2"];
    }else{
        
        [self showHudWaitingView:WaitPrompt];
        WeakSelf(LoginViewController);
        [[THNetWorkManager shareNetWork] patientLoginMobile:self.textUserName.textField.text Password:self.textUserPwd.textField.text CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
            [weakSelf removeMBProgressHudInManaual];
            NSLog(@"查看%@",response.dataDic);
            if (response.responseCode == 1) {
                [SGSaveFile saveObjectToSystem:response.dataDic[@"token"] forKey:Token];
                [weakSelf getUserInfoToken:response.dataDic[@"token"] pwd:weakSelf.textUserPwd.textField.text];
                
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
    
    [[THNetWorkManager shareNetWork] getUserinfoToken:token CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];

        if (response.responseCode == 1) {
            
            THUser *user = [MTLJSONAdapter modelOfClass:[THUser class] fromJSONDictionary:response.dataDic error:nil];
            
            
            if (user) {
                [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:user.id password:pwd withCompletion:^(NSString *username, NSString *password, EMError *error) {
                    if (!error) {
                        NSLog(@"注册成功");
        
                        BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
                        if (!isAutoLogin) {
                            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:user.id password:weakSelf.textUserPwd.textField.text completion:^(NSDictionary *loginInfo, EMError *error) {
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
                            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:user.id  password:weakSelf.textUserPwd.textField.text completion:^(NSDictionary *loginInfo, EMError *error) {
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
                        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:user.id  password:weakSelf.textUserPwd.textField.text completion:^(NSDictionary *loginInfo, EMError *error) {
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

- (void)btn1Click:(UIButton *)button{
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
                
                weakSelf.openedString = response.data[@"uid"];;
                [weakSelf openLoginFornickname];
            }];
        }
        
    });
    
    
}
- (void)btn2Click:(UIButton *)button{
    
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
                
                [weakSelf openLoginFornickname];
            }];
            
            
        }});
    
    
}
- (void)btn3Click:(UIButton *)button{
    
    WeakSelf(LoginViewController);
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
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
        
        [weakSelf getUserInfoToken:response.dataDic[@"token"] pwd:self.textUserPwd.textField.text
         ];
        NSLog(@"查看%@",response.dataDic);
        
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        
    }];
}
- (void)btnRegisteredClick:(UIButton *)button{
    RegisterViewController * RegisterVc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:RegisterVc animated:YES];
}
- (void)btnForgetClick:(UIButton *)button{
    ForgetPossWordViewController * ForgetPossWordVc = [[ForgetPossWordViewController alloc]init];
    ForgetPossWordVc.index = 0;
    [self.navigationController pushViewController:ForgetPossWordVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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
