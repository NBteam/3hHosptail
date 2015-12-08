//
//  PatientDetailViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "PatientDetailViewController.h"
#import "PatientDetailHeadTableViewCell.h"
#import "PatientDetailTableViewCell.h"
//复查提醒
#import "ReviewViewController.h"
//用药提醒
#import "MedicationViewController.h"
//化验及检查
#import "LaboratoryTestsViewController.h"
//病史
#import "DiagnosisViewController.h"
//诊断
#import "DiagnosisListViewController.h"
@interface PatientDetailViewController ()

@end

@implementation PatientDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"img":@"首页-患者中心-患者详情_诊断-未点击",@"title":@"诊断"},@{@"img":@"首页-患者中心-患者详情_病史-未点击",@"title":@"病史"},@{@"img":@"首页-患者中心-患者详情_化验及检查-未点击",@"title":@"化验及检查"},@{@"img":@"首页-患者中心-患者详情_用药提醒-未点击",@"title":@"用药提醒"},@{@"img":@"首页-患者中心-患者详情_复查提醒-未点击",@"title":@"复查提醒"}]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"idertifier";
        PatientDetailHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[PatientDetailHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[indexPath.row]];
        return cell;
    }else{
        static NSString *identifier = @"idertifier";
        PatientDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[PatientDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[indexPath.row]];
        return cell;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 110;
    }else{
        return 45;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {//诊断
            DiagnosisListViewController * DiagnosisListVc = [[DiagnosisListViewController alloc]init];
            [self.navigationController pushViewController:DiagnosisListVc animated:YES];
            
        }else if(indexPath.row == 1){//病史
            DiagnosisViewController *diagnosisVc = [[DiagnosisViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:diagnosisVc animated:YES];
            
        }else if(indexPath.row == 2){//化验
            
            LaboratoryTestsViewController *laboratoryTestsVc = [[LaboratoryTestsViewController alloc] init];
            [self.navigationController pushViewController:laboratoryTestsVc animated:YES];
            
        }else if(indexPath.row == 3){//用药
            
            MedicationViewController *medicationVc= [[MedicationViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:medicationVc animated:YES];
        }else{//复查
            ReviewViewController *reviewVc = [[ReviewViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:reviewVc animated:YES];
        }
    }
}
- (NSString *)title{
    return @"患者详情";
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
