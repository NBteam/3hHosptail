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
    
    NSArray *arrDetail = @[@"请输入完成银行卡号",@"请输入开户银行名称",@"请输入持卡人姓名",@"请输入银行卡预留手机号"];
    if (textField1.text.length == 0) {
        [self showHudAuto:arrDetail[0] andDuration:@"2"];
    }else if (textField2.text.length == 0){
        [self showHudAuto:arrDetail[1] andDuration:@"2"];
    }else if (textField3.text.length == 0){
        [self showHudAuto:arrDetail[2] andDuration:@"2"];
    }else if (textField4.text.length == 0){
        [self showHudAuto:arrDetail[3] andDuration:@"2"];
    }else{
        AddCardsResultViewController *addCardsResultVc = [[AddCardsResultViewController alloc] init];
        addCardsResultVc.index = 0;
        [self.navigationController pushViewController:addCardsResultVc animated:YES];
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
    NSArray *arrTitle = @[@"卡号",@"开户行",@"姓名",@"手机号码"];
    NSArray *arrDetail = @[@"请输入完成银行卡号",@"请输入开户银行名称",@"请输入持卡人姓名",@"请输入银行卡预留手机号"];
    
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

        txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:arrDetail[i] attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        
        txtField.tag = 500 +i;
        
        [self.view addSubview:view];
        [view addSubview:lab];
        [view addSubview:txtField];

        
    }
    
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
