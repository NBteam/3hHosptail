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

#import "MessageListViewController.h"
@interface MessageViewController ()

@property (nonatomic, strong) NSMutableDictionary *dataDict;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataDict = [[NSMutableDictionary alloc] init];
    
   
   // [self readAllMessage];
    
    self.isOpenHeaderRefresh = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self sgetMsgHome];
    [self loadData];
}
#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    
    [self sgetMsgHome];
}


-(void)readAllMessage:(NSString *)type{
    [self.dataArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(MessageViewController);
    [[THNetWorkManager shareNetWork] readAllMsg:type andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            
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
    NSArray *arr = @[@"guahao_msg",@"otel_msg",@"chat_msg",@"user_add_msg",@"sys_msg"];
    
    if (indexPath.section == 0) {
        BookManagementViewController *bookVc = [[BookManagementViewController alloc] init];
        bookVc.hidesBottomBarWhenPushed = YES;
        bookVc.isPhone = NO;
        [self.navigationController pushViewController:bookVc animated:YES];
    }else if(indexPath.section == 1){
        BookManagementViewController *bookVc = [[BookManagementViewController alloc] init];
        bookVc.hidesBottomBarWhenPushed = YES;
        bookVc.isPhone = YES;
        [self.navigationController pushViewController:bookVc animated:YES];
    }else if(indexPath.section == 2){
        ConsultingMainViewController *consultVc = [[ConsultingMainViewController alloc] init];
        consultVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:consultVc animated:YES];
    }else if(indexPath.section == 3){
        PatientAddRequestViewController *patientVc = [[PatientAddRequestViewController alloc] init];
        patientVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:patientVc animated:YES];
    }else{
        MessageListViewController *listVc = [[MessageListViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        
        listVc.typeString = @"sys_msg";
        
        listVc.imgString = @"3H-消息_系统消息";

        listVc.titleString = @"系统消息";


        listVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:listVc animated:YES];
    }
    
    //[self readAllMessage:arr[indexPath.section]];
}


- (void)loadData{
    WeakSelf(MessageViewController);
    [[THNetWorkManager shareNetWork] getMsgNumandCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        NSLog(@"---%@",response.dataDic);
        if (response.responseCode == 1) {
            if([response.dataDic[@"msg_num"] integerValue] != 0){
                weakSelf.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@",response.dataDic[@"msg_num"]];
            }
            
        }else{
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        
    } ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
