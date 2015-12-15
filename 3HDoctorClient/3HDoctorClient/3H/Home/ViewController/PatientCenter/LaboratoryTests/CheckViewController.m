//
//  CheckViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "CheckViewController.h"
#import "PatientCenterNotCustomView.h"
#import "LaboratoryTestsTableViewCell.h"
#import "LaboratoryTestsAddViewController.h"
@interface CheckViewController ()

@property (nonatomic, strong) PatientCenterNotCustomView *customView;
@property (nonatomic, assign) NSInteger number;
@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.number = 0;
    self.tableView.height = self.tableView.height - 44;
    // Do any additional setup after loading the view.
    self.isOpenHeaderRefresh = YES;
    self.isOpenFooterRefresh = YES;
     [self.view addSubview:self.customView];
    [self getNetWork];
}
#pragma mark - UI

- (PatientCenterNotCustomView *)customView{
    WeakSelf(CheckViewController);
    if (!_customView) {
        _customView = [[PatientCenterNotCustomView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height -self.frameTopHeight) LabText:@"您还没有添加任何检查,请添加!" BtnText:@"添加检查"];
        _customView.backgroundColor = self.view.backgroundColor;
        [_customView setBtnBlock:^{
            LaboratoryTestsAddViewController *laboratoryTestsAddVc= [[LaboratoryTestsAddViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            laboratoryTestsAddVc.index = 2;
            [weakSelf.navigationController pushViewController:laboratoryTestsAddVc animated:YES];
        }];
    }
    return _customView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    LaboratoryTestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LaboratoryTestsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:nil];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArray.count==0) {
        self.customView.hidden = NO;
    }else{
        self.customView.hidden = YES;
    }
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(CheckViewController);
    [[THNetWorkManager shareNetWork]getPatientCheckListPage:5 mid:@"" andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (weakSelf.number == 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                PatientAssayListModel * model = [response thParseDataFromDic:dict andModel:[PatientAssayListModel class]];
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
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
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
