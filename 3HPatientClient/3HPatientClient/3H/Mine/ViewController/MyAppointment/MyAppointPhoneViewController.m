//
//  MyAppointPhoneViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/14.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MyAppointPhoneViewController.h"
#import "MyAppointmentTableViewCell.h"
@interface MyAppointPhoneViewController ()

@end

@implementation MyAppointPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.height = self.tableView.height - 44;
    self.isOpenHeaderRefresh = YES;
    self.isOpenFooterRefresh = YES;
    [self getNetWork];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyAppointmentTableViewCell";
    MyAppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyAppointmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = self.view.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyAppointmentRegisteredModel *model = self.dataArray[indexPath.row];
    [cell confingWithModel:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(MyAppointPhoneViewController);
    [[THNetWorkManager shareNetWork]getMyOrderTelListPage:self.pageNO andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in response.dataDic[@"list"]) {
                MyAppointmentRegisteredModel * model = [response thParseDataFromDic:dic andModel:[MyAppointmentRegisteredModel class]];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
            //  结束头部刷新
            [weakSelf.tableView.header endRefreshing];
            //  结束尾部刷新
            [weakSelf.tableView.footer endRefreshing];
        }else{
            //  结束头部刷新
            [weakSelf.tableView.header endRefreshing];
            //  结束尾部刷新
            [weakSelf.tableView.footer endRefreshing];
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    [self getNetWork];
}
- (void)footerRequestWithData
{
    [self getNetWork];
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
