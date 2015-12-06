//
//  PatientAddRequestViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "PatientAddRequestViewController.h"
#import "PatientAddRequestTableViewCell.h"
#import "PatientAddRequestModel.h"

@interface PatientAddRequestViewController ()
@property (nonatomic, assign) NSInteger number;
@end

@implementation PatientAddRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.number = 0;
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.isOpenHeaderRefresh = YES;
    self.isOpenFooterRefresh = YES;
    [self getNetWork];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    PatientAddRequestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PatientAddRequestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WeakSelf(PatientAddRequestViewController);
    [cell setBtnAgreedBlock:^{
//        PatientAddRequestModel * model = self.dataArray[indexPath.row];
        [weakSelf getMyPatientReqProcessNetWorkprocess:1 Req_id:@"1"];
    }];
    [cell setBtnRefusedBlock:^{
//        PatientAddRequestModel * model = self.dataArray[indexPath.row];
        [weakSelf getMyPatientReqProcessNetWorkprocess:-1 Req_id:@"1"];
    }];
//    PatientAddRequestModel * model = self.dataArray[indexPath.row];
    [cell confingWithModel:nil];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (NSString *)title{
    return @"患者添加请求";
}
- (void)getNetWork{
    [self showHudAuto:WaitPrompt];
    WeakSelf(PatientAddRequestViewController);
    [[THNetWorkManager shareNetWork]getmyPatientReqsPage:self.number andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (weakSelf.number == 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                PatientAddRequestModel * model = [response thParseDataFromDic:dict andModel:[PatientAddRequestModel class]];
                [weakSelf.dataArray addObject:model];
            }
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"1"];
        }
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        //  重新加载数据
        [weakSelf.tableView reloadData];
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"1"];
    }];
}
#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    self.number = 0;
    
    [self getNetWork];
}
- (void)footerRequestWithData
{
    self.number += 5;
    [self getNetWork];
}
- (void)getMyPatientReqProcessNetWorkprocess:(NSInteger)process Req_id:(NSString *)Req_id{
    [self showHudAuto:WaitPrompt];
    WeakSelf(PatientAddRequestViewController);
    [[THNetWorkManager shareNetWork]getMyPatientReqProcessReq_id:Req_id process:process andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"1"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"1"];
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
