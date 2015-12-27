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
@interface ScheduleViewController ()

@property (nonatomic, strong) CalendarView *calendarView;
@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.calendarView];
    
    [self getHeathMonthTipdate_m:@"2016-01"];
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
        _calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width -20, 0)];
        self.tableView.top = _calendarView.bottom;
        self.tableView.height = DeviceSize.height -_calendarView.height -self.frameTopHeight;
        
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
    [cell confingWithModel:indexPath.section];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
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
