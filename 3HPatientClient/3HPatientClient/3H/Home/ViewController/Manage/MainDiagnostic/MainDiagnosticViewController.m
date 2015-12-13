//
//  MainDiagnosticViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MainDiagnosticViewController.h"
#import "MainDiagnosticTableViewCell.h"
//详情
#import "MainDiagnosticDetailViewController.h"
@interface MainDiagnosticViewController ()

@end

@implementation MainDiagnosticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UI

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MainDiagnosticTableViewCell";
    MainDiagnosticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MainDiagnosticTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:1];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MainDiagnosticDetailViewController *mainDiagnosticDetailVc = [[MainDiagnosticDetailViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:mainDiagnosticDetailVc animated:YES];
}

- (NSString *)title{
    return @"主要诊断";
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
