//
//  PerfectInformationTimeViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PerfectInformationTimeViewController.h"
#import "OutpatientAppointTableViewCell.h"


@interface PerfectInformationTimeViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@end

@implementation PerfectInformationTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.tableView];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (TPKeyboardAvoidingTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height -self.frameTopHeight -44) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(PerfectInformationTimeViewController);
    static NSString *identifier = @"idertifier";
    OutpatientAppointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OutpatientAppointTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cellHeight = [cell confingWithModelWeeks:self.user.work_week Price:self.user.work_price];
    //拿到数据；
    [cell setOutpatientAppontBlcok:^(NSArray *arr,NSString *price) {
        if (arr.count == 0) {
            [weakSelf showHudAuto:@"请选择您的门诊时间" andDuration:@"2"];
        }else if (price.length ==0){
            [weakSelf showHudAuto:@"请选择您的门诊价格" andDuration:@"2"];
        }else{
            if (weakSelf.PerfectInformationTimeBlock) {
                weakSelf.PerfectInformationTimeBlock([arr componentsJoinedByString:@","],price);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (NSString *)title{
    return @"门诊时间";
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
