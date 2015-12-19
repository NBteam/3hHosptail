//
//  ReviewViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ReviewViewController.h"
#import "PatientCenterNotCustomView.h"
#import "ReviewTableViewCell.h"
//复查添加
#import "ReviewAddViewController.h"
#import "PatientRecheckModel.h"

@interface ReviewViewController ()
@property (nonatomic, assign) NSInteger number;

@property (nonatomic, strong) PatientCenterNotCustomView *customView;
@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.number = 0;
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(addAction) andTarget:self andImageName:@"首页-患者中心_添加"];
    [self.view addSubview:self.customView];
    self.customView.hidden = YES;
    self.isOpenFooterRefresh = YES;
    self.isOpenHeaderRefresh = YES;
    [self getNetWork];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addAction{
    WeakSelf(ReviewViewController);
    ReviewAddViewController *reviewAddVc = [[ReviewAddViewController alloc] init];
    reviewAddVc.mid = self.mid;
    [reviewAddVc setReloadBlock:^{
        [weakSelf getNetWork];
    }];
    [self.navigationController pushViewController:reviewAddVc animated:YES];
}

#pragma mark - UI

- (PatientCenterNotCustomView *)customView{
    WeakSelf(ReviewViewController);
    if (!_customView) {
        _customView = [[PatientCenterNotCustomView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height -self.frameTopHeight) LabText:@"您还没有添加任何复查提醒,请添加!" BtnText:@"添加复查"];
        _customView.backgroundColor = self.view.backgroundColor;
        [_customView setBtnBlock:^{
            ReviewAddViewController *reviewAddVc = [[ReviewAddViewController alloc] init];
            reviewAddVc.mid = weakSelf.mid;
            [reviewAddVc setReloadBlock:^{
                [weakSelf getNetWork];
            }];
            [weakSelf.navigationController pushViewController:reviewAddVc animated:YES];
        }];
    }
    return _customView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ReviewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PatientRecheckModel * model = self.dataArray[indexPath.section];
    [cell confingWithModel:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArray.count;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (NSString *)title{
    return @"复查提醒";
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ReviewViewController);
    [[THNetWorkManager shareNetWork]getPatientRecheckListPage:self.pageNO mid:self.mid andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (weakSelf.pageNO == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        NSLog(@"查看%@",response.dataDic);
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                PatientRecheckModel * model = [response thParseDataFromDic:dict andModel:[PatientRecheckModel class]];
                [weakSelf.dataArray addObject:model];
            }
            
            //  重新加载数据
            if (weakSelf.dataArray.count == 0) {
                weakSelf.customView.hidden = NO;
            }
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
            //  重新加载数据
            
        }
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        
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
