//
//  ConsultingIsPhoneViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingIsPhoneViewController.h"

@interface ConsultingIsPhoneViewController ()

@end

@implementation ConsultingIsPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)title{
    return @"电话咨询";
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
