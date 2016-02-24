//
//  MessageViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageModels.h"
#import "MessageHomeModel.h"
//患者中心
#import "PatientAddRequestViewController.h"
//咨询服务
//#import "ConsultingServicesViewController.h"
#import "ConsultingMainViewController.h"
//预约管理
#import "BookManagementViewController.h"
@interface MessageViewController ()

@property (nonatomic, strong) NSMutableDictionary *dataDict;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataDict = [[NSMutableDictionary alloc] init];
    
   
    [self readAllMessage];
    
    self.isOpenHeaderRefresh = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self sgetMsgHome];
}
#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    
    [self sgetMsgHome];
}


-(void)readAllMessage{
    [self.dataArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(MessageViewController);
    [[THNetWorkManager shareNetWork] readAllMsgandCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            
             weakSelf.navigationController.tabBarItem.badgeValue = nil;
        }else{
           // [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
       // [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
}

- (void)sgetMsgHome{
    [self.dataDict removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(MessageViewController);

    [[THNetWorkManager shareNetWork] sgetMsgHomeandCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            weakSelf.dataDict = [NSMutableDictionary dictionaryWithDictionary:response.dataDic];
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
    } ];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithDict:self.dataDict Index:indexPath.section];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataDict.count / 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        BookManagementViewController *bookVc = [[BookManagementViewController alloc] init];
        bookVc.hidesBottomBarWhenPushed = YES;
        bookVc.isPhone = indexPath.section;
        [self.navigationController pushViewController:bookVc animated:YES];
    }else if(indexPath.section == 2){
        ConsultingMainViewController *consultVc = [[ConsultingMainViewController alloc] init];
        consultVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:consultVc animated:YES];
    }else if(indexPath.section == 3){
        PatientAddRequestViewController *patientVc = [[PatientAddRequestViewController alloc] init];
        patientVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:patientVc animated:YES];
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
