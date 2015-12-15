//
//  HomeViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeadView.h"
#import "HomeTableViewCell.h"

//患者中心
#import "PatientCenterViewController.h"
//咨询服务
#import "ConsultingServicesViewController.h"
//预约管理
#import "BookManagementViewController.h"
//助理医生
#import "AssistantDoctorViewController.h"
//咨询动态
#import "ConsultingDynamicViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) HomeHeadView *headView;

@property (nonatomic, strong) UIView *changeView;
@end

@implementation HomeViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadHomeInfo" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHEX:0xffffff];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view insertSubview:self.changeView belowSubview:self.tableView];
    self.tableView.separatorColor = [UIColor colorWithHEX:0xffffff];
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"img":@"3H-首页_患者中心",@"title":@"患者中心"},@{@"img":@"3H-首页_咨询服务",@"title":@"咨询服务"},@{@"img":@"3H-首页_预约管理",@"title":@"预约管理"},@{@"img":@"3H-首页_助理医生",@"title":@"助理医生"},@{@"img":@"3H-首页_咨询动态",@"title":@"咨询动态"}]];
    self.tableView.top = 0;
    self.tableView.height = DeviceSize.height -49;
//    self.tableView.tableHeaderView = self.headView;
    [self.headView confingWithModel:nil];
    [self.view addSubview:self.labTitle];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getHomeInfo) name:@"reloadHomeInfo" object:nil];
    [self getHomeInfo];
}

#pragma mark -UI

- (UIView *)changeView{
    if (!_changeView) {
        _changeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.width)];
        _changeView.backgroundColor = AppDefaultColor;
    }
    return _changeView;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 +20, DeviceSize.width, 18)];
        _labTitle.textColor = [UIColor colorWithHEX:0xffffff];
        _labTitle.font = [UIFont systemFontOfSize:18];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.text = @"3H健康管理";
        
    }
    return _labTitle;
}

- (HomeHeadView *)headView{
    if (!_headView) {
        _headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 230)];
        
    }
    return _headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:self.dataArray[indexPath.row]];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55 +12 +9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 230;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {//患者中心
        
        PatientCenterViewController *patientCenterVc = [[PatientCenterViewController alloc] init];
        patientCenterVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:patientCenterVc animated:YES];
        
    }else if (indexPath.row == 1){//咨询服务
        
        ConsultingServicesViewController *consultingServicesVc= [[ConsultingServicesViewController alloc] init];
        consultingServicesVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:consultingServicesVc animated:YES];
        
    }else if (indexPath.row == 2){//预约管理
        
        BookManagementViewController *bookManagementVc= [[BookManagementViewController alloc] init];
        bookManagementVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bookManagementVc animated:YES];
        
    }else if (indexPath.row == 3){//助理医生
        
        AssistantDoctorViewController *assistantDoctorVc= [[AssistantDoctorViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        assistantDoctorVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:assistantDoctorVc animated:YES];
        
    }else{//资讯动态
        
        ConsultingDynamicViewController *consultingDynamicVc= [[ConsultingDynamicViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        consultingDynamicVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:consultingDynamicVc animated:YES];
        
    }
}
#pragma mark -
#pragma mark net
- (void)getHomeInfo{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(HomeViewController);
    [[THNetWorkManager shareNetWork]getUserInfoCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            [weakSelf.headView confingWithModel:response.dataDic];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
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
