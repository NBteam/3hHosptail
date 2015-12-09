//
//  PatientCenterViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "PatientCenterViewController.h"
#import "PatientCenterTableViewCell.h"
#import "PatientAddRequestViewController.h"
//患者详情
#import "PatientDetailViewController.h"
#import "PatientListModel.h"
#import "SearchViewController.h"
#import "AddPatientsViewController.h"
@interface PatientCenterViewController ()
@property (nonatomic, assign) NSInteger number;
//患者添加请求
@property (nonatomic, strong) UIButton *btnPatientAddNum;
@end

@implementation PatientCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.number = 0;
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItemExtension rightButtonItem:@selector(addAction) andTarget:self andImageName:@"首页-患者中心_添加"],[UIBarButtonItemExtension rightButtonItem:@selector(searchAction) andTarget:self andImageName:@"首页-患者中心_搜索"]];
    [self.view addSubview:self.btnPatientAddNum];
    self.tableView.top = self.btnPatientAddNum.bottom;
    self.tableView.height = self.tableView.height - self.btnPatientAddNum.height;
    self.isOpenHeaderRefresh = YES;
    self.isOpenFooterRefresh = YES;
    [self getNetWorkInfo];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchAction{
    SearchViewController * SearchVc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:SearchVc animated:YES];
}

- (void)addAction{
    AddPatientsViewController * addVc = [[AddPatientsViewController alloc]init];
    [self.navigationController pushViewController:addVc animated:YES];
}

- (UIButton *)btnPatientAddNum{
    if (!_btnPatientAddNum) {
        _btnPatientAddNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPatientAddNum.frame = CGRectMake(0, 0, DeviceSize.width, 44);
        [_btnPatientAddNum setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        _btnPatientAddNum.titleLabel.font = [UIFont systemFontOfSize:15];
        _btnPatientAddNum.backgroundColor = [UIColor colorWithHEX:0xff813c];
        [_btnPatientAddNum setTitle:@"患者添加请求(1)" forState:UIControlStateNormal];
        [_btnPatientAddNum addTarget:self action:@selector(btnPatientAddNumAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPatientAddNum;
}

- (void)btnPatientAddNumAction{
    PatientAddRequestViewController *patientAddRequestVc= [[PatientAddRequestViewController alloc] init];
    [self.navigationController pushViewController:patientAddRequestVc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    PatientCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PatientCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    PatientListModel * model = self.dataArray[indexPath.row];
    [cell confingWithModel:nil];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PatientDetailViewController *patientDetailVc= [[PatientDetailViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:patientDetailVc animated:YES];
    
}
- (void)getNetWorkInfo{
    WeakSelf(PatientCenterViewController);
    [weakSelf showHudWaitingView:WaitPrompt];
    [[THNetWorkManager shareNetWork]getMyPatientsPage:self.number andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (weakSelf.number == 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                PatientListModel * model = [response thParseDataFromDic:dict andModel:[PatientListModel class]];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
        } else {
            [weakSelf showHudAuto:response.message];
        }
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        //  重新加载数据
        [weakSelf.tableView reloadData];
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt];
    }];
}
#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    self.number = 0;
    [self getNetWorkInfo];
}
- (void)footerRequestWithData
{
    self.number += 5;
    [self getNetWorkInfo];
}
- (NSString *)title{
    return @"患者中心";
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
