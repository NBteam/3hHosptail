//
//  AppointViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointViewController.h"
#import "AppointTableViewCell.h"
//预约挂号
#import "AppointDoctorsListViewController.h"
//预约住院
#import "AppointHosptailViewController.h"
//预约专家
#import "AppointExpertViewController.h"
@interface AppointViewController ()

@end

@implementation AppointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"img":@"首页-我要预约_预约挂号",@"title":@"预约挂号"},@{@"img":@"首页-我要预约_预约住院",@"title":@"预约住院"},@{@"img":@"首页-我要预约_预约专家电话咨询",@"title":@"预约专家电话咨询"}]];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    AppointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AppointTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        AppointDoctorsListViewController *appointDoctorsListVc = [[AppointDoctorsListViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:appointDoctorsListVc animated:YES];
    }else if (indexPath.section == 1){
        AppointHosptailViewController *appointHosptailVc = [[AppointHosptailViewController alloc] init];
        [self.navigationController pushViewController:appointHosptailVc animated:YES];
    }else{
        AppointExpertViewController *appointExpertVc = [[AppointExpertViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:appointExpertVc animated:YES];
    }
}

- (NSString *)title{
    return @"我要预约";
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
