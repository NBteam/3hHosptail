//
//  AddCardsViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/26.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddCardsViewController.h"
#import "AddCardsResultViewController.h"
@interface AddCardsViewController ()


@property (nonatomic, strong) UILabel *labTitle;

@end

@implementation AddCardsViewController





- (void)rightAction{
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:500];
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:501];
    UITextField *textField3 = (UITextField *)[self.view viewWithTag:502];
    UITextField *textField4 = (UITextField *)[self.view viewWithTag:503];
    
    NSArray *arrDetail = @[@"请输入持卡人姓名",@"卡类型",@"请输入完成银行卡号",@"请输入银行卡预留手机号"];
    if (textField1.text.length == 0) {
        [self showHudAuto:arrDetail[0] andDuration:@"2"];
    }else if (textField3.text.length == 0){
        [self showHudAuto:arrDetail[2] andDuration:@"2"];
    }else if (textField4.text.length == 0){
        [self showHudAuto:arrDetail[3] andDuration:@"2"];
    }else{
        [self getNetWorkBank_id:@"" bank_account:textField3.text bank_username:textField1.text bank_type:textField2.text bank_bind_mobile:textField4.text];
    }
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"下一步"];

    [self.view addSubview:self.labTitle];
    [self customView];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width -20, 40)];
        _labTitle.text = @"请输入银行卡信息";
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
    }
    return _labTitle;
}

- (void)customView{
    NSArray *arrTitle = @[@"持卡人",@"卡类型",@"银行卡号",@"手机号码"];
    NSArray *arrDetail = @[@"请输入持卡人姓名",@"",@"请输入完成银行卡号",@"请输入银行卡预留手机号"];
    
    for (int i = 0; i<arrDetail.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-1, self.labTitle.bottom +44.5*i, DeviceSize.width +2, 45)];
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        view.backgroundColor = [UIColor colorWithHEX:0xffffff];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 45)];
        lab.textColor = [UIColor colorWithHEX:0x333333];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentRight;
        lab.text = arrTitle[i];
        
        UITextField *txtField = [[UITextField alloc] initWithFrame:CGRectMake(lab.right +20, 0, view.width - lab.width -40, 45)];
        txtField.textColor = [UIColor colorWithHEX:0x333333];
        txtField.font = [UIFont systemFontOfSize:15];
        //是否纠错
        txtField.autocorrectionType = UITextAutocorrectionTypeNo;
        if (i == 0 ||i ==3) {
            txtField.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (i == 1 ) {
            UIImageView *imgRight = [[UIImageView alloc]initWithFrame:CGRectMake(view.width - 19/2 -15, (view.height - 34/2)/2, 19/2, 34/2)];
            txtField.enabled = NO;
            imgRight.image = [UIImage imageNamed:@"3H-首页_键"];
            [view addSubview:imgRight];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
            [view addGestureRecognizer:tap];
        }
        
        txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:arrDetail[i] attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        
        txtField.tag = 500 +i;
        
        [self.view addSubview:view];
        [view addSubview:lab];
        [view addSubview:txtField];

        
    }
    
}
- (void)tapView:(UITapGestureRecognizer *)tap{
    NSLog(@"11111");
}
- (void)getNetWorkBank_id:(NSString *)Bank_id bank_account:(NSString *)bank_account bank_username:(NSString *)bank_username bank_type:(NSString *)bank_type bank_bind_mobile:(NSString *)bank_bind_mobile{
    WeakSelf(AddCardsViewController);
    [weakSelf showHudWaitingView:WaitPrompt];
    [[THNetWorkManager shareNetWork]addBankCardBank_id:Bank_id bank_account:bank_account bank_username:bank_username bank_type:bank_type bank_bind_mobile:bank_bind_mobile andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            AddCardsResultViewController *addCardsResultVc = [[AddCardsResultViewController alloc] init];
            addCardsResultVc.index = 0;
            [weakSelf.navigationController pushViewController:addCardsResultVc animated:YES];
        } else {
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (NSString *)title{
    return @"绑定银行卡";
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
