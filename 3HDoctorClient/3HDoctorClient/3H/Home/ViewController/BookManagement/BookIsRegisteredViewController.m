//
//  BookIsRegisteredViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BookIsRegisteredViewController.h"
#import "BookManagementTableViewCell.h"
#import "RegisteredDetailViewController.h"
#import "ReservationListModel.h"

@interface BookIsRegisteredViewController ()

@end

@implementation BookIsRegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getNetWork];
    self.tableView.height = self.tableView.height -44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    BookManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BookManagementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ReservationListModel * model = self.dataArray[indexPath.section];
    [cell confingWithModel:nil];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
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
//    ReservationListModel * model = self.dataArray[indexPath.section];
    RegisteredDetailViewController *registeredDetailVc = [[RegisteredDetailViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
//    registeredDetailVc.id = model.id;
    registeredDetailVc.id = @"1";
    [self.navigationController pushViewController:registeredDetailVc animated:YES];
}
- (void)getNetWork{
    WeakSelf(BookIsRegisteredViewController);
    [weakSelf showHudWaitingView:WaitPrompt];
    [[THNetWorkManager shareNetWork]getMyOrderguahaoListPage:self.pageNO andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                ReservationListModel * model = [response thParseDataFromDic:dict andModel:[ReservationListModel class]];
                [weakSelf.dataArray addObject:model];
            }
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"1"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudWaitingView:InternetFailerPrompt];
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
