//
//  AddressAddViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/20.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddressAddViewController.h"
#import "AddressView.h"
#import "CityListFirstLevelViewController.h"

@interface AddressAddViewController ()
@property (nonatomic, strong) AddressView * nameView;
@property (nonatomic, strong) AddressView * phoneView;
@property (nonatomic, strong) AddressView * addressView;
@property (nonatomic, strong) AddressView * addressDetailView;
@property (nonatomic, strong) AddressView * codeView;
@property (nonatomic, strong) UIButton * btnDefault;
@property (nonatomic, strong) UILabel * labLine;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, copy) NSString * cityId;
@end

@implementation AddressAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"保存"];
    self.title = @"收货地址";
    self.selectIndex = 0;
    [self.view addSubview:self.nameView];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.addressView];
    [self.view addSubview:self.addressDetailView];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.btnDefault];
    [self.view addSubview:self.labLine];
    
    // Do any additional setup after loading the view.
}
- (void)rightAction{
    [self getHomeData];
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
        _addressView.textDetail.enabled = NO;
        UITapGestureRecognizer * addressViewTap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressViewGesture)];
        [_addressView addGestureRecognizer:addressViewTap];
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceSize.width -17/2 -10, (44 -15)/2, 17/2, 15)];
        img.image = [UIImage imageNamed:@"arrowImg"];
        [_addressView addSubview:img];
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
        _labLine = [[UILabel alloc]initWithFrame:CGRectMake(0, self.btnDefault.bottom, DeviceSize.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}
- (void)btnDefaultClick:(UIButton *)btn{
    if (btn.selected) {
        self.selectIndex = 1;
        btn.selected = NO;
    }else{
        self.selectIndex = 0;
        btn.selected = YES;
    }
}
- (void)addressViewGesture{
    CityListFirstLevelViewController * CityListFirstLevelVc = [[CityListFirstLevelViewController alloc]init];
    WeakSelf(AddressAddViewController);
    [CityListFirstLevelVc  setCityListBlock:^(NSString *areaname,NSString *ids,NSString *parent_id) {
        weakSelf.cityId = [NSString stringWithFormat:@"%@,%@",ids,parent_id];
        weakSelf.addressView.textDetail.text = [NSString stringWithFormat:@"%@",areaname];
    }];
    [self.navigationController pushViewController:CityListFirstLevelVc animated:YES];
}
- (void)getHomeData{

    [self showHudWaitingView:WaitPrompt];
    WeakSelf(AddressAddViewController);
    [[THNetWorkManager shareNetWork]getAddAddressName:self.nameView.textDetail.text mobile:self.phoneView.textDetail.text area_ids:self.cityId address:self.addressDetailView.textDetail.text zipcode:self.codeView.textDetail.text is_default:[NSString stringWithFormat:@"%ld",self.selectIndex] andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.reloadInfo) {
                weakSelf.reloadInfo();
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (void)setDefaultAddress{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(AddressAddViewController);
    [[THNetWorkManager shareNetWork]setDefaultAddressId:@"" andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
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
