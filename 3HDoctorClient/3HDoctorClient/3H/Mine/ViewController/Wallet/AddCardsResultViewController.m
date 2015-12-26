//
//  AddCardsResultViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/26.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddCardsResultViewController.h"

@interface AddCardsResultViewController ()

@end

@implementation AddCardsResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"完成"];
    
    [self customView];
}

- (void)rightAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)customView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, DeviceSize.width -1, 150)];
    view.backgroundColor = [UIColor colorWithHEX:0xffffff];
    view.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
    view.layer.borderWidth = 0.5;
    
    [self.view addSubview:view];
    
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake((DeviceSize.width -50)/2, 25, 50, 50)];
    imgLogo.image = [UIImage imageNamed:@"我的钱包－申请成功icon"];
    [view addSubview:imgLogo];
    
    UILabel *labTilte = [[UILabel alloc] initWithFrame:CGRectMake(0, imgLogo.bottom +15, DeviceSize.width, 15)];
    labTilte.textColor = AppDefaultColor;
    labTilte.font = [UIFont systemFontOfSize:15];
    labTilte.textAlignment = NSTextAlignmentCenter;
    if (self.index == 1) {
        labTilte.text = @"您的提现申请已经提交成功!";
    }else{
        labTilte.text = @"您的银行卡已绑定成功!";
    }
    
    [view addSubview:labTilte];
    
    UILabel *labDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, labTilte.bottom +10, DeviceSize.width, 13)];
    labDetail.textColor = [UIColor colorWithHEX:0x333333];
    labDetail.font = [UIFont systemFontOfSize:13];
    labDetail.textAlignment = NSTextAlignmentCenter;
    if (self.index == 1) {
        labDetail.text = @" 我们将在3日内完成对提现申请的处理。";
    }else{
        labDetail.text = @" 将在3日内完成对银行卡绑定的处理。";
    }
    [view addSubview:labDetail];

}

- (NSString *)title{
    if (self.index == 1) {
        return @"申请成功";
    }else{
        return @"绑定成功";
    }
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
