//
//  AddAddressViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddressView.h"

@interface AddAddressViewController ()
@property (nonatomic, strong) AddressView * nameView;
@property (nonatomic, strong) AddressView * phoneView;
@property (nonatomic, strong) AddressView * addressView;
@property (nonatomic, strong) AddressView * addressDetailView;
@property (nonatomic, strong) AddressView * codeView;
@property (nonatomic, strong) UIButton * btnDefault;
@property (nonatomic, strong) UILabel * labLine;

@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.title = @"收货地址";
    [self.view addSubview:self.nameView];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.addressView];
    [self.view addSubview:self.addressDetailView];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.btnDefault];
    [self.view addSubview:self.labLine];
//    [self getHomeData];
    // Do any additional setup after loading the view.
}
- (AddressView *)nameView{
    if (!_nameView) {
        _nameView = [[AddressView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 44) title:@"收件人" placeholder:@"名字"];
    }
    return _nameView;
}
- (AddressView *)phoneView{
    if (!_phoneView) {
        _phoneView = [[AddressView alloc]initWithFrame:CGRectMake(0, self.nameView.bottom, DeviceSize.width, 44) title:@"手机号" placeholder:@"11位手机号"];
    }
    return _phoneView;
}
- (AddressView *)addressView{
    if (!_addressView) {
        _addressView = [[AddressView alloc]initWithFrame:CGRectMake(0, self.phoneView.bottom, DeviceSize.width, 44) title:@"选择地区" placeholder:@"地区信息"];
    }
    return _addressView;
}
- (AddressView *)addressDetailView{
    if (!_addressDetailView) {
        _addressDetailView = [[AddressView alloc]initWithFrame:CGRectMake(0, self.addressView.bottom, DeviceSize.width, 44) title:@"详细地址" placeholder:@"街道门牌信息"];
    }
    return _addressDetailView;
}
- (AddressView *)codeView{
    if (!_codeView) {
        _codeView = [[AddressView alloc]initWithFrame:CGRectMake(0, self.addressDetailView.bottom, DeviceSize.width, 44) title:@"邮政编码" placeholder:@"邮政编码"];
    }
    return _codeView;
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIButton *)btnDefault{
    if (!_btnDefault) {
        _btnDefault = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDefault.frame = CGRectMake(10, self.codeView.bottom, DeviceSize.width-20, 45);
        [_btnDefault setImage:[UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_支付-点击状态"] forState:UIControlStateSelected];
        [_btnDefault setImage:[UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_点击-非点击状态"] forState:UIControlStateNormal];
        _btnDefault.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"设置默认地址(每次购买会使用默认地址)"];
        _btnDefault.titleLabel.font = [UIFont systemFontOfSize:15];
        NSRange range = [@"设置默认地址(每次购买会使用默认地址)" rangeOfString:@"(每次购买会使用默认地址)"];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range];
        [_btnDefault setAttributedTitle:str forState:UIControlStateNormal];
        [_btnDefault addTarget:self action:@selector(btnDefaultClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDefault;
}
- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc]initWithFrame:CGRectMake(0, self.btnDefault.bottom, DeviceSize.width, 1)];
        _labLine.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:0.5];
    }
    return _labLine;
}
- (void)btnDefaultClick:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}
//- (void)getHomeData{
//    [self showHudWaitingView:WaitPrompt];
//    WeakSelf(AddAddressViewController);
//    [[THNetWorkManager shareNetWork]getAddAddressName:@"" mobile:@"" area_ids:@"" address:@"" zipcode:@"" is_default:@"" andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
//        [weakSelf removeMBProgressHudInManaual];
//        if (response.responseCode == 1) {
//            
//        }else{
//            [weakSelf showHudAuto:response.message andDuration:@"2"];
//        }
//    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
//        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
//    }];
//}

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
