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
//数据Model
#import "MyDiagnosisListModel.h"
@interface MainDiagnosticViewController ()

@end

@implementation MainDiagnosticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self getNetWork];
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
    MyDiagnosisListModel * model = self.dataArray[indexPath.row];
    [cell confingWithModel:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyDiagnosisListModel * model = self.dataArray[indexPath.row];
    MainDiagnosticDetailViewController *mainDiagnosticDetailVc = [[MainDiagnosticDetailViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    mainDiagnosticDetailVc.idx = model.idx;
    [self.navigationController pushViewController:mainDiagnosticDetailVc animated:YES];
}
- (void)getNetWork{
    [self.dataArray removeAllObjects];
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(MainDiagnosticViewController);
    [[THNetWorkManager shareNetWork]getMyDiagnosisListCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                MyDiagnosisListModel * model = [response thParseDataFromDic:dict andModel:[MyDiagnosisListModel class]];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
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
