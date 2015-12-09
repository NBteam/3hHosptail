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
@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.phoneView];
    // Do any additional setup after loading the view.
}
- (AddPatientsPhoneView *)phoneView{
    if (!_phoneView) {
        _phoneView = [[AddPatientsPhoneView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 150)];
    }
    return _phoneView;
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
