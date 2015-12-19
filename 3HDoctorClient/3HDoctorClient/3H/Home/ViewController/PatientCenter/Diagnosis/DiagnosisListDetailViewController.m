//
//  DiagnosisListDetailViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "DiagnosisListDetailViewController.h"
#import "DiagnosisViewController.h"

@interface DiagnosisListDetailViewController ()
//保存
@property (nonatomic, strong) UIButton *btnSave;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, copy) NSString *sick_id;
@end

@implementation DiagnosisListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.labTitle];
    [self.view addSubview:self.labDetail];
    [self.view addSubview:self.btnSave];
    self.btnSave.hidden = YES;
    [self getSickInfoData];
 
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (UIButton *)btnSave{
    if (!_btnSave) {
        _btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSave.frame = CGRectMake(12, DeviceSize.height - self.frameTopHeight -60, DeviceSize.width - 24, 45);
        [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSave.titleLabel.font = [UIFont systemFontOfSize:17];
        [_btnSave setTitle:@"保存" forState:UIControlStateNormal];
        _btnSave.layer.masksToBounds = YES;
        _btnSave.layer.cornerRadius = 5;
        _btnSave.backgroundColor = [UIColor colorWithHEX:0x008aff];
        
        [_btnSave addTarget:self action:@selector(btnSaveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSave;
}

- (void)btnSaveAction{
    [self editPatientDiagnosisData];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width -20, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom +10, DeviceSize.width -20, 15)];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        _labDetail.font = [UIFont systemFontOfSize:13];

        _labDetail.numberOfLines = 0;
    }
    return _labDetail;
}

- (void)getSickInfoData{
    [self showHudAuto:WaitPrompt];
    WeakSelf(DiagnosisListDetailViewController);
    [[THNetWorkManager shareNetWork] getSickInfoId:self.ids CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            weakSelf.labTitle.text = response.dataDic[@"name"];
            weakSelf.labDetail.text = response.dataDic[@"desc"];
            [weakSelf.labDetail sizeToFit];
            weakSelf.sick_id = response.dataDic[@"id"];
            self.btnSave.hidden = NO;
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
    
}

- (NSString *)title{
    return @"诊断";
}

- (void)editPatientDiagnosisData{

    [self showHudAuto:@"保存中..."];
    WeakSelf(DiagnosisListDetailViewController);
    
    [[THNetWorkManager shareNetWork] editPatientDiagnosismid:self.mid idx:self.idx sick_id:self.sick_id diag_name:self.labTitle.text desc:self.labDetail.text CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            
            if (weakSelf.reloadBlock) {
                weakSelf.reloadBlock();
                
              [weakSelf.navigationController popToViewController:weakSelf.navigationController.viewControllers[3] animated:YES];
                
            }
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
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
