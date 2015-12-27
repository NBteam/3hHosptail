//
//  MedicationViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "MedicationViewController.h"
#import "PatientCenterNotCustomView.h"
#import "MedicationTableViewCell.h"
//添加用药
#import "MedicationAddViewController.h"
#import "MedicationModel.h"

@interface MedicationViewController ()
@property (nonatomic, strong) PatientCenterNotCustomView *customView;

@end

@implementation MedicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
     self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(addAction) andTarget:self andImageName:@"首页-患者中心_添加"];
    self.isOpenFooterRefresh = YES;
    self.isOpenHeaderRefresh = YES;
    [self getNetWork];
    [self.view addSubview:self.customView];
    self.customView.hidden = YES;
    NSLog(@"真的爱你%@",self.mid );
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addAction{
    WeakSelf(MedicationViewController);
    MedicationAddViewController *medicationAddVc = [[MedicationAddViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    medicationAddVc.mid = self.mid;
    [medicationAddVc setReloadBlock:^{
        [weakSelf getNetWork];
    }];
    [self.navigationController pushViewController:medicationAddVc animated:YES];
}

#pragma mark - UI

- (PatientCenterNotCustomView *)customView{
    WeakSelf(MedicationViewController);
    if (!_customView) {
        _customView = [[PatientCenterNotCustomView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height -self.frameTopHeight) LabText:@"您还没有添加任何用药提醒,请添加!" BtnText:@"添加药物"];
        _customView.backgroundColor = self.view.backgroundColor;
        [_customView setBtnBlock:^{
            MedicationAddViewController *medicationAddVc = [[MedicationAddViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            medicationAddVc.mid = weakSelf.mid;
            [medicationAddVc setReloadBlock:^{
                [weakSelf getNetWork];
            }];
            [weakSelf.navigationController pushViewController:medicationAddVc animated:YES];
        }];
    }
    return _customView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    MedicationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MedicationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:self.dataArray[indexPath.section]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
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
    return @"用药提醒";
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(MedicationViewController);
    [[THNetWorkManager shareNetWork]getPatientDrugListPage:self.pageNO mid:self.mid andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (weakSelf.pageNO == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                MedicationModel * model = [response thParseDataFromDic:dict andModel:[MedicationModel class]];
                [weakSelf.dataArray addObject:model];
            }
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"1"];
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
#pragma mark 提交编辑操作时会调用这个方法(删除，添加)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 1.删除数据
        [self deleteCellIndexPath:indexPath];
    }
}
- (void)deleteCellIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(MedicationViewController);
    [weakSelf showHudWaitingView:WaitPrompt];
    MedicationModel * model = self.dataArray[indexPath.section];
    [[THNetWorkManager shareNetWork]delPatientDrugId:model.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            
            [weakSelf.dataArray removeObjectAtIndex:indexPath.section];
            [weakSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            [weakSelf.tableView reloadData];
            
        } else {
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
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
