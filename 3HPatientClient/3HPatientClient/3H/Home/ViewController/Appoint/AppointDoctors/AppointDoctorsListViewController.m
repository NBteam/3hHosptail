//
//  AppointDoctorsListViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointDoctorsListViewController.h"
#import "AppointDoctorsViewController.h"
#import "AppointDoctorsListTableViewCell.h"
#import "ConsultingDoctorListNewCell.h"

@interface AppointDoctorsListViewController ()
@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation AppointDoctorsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.isOpenHeaderRefresh = YES;
    self.isOpenFooterRefresh = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getNetWork];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"AppointDoctorsListTableViewCell";
    ConsultingDoctorListNewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ConsultingDoctorListNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AppointExpertListModel * model = self.dataArray[indexPath.row];
    self.cellHeight = [cell confingWithAppointExpertListModel:model];
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointExpertListModel * model = self.dataArray[indexPath.row];
    AppointDoctorsViewController *appointDoctorsVc = [[AppointDoctorsViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    appointDoctorsVc.id = model.id;
    [self.navigationController pushViewController:appointDoctorsVc animated:YES];
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(AppointDoctorsListViewController);
    [[THNetWorkManager shareNetWork]getMyDoctorsPage:self.pageNO andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in response.dataDic[@"list"]) {
                AppointExpertListModel * model = [response thParseDataFromDic:dic andModel:[AppointExpertListModel class]];
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
- (NSString *)title{
    return @"专家团队";
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
