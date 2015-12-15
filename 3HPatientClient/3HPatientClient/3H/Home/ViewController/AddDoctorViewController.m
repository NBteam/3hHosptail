//
//  AddDoctorViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/14.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddDoctorViewController.h"

@interface AddDoctorViewController ()

@end

@implementation AddDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(addAction) andTarget:self andImageName:@"首页-患者-添加按钮"];
    
    
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addAction{
    [self addDoctorData];
}

- (void)addDoctorData{

    [self showHudAuto:WaitPrompt];
    WeakSelf(AddDoctorViewController);
    
    [[THNetWorkManager shareNetWork] addDoctorIds:@"5" CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            //            for (NSDictionary * dict in response.dataDic[@"list"]) {
            //                InformationModel * model = [response thParseDataFromDic:dict andModel:[InformationModel class]];
            //                [weakSelf.dataArray addObject:model];
            //            }
            

            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
}

- (NSString *)title{
    return @"添加医生";
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
