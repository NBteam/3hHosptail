//
//  AddAssistantDoctorViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/26.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddAssistantDoctorViewController.h"
#import "QRCodeGenerator.h"
@interface AddAssistantDoctorViewController ()

@property (nonatomic, strong) UIView *viewBack;

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labName;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIImageView *imgBack;
//首页-患者中心-添加患者(扫一扫)_二维码
@property (nonatomic, strong) UIImageView *imgCode;

@end

@implementation AddAssistantDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.viewBack];
    [self.viewBack addSubview:self.imgLogo];
    [self.viewBack addSubview:self.labName];
    [self.viewBack addSubview:self.labDetail];
    [self.view addSubview:self.imgBack];
    [self.imgBack addSubview:self.imgCode];
    [self.view addSubview:self.labTitle];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];

}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(-0.5, 10, DeviceSize.width +1, 70)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.borderWidth = 0.5;
        _viewBack.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        
    }
    return _viewBack;
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _imgLogo.layer.masksToBounds = YES;
        _imgLogo.layer.cornerRadius = 25;
        [_imgLogo sd_setImageWithURL:[NSURL URLWithString:self.user.pic]];
        
    }
    return _imgLogo;
}

- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 18, DeviceSize.width -self.imgLogo.right -20, 15)];
        _labName.textColor = [UIColor colorWithHEX:0x333333];
        _labName.font = [UIFont systemFontOfSize:15];
        _labName.text = self.user.truename;
    }
    return _labName;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 70 -13 -18, DeviceSize.width -self.imgLogo.right -20, 13)];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        _labDetail.font = [UIFont systemFontOfSize:13];
        _labDetail.text = [NSString stringWithFormat:@"%@  %@",self.user.hospital,self.user.job_title];
    }
    return _labDetail;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgBack.bottom +15, DeviceSize.width, 13)];
        _labTitle.textColor = [UIColor colorWithHEX:0x888888];
        _labTitle.font = [UIFont systemFontOfSize:13];
        _labTitle.text = @"请助理医师用APP扫一扫,加我建立指导关系";
        _labTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labTitle;
}


- (UIImageView *)imgBack{
    if (!_imgBack) {
        _imgBack = [[UIImageView alloc] initWithFrame:CGRectMake((DeviceSize.width -260)/2, self.viewBack.bottom +25, 260, 260)];
        _imgBack.image = [UIImage imageNamed:@"首页-患者中心-添加患者(扫一扫)_二维码"];
        
    }
    return _imgBack;
}

- (UIImageView *)imgCode{
    if (!_imgCode) {
        _imgCode = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 260 -60, 260 -60)];
        _imgCode.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _imgCode.image = [QRCodeGenerator qrImageForString:self.user.id imageSize:_imgCode.bounds.size.width];
        
    }
    return _imgCode;
}

- (NSString *)title{
    return @"添加助理医师";
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
