//
//  AboutViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.label];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width - 30, 0)];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor colorWithHEX:0x333333];
        _label.text = @"   3H健康管理，秉承个性化检测及管理（Humanity），专家指导下的健康管理（Healthcare），疾病治愈及恢复（Heal）三大理念，包括癌症早期筛查、权威医院住院体检、健康管理、疾病救护通道四个组成部分，每个客户配备私人“医学助理”，随时线上，线下沟通，反馈，专家指导，打造健康管理的国内最高品牌。";
        _label.numberOfLines = 0;
        [_label sizeToFit];
        _label.height = _label.height;
        
    }
    return  _label;
    
}

- (NSString *)title{
    return @"关于";
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
