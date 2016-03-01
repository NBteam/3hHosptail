//
//  MessageViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCells.h"
#import "MessageModels.h"
#import "MessageHomeModel.h"
//用药指南
#import "MedicationGuideViewController.h"
//复查指南
#import "ReviewGuideViewController.h"
//咨询信息
#import "ConsultingDoctorListViewController.h"
//预约提醒
#import "MyAppointmentViewController.h"
#import "AllOrderViewController.h"
@interface MessageViewController ()

@property (nonatomic, strong) NSMutableDictionary *dataDict;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataDict = [[NSMutableDictionary alloc] init];
    [self sgetMsgHome];
    self.isOpenHeaderRefresh = YES;
    
}

#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    
    [self sgetMsgHome];
}

-(void)readAllMessageType:(NSString *)type{
    [self.dataArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(MessageViewController);
    [[THNetWorkManager shareNetWork] readAllMsgtype:type andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
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
        [weakSelf.tableView.header endRefreshing];
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
        [weakSelf.tableView.header endRefreshing];
    } ];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    MessageTableViewCells *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessageTableViewCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
//    //用药指南
//#import "MedicationGuideViewController.h"
//    //复查指南
//#import "ReviewGuideViewController.h"
//    //咨询信息
//#import "ConsultingDoctorListViewController.h"
//    //预约提醒
//#import "AppointViewController.h"
    NSArray *arr = @[@"preorder_msg",@"drug_msg",@"",@"recheck_msg",@"sys_msg"];
//    默认全部，preorder_msg预约提醒，drug_msg用药提醒，
//    recheck_msg复查提醒， order_msg订单提醒，sys_msg系统消息
    if (indexPath.section == 0) {//预约提醒
        MyAppointmentViewController *appointVc = [[MyAppointmentViewController alloc] init];
        appointVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:appointVc animated:YES];
    }else if(indexPath.section == 1){//用药提醒
        MedicationGuideViewController *appointVc = [[MedicationGuideViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        appointVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:appointVc animated:YES];
    }else if(indexPath.section == 2){//复查提醒
        ReviewGuideViewController *appointVc = [[ReviewGuideViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        appointVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:appointVc animated:YES];
        
    }else if(indexPath.section == 3){//订单提醒
        AllOrderViewController *appointVc = [[AllOrderViewController alloc] init];
        appointVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:appointVc animated:YES];
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
