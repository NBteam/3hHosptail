//
//  DiagnosisDetailViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "DiagnosisDetailViewController.h"
#import "DiagnosisDetailHeadTableViewCell.h"
#import "DiagnosisDetailTableViewCell.h"

@interface DiagnosisDetailViewController ()
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) NSMutableDictionary * dictInfo;
//诊断名称
@property (nonatomic, copy) NSString *diag_name	;	//诊断名称
@property (nonatomic, copy) NSString *desc	;		//诊断描述
@end

@implementation DiagnosisDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"删除"];
    self.dictInfo = [NSMutableDictionary dictionary];
//    // [self.view addSubview:self.customView];
//    
//    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"是否有过敏史:",@"detail":@"未选择"},@{@"title":@"血型:",@"detail":@"未选择"}]];
//    [self getPatientSickHistory];
    [self getDianosisDetailData];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction{
    UIAlertView * uploadView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"您确定要删除?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
    [uploadView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }else{
        
        [self delPatientDiagnosis];

    }
}


- (void)delPatientDiagnosis{
    [self showHudAuto:WaitPrompt];
    WeakSelf(DiagnosisDetailViewController);

    [[THNetWorkManager shareNetWork] delPatientDiagnosismid:self.mid idx:self.idx andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        if (response.responseCode == 1) {
            if (weakSelf.reloadBlock) {
                self.reloadBlock();
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
}
#pragma mark - UI


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        static NSString *identifier = @"DiagnosisDetailTableViewCell";
        DiagnosisDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[DiagnosisDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellHeight = [cell confingWithModel:self.desc];
        return cell;
    }else{
        static NSString *identifier = @"idertifier";
        DiagnosisDetailHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[DiagnosisDetailHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.diag_name];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return self.cellHeight;
    }else{
        return 45;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (NSString *)title{
    return @"诊断详情";
}
- (void)getDianosisDetailData{
    WeakSelf(DiagnosisDetailViewController);
    [weakSelf showHudWaitingView:WaitPrompt];
    
    [[THNetWorkManager shareNetWork] getPatientDiagnosismid:self.mid idx:self.idx CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        NSLog(@"查看sss%@",response.dataDic);
        if (response.responseCode == 1) {
            weakSelf.dictInfo = [NSMutableDictionary dictionaryWithDictionary:response.dataDic];
            weakSelf.diag_name = response.dataDic[@"diag_name"];
            weakSelf.desc = response.dataDic[@"desc"];

            [weakSelf.tableView reloadData];
        } else {
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
