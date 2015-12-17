//
//  LaboratoryViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "LaboratoryViewController.h"
#import "PatientCenterNotCustomView.h"
#import "LaboratoryTestsTableViewCell.h"
#import "LaboratoryTestsAddViewController.h"
#import "PatientAssayListModel.h"
#import "CheckDataDetailViewController.h"


@interface LaboratoryViewController ()
@property (nonatomic, strong) PatientCenterNotCustomView *customView;

@end

@implementation LaboratoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.height = self.tableView.height - 44;
    // Do any additional setup after loading the view.
    self.isOpenFooterRefresh = YES;
    self.isOpenHeaderRefresh = YES;
    [self getNetWork];
    [self.view addSubview:self.customView];
    self.customView.hidden = YES;

}
#pragma mark - UI

- (PatientCenterNotCustomView *)customView{
    WeakSelf(LaboratoryViewController);
    if (!_customView) {
        _customView = [[PatientCenterNotCustomView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height -self.frameTopHeight) LabText:@"您还没有添加任何化验,请添加!" BtnText:@"添加化验"];
        _customView.backgroundColor = self.view.backgroundColor;
        [_customView setBtnBlock:^{
            LaboratoryTestsAddViewController *laboratoryTestsAddVc= [[LaboratoryTestsAddViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            laboratoryTestsAddVc.index = 1;
            laboratoryTestsAddVc.mid = weakSelf.mid;
            [laboratoryTestsAddVc setReloadBlock:^{
                
                [weakSelf getNetWork];
            }];
            [weakSelf.navigationController pushViewController:laboratoryTestsAddVc animated:YES];
        }];
    }
    return _customView;
}

- (void)addPushVc{
    WeakSelf(LaboratoryViewController);
    LaboratoryTestsAddViewController *laboratoryTestsAddVc= [[LaboratoryTestsAddViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    laboratoryTestsAddVc.index = 1;
    laboratoryTestsAddVc.mid = self.mid;
    [laboratoryTestsAddVc setReloadBlock:^{

        [weakSelf getNetWork];
    }];
    [self.navigationController pushViewController:laboratoryTestsAddVc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    LaboratoryTestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LaboratoryTestsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PatientAssayListModel * model = self.dataArray[indexPath.section];
    [cell confingWithModel:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(LaboratoryViewController);
    [[THNetWorkManager shareNetWork]getPatientAssayListPage:self.pageNO mid:self.mid andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (weakSelf.pageNO == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (response.responseCode == 1) {
            NSLog(@"啥%@",response.dataDic);
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                PatientAssayListModel * model = [response thParseDataFromDic:dict andModel:[PatientAssayListModel class]];
                [weakSelf.dataArray addObject:model];
            }
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        //  重新加载数据
        
        if (weakSelf.dataArray.count == 0) {
            weakSelf.customView.hidden = NO;
        }
        [weakSelf.tableView reloadData];
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PatientAssayListModel *model = self.dataArray[indexPath.section];
    CheckDataDetailViewController *checkDataDetailVc = [[CheckDataDetailViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    checkDataDetailVc.index = 0;
    checkDataDetailVc.titles = model.name;
    checkDataDetailVc.ids = model.id;
    [self.navigationController pushViewController:checkDataDetailVc animated:YES];
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
