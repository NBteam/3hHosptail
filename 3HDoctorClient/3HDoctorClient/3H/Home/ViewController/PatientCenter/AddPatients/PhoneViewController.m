//
//  PhoneViewController.m
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PhoneViewController.h"
#import "AddPatientsPhoneView.h"

@interface PhoneViewController ()
@property (nonatomic, strong) AddPatientsPhoneView * phoneView;

@property (nonatomic, strong) UIButton *btnCancel;
@end

@implementation PhoneViewController

- (void)loadView{
    [super loadView];
    self.view = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.height = self.view.height - self.frameTopHeight -44;
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.btnCancel];
    
    NSLog(@"----%f",self.view.height);
    // Do any additional setup after loading the view.
}
- (AddPatientsPhoneView *)phoneView{
    if (!_phoneView) {
        _phoneView = [[AddPatientsPhoneView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 150)];
    }
    return _phoneView;
}

#pragma mark -UI
- (UIButton *)btnCancel{
    if (!_btnCancel) {
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCancel.frame = CGRectMake(10, self.view.height -65, DeviceSize.width -20, 45);
        _btnCancel.layer.masksToBounds = YES;
        _btnCancel.layer.cornerRadius = 5;
        _btnCancel.backgroundColor = AppDefaultColor;
        [_btnCancel setTitle:@"确定" forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnCancel setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_btnCancel addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnCancel;
}

- (void)btnCancelAction{
    if (self.phoneView.textField.text.length == 0) {
        [self showHudAuto:@"请输入手机号" andDuration:@"2"];
    }else{
        [self sendInviteToPatient];
    }
}

- (void)sendInviteToPatient{
   
    [self showHudAuto:@"发送中..."];
    WeakSelf(PhoneViewController);
    
    [[THNetWorkManager shareNetWork] sendInviteToPatientmobile:self.phoneView.textField.text andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            [weakSelf showHudAuto:@"发送成功" andDuration:@"2"];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
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
