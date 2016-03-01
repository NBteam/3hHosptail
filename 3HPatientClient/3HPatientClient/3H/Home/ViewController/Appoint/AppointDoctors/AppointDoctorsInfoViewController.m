//
//  AppointDoctorsInfoViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/26.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointDoctorsInfoViewController.h"
#import "ConsultingIsPhoneTitleTableViewCell.h"
#import "ConsultingIsPhoneTimeTableViewCell.h"
#import "ConsultingIsPhoneDescTableViewCell.h"
#import "AppointTimeModel.h"
#import "ConsultingFinishViewController.h"
#import "OutpatientAppointTableViewCell.h"
#import "DoctorsInfoModel.h"

@interface AppointDoctorsInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, assign) CGFloat priceStr;
@property (nonatomic, strong) ConsultingIsPhoneTitleTableViewCell *headView;

@property (nonatomic, strong) NSIndexPath * indexPaths;
@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) NSString *  work_price;
@property (nonatomic, strong) NSMutableDictionary * dict1Info;
@property (nonatomic, copy) NSString * string;
@end

@implementation AppointDoctorsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArray = [NSMutableArray array];
    self.dict1Info = [NSMutableDictionary dictionary];
    self.infoArray = [NSArray array];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
//    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.tableView];
    [self getNetWork:0];
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
//- (ConsultingIsPhoneTitleTableViewCell *)headView{
//    if (!_headView) {
//        _headView = [[ConsultingIsPhoneTitleTableViewCell alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 55)];
//    }
//    return _headView;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        static NSString *identifier = @"ConsultingIsPhoneTimeTableViewCell";
        OutpatientAppointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[OutpatientAppointTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellHeight = [cell confingWithModelWeeks:self.infoArray Price:@"" clickArray:self.dataArray dict:self.dict1Info];
        WeakSelf(AppointDoctorsInfoViewController);
        [cell setOutpatientAppontBlcok:^(DoctorsInfoModel *model, NSString *string) {
            [weakSelf orderGuahaoNetWorkModel:model string:string];
        }];
        [cell setAlertBlock:^{
            [weakSelf showHudAuto:@"该时段不能预约" andDuration:@"2"];
        }];
        [cell setWeekBlock:^(NSString *week) {
            [weakSelf getNetWork:[week integerValue]];
        }];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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


- (void)getNetWork:(NSInteger)index{
    
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(AppointDoctorsInfoViewController);
    [[THNetWorkManager shareNetWork]getDoctorGuahaoDatesDoctor_id:self.id page_week:index andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        [weakSelf.dataArray removeAllObjects];
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                DoctorsInfoModel * model = [response thParseDataFromDic:dict andModel:[DoctorsInfoModel class]];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.headView confingWithModel:[response.dataDic[@"work_price"] doubleValue]];
            weakSelf.infoArray = response.dataDic[@"work_weeks"];
            [weakSelf.dict1Info setObject:[NSString  stringWithFormat:@"%@",response.dataDic[@"pre_page"]] forKey:@"pre"];
            [weakSelf.dict1Info setObject:response.dataDic[@"next_page"] forKey:@"next"];
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (void)rightAction{

    
}

- (void)orderGuahaoNetWorkModel:(DoctorsInfoModel *)model string:(NSString *)string{
    self.string = model.date;
    if (!model.date) {
        [self showHudAuto:@"请选择预约时间" andDuration:@"2"];
    }else{
        [self showHudWaitingView:WaitPrompt];
        WeakSelf(AppointDoctorsInfoViewController);
        [[THNetWorkManager shareNetWork]orderGuahaoDoctor_id:self.id date:model.date date_type:string andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
            [weakSelf removeMBProgressHudInManaual];
            if (response.responseCode == 1) {
                ConsultingFinishViewController * cvc = [[ConsultingFinishViewController alloc]initWithTableViewStyle:UITableViewStyleGrouped];
                cvc.type = 11;
                cvc.str = response.dataDic[@"order_date_str"];
                [weakSelf.navigationController pushViewController:cvc animated:YES];
//                [weakSelf getOrderGuahaoAccountPayOrder_sn:response.dataDic[@"order_sn"]];
            }else{
                [weakSelf showHudAuto:response.message andDuration:@"2"];
            }
        } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
            [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        }];
    }
}
- (void)getOrderGuahaoAccountPayOrder_sn:(NSString *)text{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(AppointDoctorsInfoViewController);
    [[THNetWorkManager shareNetWork]getOrderGuahaoAccountPayOrder_sn:text andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            
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
