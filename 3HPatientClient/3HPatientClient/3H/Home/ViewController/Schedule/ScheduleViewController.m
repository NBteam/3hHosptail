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
@interface ScheduleViewController ()

@property (nonatomic, strong) CalendarView *calendarView;
@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.calendarView];
    
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
            NSLog(@"%@%@%@",year,month,day);
        }];
        
        [_calendarView setCalendarFloatBlock:^(CGFloat f) {
            weakSelf.tableView.top = f;
            weakSelf.tableView.height = DeviceSize.height -_calendarView.height -self.frameTopHeight;
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
