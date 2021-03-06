//
//  ShopBuyFinishViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/27.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "ShopBuyFinishViewController.h"

@interface ShopBuyFinishViewController ()
@property (nonatomic, copy) UIView * viewBack;
@property (nonatomic, copy) UIImageView * imaGreen;
@property (nonatomic, copy) UILabel * labInfo;
@end

@implementation ShopBuyFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买成功";
    [self.view addSubview:self.viewBack];
    [self.viewBack addSubview:self.imaGreen];
    [self.viewBack addSubview:self.labInfo];
    self.viewBack.frame = CGRectMake(0, 10, DeviceSize.width, self.labInfo.bottom + 20);
    self.labInfo.text = [NSString stringWithFormat:@"购买商品成功，花费%@元",self.priceStr];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
}
- (void)backAction{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 10, DeviceSize.width, 200)];
        _viewBack.backgroundColor = [UIColor whiteColor];
    }
    return _viewBack;
}
- (UIImageView *)imaGreen{
    if (!_imaGreen) {
        _imaGreen = [[UIImageView alloc]initWithFrame:CGRectMake(self.viewBack.width/2 - 25, 20, 50, 50)];
        _imaGreen.backgroundColor = [UIColor greenColor];
        _imaGreen.layer.cornerRadius = 25.f;
        _imaGreen.layer.masksToBounds = YES;
    }
    return _imaGreen;
}
- (UILabel *)labInfo{
    if (!_labInfo) {
        _labInfo = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imaGreen.bottom+10, DeviceSize.width, 15)];
        _labInfo.textAlignment = NSTextAlignmentCenter;
        _labInfo.font = [UIFont systemFontOfSize:15];
    }
    return _labInfo;
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
