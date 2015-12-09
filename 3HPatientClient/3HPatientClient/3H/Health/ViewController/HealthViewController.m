//
//  HealthViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "HealthViewController.h"
#import "HealthTableViewCell.h"
//健康管理
#import "ManageViewController.h"
//我要预约
#import "AppointViewController.h"
//健康日程
#import "ScheduleViewController.h"
//我要咨询
#import "ConsultingViewController.h"
//我要咨询医生列表
#import "ConsultingDoctorListViewController.h"
@interface HealthViewController ()

@end

@implementation HealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"img":@"3H-健康_健康管理",@"title":@"健康管理"},@{@"img":@"3H-健康_健康日程",@"title":@"健康日程"},@{@"img":@"3H-健康_咨询专家",@"title":@"咨询专家"},@{@"img":@"3H-健康_预约",@"title":@"预约"}]];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    HealthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HealthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:self.dataArray[indexPath.section]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ManageViewController *manageVc = [[ManageViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        manageVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:manageVc animated:YES];
    }else if (indexPath.section == 1){
//        ConsultingViewController *consultingVc= [[ConsultingViewController alloc] init];
//        consultingVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:consultingVc animated:YES];
        ConsultingDoctorListViewController *consultingVc= [[ConsultingDoctorListViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        consultingVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:consultingVc animated:YES];
    }else if(indexPath.section == 2){
        ScheduleViewController *scheduleVc = [[ScheduleViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        scheduleVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:scheduleVc animated:YES];
    }else{
        AppointViewController *appointVc = [[AppointViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
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
