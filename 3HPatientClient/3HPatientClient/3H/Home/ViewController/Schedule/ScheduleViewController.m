//
//  ScheduleViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ScheduleViewController.h"
#import "CalendarView.h"
#import "MessageTableViewCell.h"
#import "ScheduleCalendarModel.h"
#import "ScheduleCalendarDayModel.h"
#import "MyAppointmentViewController.h"
#import "MedicationGuideViewController.h"
#import "ReviewGuideViewController.h"
#import "AllOrderViewController.h"
@interface ScheduleViewController ()

@property (nonatomic, strong) CalendarView *calendarView;

@property (nonatomic, strong) NSMutableArray *dayArray;
@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.calendarView];
    

    [self getHeathMonthTipdate_m:@""];
    //[self getHeathDayTipdate:@""];
}

- (NSMutableArray *)dayArray{
    if (!_dayArray) {
        _dayArray = [[NSMutableArray alloc] init];
    }
    
    return _dayArray;
}

- (void)getHeathMonthTipdate_m:(NSString *)date_m{
    [self.dataArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(ScheduleViewController);
    [[THNetWorkManager shareNetWork] getHeathMonthTipdate_m:date_m andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            ScheduleCalendarModel * model = [response thParseDataFromDic:response.dataDic andModel:[ScheduleCalendarModel class]];
            [weakSelf.dataArray addObject:model];
            weakSelf.calendarView.height = [weakSelf.calendarView reloadCalendarView:weakSelf.dataArray];
            
            weakSelf.tableView.top = weakSelf.calendarView.height;
            weakSelf.tableView.height = DeviceSize.height -_calendarView.height -self.frameTopHeight;
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
    
}

- (void)getHeathDayTipdate:(NSString *)date{
    [self.dayArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(ScheduleViewController);
    [[THNetWorkManager shareNetWork] getHeathDayTipdate:date andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"sssss%@",response.dataDic[@"list"]);
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                ScheduleCalendarDayModel * model = [response thParseDataFromDic:dict andModel:[ScheduleCalendarDayModel class]];
                [weakSelf.dayArray addObject:model];
            }
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
       
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CalendarView *)calendarView{
    WeakSelf(ScheduleViewController);
    if (!_calendarView) {
        _calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0)];
        self.tableView.top = _calendarView.bottom;
        self.tableView.height = DeviceSize.height -_calendarView.height -self.frameTopHeight;
        [_calendarView setCalendarBlock:^(NSString *year, NSString *month, NSString *day) {
            [weakSelf getHeathDayTipdate:[NSString stringWithFormat:@"%@-%@-%@",year,month,day]];
        }];
        
        [_calendarView setCalendarFloatBlock:^(CGFloat f) {
            weakSelf.tableView.top = f;
            weakSelf.tableView.height = DeviceSize.height -_calendarView.height -self.frameTopHeight;
        }];
        
        [_calendarView setCalendarBtnBlock:^(NSString *string) {
            [weakSelf getHeathMonthTipdate_m:string];
        }];
        
    }
    return _calendarView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:self.dayArray[indexPath.section]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dayArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ScheduleCalendarDayModel *model = self.dayArray[indexPath.section];
    
    NSLog(@"测试%@",model);
    if ([model.title isEqualToString:@"预约提醒"]) {
        MyAppointmentViewController *appVc = [[MyAppointmentViewController alloc] init];
        [self.navigationController pushViewController:appVc animated:YES];
    }else if([model.title isEqualToString:@"用药提醒"]){
        MedicationGuideViewController *medicaVc = [[MedicationGuideViewController alloc] init];
        [self.navigationController pushViewController:medicaVc animated:YES];
       
    }else if([model.title isEqualToString:@"复查提醒"]){
        
        ReviewGuideViewController *reviewGuideVc = [[ReviewGuideViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:reviewGuideVc animated:YES];
     
    }else if([model.title isEqualToString:@"订单提醒"]){
        AllOrderViewController *allVc = [[AllOrderViewController alloc] init];
        [self.navigationController pushViewController:allVc animated:YES];
    }else{//系统的不管
       
    }
}

- (NSString *)title{
    return @"健康日程";
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
