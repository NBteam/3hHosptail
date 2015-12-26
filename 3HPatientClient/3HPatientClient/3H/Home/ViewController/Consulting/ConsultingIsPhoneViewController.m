//
//  ConsultingIsPhoneViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingIsPhoneViewController.h"
#import "ConsultingIsPhoneTitleTableViewCell.h"
#import "ConsultingIsPhoneTimeTableViewCell.h"
#import "ConsultingIsPhoneDescTableViewCell.h"
#import "AppointTimeModel.h"
#import "ConsultingFinishViewController.h"

@interface ConsultingIsPhoneViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, assign) CGFloat priceStr;
@property (nonatomic, strong) ConsultingIsPhoneTitleTableViewCell *headView;
@property (nonatomic, strong) NSDictionary * dicInfo;
@property (nonatomic, strong) NSIndexPath * indexPaths;
@end

@implementation ConsultingIsPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.tableHeaderView = self.headView;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"保存"];
    [self.view addSubview:self.tableView];
    [self getNetWork];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (TPKeyboardAvoidingTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height -self.frameTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}
- (ConsultingIsPhoneTitleTableViewCell *)headView{
    if (!_headView) {
        _headView = [[ConsultingIsPhoneTitleTableViewCell alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 55)];
    }
    return _headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        static NSString *identifier = @"ConsultingIsPhoneTimeTableViewCell";
        ConsultingIsPhoneTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ConsultingIsPhoneTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        WeakSelf(ConsultingIsPhoneViewController);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBtnBlock:^(NSDictionary * dict) {
            weakSelf.dicInfo = [NSDictionary dictionaryWithDictionary:dict];
            weakSelf.priceStr = [dict[@"price"] doubleValue];
            [weakSelf.headView confingWithModel:weakSelf.priceStr];
        }];
        [cell setIsEmptyBlock:^{
            [weakSelf showHudAuto:@"此时间不能预约" andDuration:@"2"];
        }];
        [cell confingWithModel:self.dataArray];
        return cell;
    }else{
        static NSString *identifier = @"ConsultingIsPhoneDescTableViewCell";
        ConsultingIsPhoneDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ConsultingIsPhoneDescTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.indexPaths = indexPath;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return 180 +35 +50;
    }else{
        return 200;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (NSString *)title{
    return @"电话咨询";
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ConsultingIsPhoneViewController);
    [[THNetWorkManager shareNetWork]getDoctorTelTimeitemsDoctor_id:self.id date:@"" andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                AppointTimeModel * model = [response thParseDataFromDic:dict andModel:[AppointTimeModel class]];
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
- (void)rightAction{

    ConsultingIsPhoneDescTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPaths];
    if (!self.dicInfo) {
        [self showHudAuto:@"请选择预约时间" andDuration:@"2"];
    }else if([cell.textView.text isEqualToString:@""]){
        [self showHudAuto:@"请填写详细内容" andDuration:@"2"];
    }else{
        [self getConsultingNetWorkText:cell.textView.text];
    }
}
- (void)getConsultingNetWorkText:(NSString *)text{
    NSLog(@"%@",self.dicInfo);
    
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ConsultingIsPhoneViewController);
    [[THNetWorkManager shareNetWork]getAddOrderTelOrder_tel_id:self.dicInfo[@"id"] desc:text andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            [weakSelf getOrderTelAccountPayOrder_sn:response.dataDic[@"order_sn"]];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (void)getOrderTelAccountPayOrder_sn:(NSString *)text{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ConsultingIsPhoneViewController);
    [[THNetWorkManager shareNetWork]getOrderTelAccountPayOrder_sn:text andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            ConsultingFinishViewController * cvc = [[ConsultingFinishViewController alloc]initWithTableViewStyle:UITableViewStyleGrouped];
            [weakSelf.navigationController pushViewController:cvc animated:YES];
        }else{
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
