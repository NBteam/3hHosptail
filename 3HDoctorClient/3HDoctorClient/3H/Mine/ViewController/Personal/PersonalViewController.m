//
//  PersonalViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalHeadTableViewCell.h"
#import "PersonalTableViewCell.h"
#import "NameInputViewController.h"
#import "HospitalInputViewController.h"
#import "PositionViewController.h"
#import "HospitalTableViewController.h"
#import "DepartmentViewController.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNetWorkInfo];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"姓名",@"detail":@"未填写"},@{@"title":@"性别",@"detail":@"未填写"},@{@"title":@"医院",@"detail":@"未填写"},@{@"title":@"科室",@"detail":@"未填写"},@{@"title":@"职称",@"detail":@"未填写"},@{@"title":@"个人签名",@"detail":@"未填写"}]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"PersonalHeadTableViewCell";
        PersonalHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[PersonalHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[indexPath.row]];
        return cell;
    }else{
        static NSString *identifier = @"PersonalTableViewCell";
        PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[PersonalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        return 80;
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

- (NSString *)title{
    return @"个人资料";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section !=0) {
        WeakSelf(PersonalViewController);
        if (indexPath.row == 0) {//您的姓名
            
            NameInputViewController *nameInputVc = [[NameInputViewController alloc] init];
            
            [nameInputVc setNameBlock:^(NSString *str) {
                [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:str];
                [weakSelf.tableView reloadData];
            }];
            
            [self.navigationController  pushViewController:nameInputVc animated:YES];
            
        }else if (indexPath.row == 1){//
            
            HospitalInputViewController *cityListFirstLevelVc= [[HospitalInputViewController alloc] init];
            cityListFirstLevelVc.titleStr = @"请填写性别";
            [cityListFirstLevelVc setHospitalBlock:^(NSString *name) {
                [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:name];
                [weakSelf.tableView reloadData];
            }];
            
            [self.navigationController pushViewController:cityListFirstLevelVc animated:YES];
            
        }else if (indexPath.row == 2){//
            HospitalTableViewController*hospitalInputVc = [[HospitalTableViewController alloc] init];
            
            [hospitalInputVc setHospitalBlock:^(NSString *str) {
                [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:str];
                [weakSelf.tableView reloadData];
            }];
            
            [self.navigationController pushViewController:hospitalInputVc animated:YES];
            
        }else if (indexPath.row == 3){//
            DepartmentViewController * DepartmentVc = [[DepartmentViewController alloc]init];
            [DepartmentVc setChoiceBlock:^(NSString *id, NSString *name, NSString *pid) {
                [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:name];
                [weakSelf.tableView reloadData];
            }];
            [self.navigationController pushViewController:DepartmentVc animated:YES];
        }else if (indexPath.row == 4){//
            PositionViewController * pvc = [[PositionViewController alloc]init];
            [pvc setChoiceBlock:^(NSString *positionStr) {
                [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:positionStr];
                [weakSelf.tableView reloadData];
            }];
            [self.navigationController pushViewController:pvc animated:YES];
        }else if (indexPath.row == 5){//
            
        }
    }
}
- (void)getNetWorkInfo{
    [self showHudAuto:WaitPrompt];
    WeakSelf(PersonalViewController);
    [[THNetWorkManager shareNetWork]getUserInfoCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if ([response.dataDic[@"truename"] isEqualToString:@""]) {
                
            }
            [weakSelf.dataArray replaceObjectAtIndex:0 withObject:@{@"title":@"姓名",@"detail":response.dataDic[@"truename"]}];
            [weakSelf.tableView reloadData];
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
