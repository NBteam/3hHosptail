//
//  ManageViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ManageViewController.h"
#import "ManageTableViewCell.h"
//简要病例
#import "BriefCaseViewController.h"
//主要诊断
#import "MainDiagnosticViewController.h"
//检查极其
#import "CheckDataViewController.h"
//用药指南
#import "MedicationGuideViewController.h"
//复查
#import "ReviewGuideViewController.h"
@interface ManageViewController ()

@end

@implementation ManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"img":@"首页-健康管理_简要病史",@"title":@"简要病史"},@{@"img":@"首页-健康管理_主要诊断",@"title":@"主要诊断"},@{@"img":@"首页-健康管理_检查及检查数据",@"title":@"检查及检查数据"},@{@"img":@"首页-健康管理_用药指南",@"title":@"用药指南"},@{@"img":@"首页-健康管理_复查指南",@"title":@"复查指南"}]];

}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    ManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ManageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        
        BriefCaseViewController *briefCaseVc = [[BriefCaseViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:briefCaseVc animated:YES];
        
    }else if (indexPath.section == 1){
        
        MainDiagnosticViewController *mainDiagnosticVc = [[MainDiagnosticViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:mainDiagnosticVc animated:YES];
        
    }else if (indexPath.section == 2){
        
        CheckDataViewController *checkDataVc = [[CheckDataViewController alloc] init];
        [self.navigationController pushViewController:checkDataVc animated:YES];
        
    }else if (indexPath.section == 3){
        
        MedicationGuideViewController *medicationGuideVc = [[MedicationGuideViewController alloc] init];
        [self.navigationController pushViewController:medicationGuideVc animated:YES];
        
    }else{
        
        ReviewGuideViewController *reviewGuideVc = [[ReviewGuideViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:reviewGuideVc animated:YES];
    }
}
- (NSString *)title{
    return @"健康管理";
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
