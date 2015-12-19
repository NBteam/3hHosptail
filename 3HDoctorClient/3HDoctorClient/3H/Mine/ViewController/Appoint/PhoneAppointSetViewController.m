//
//  PhoneAppointSetViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PhoneAppointSetViewController.h"
#import "PhoneAppointSetTableViewCell.h"
@interface PhoneAppointSetViewController ()

@end

@implementation PhoneAppointSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"完成"];
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"开始时间",@"detail":@"未选择"},@{@"title":@"结束时间",@"detail":@"未选择"},@{@"title":@"时长",@"detail":@"未选择"},@{@"title":@"收费",@"detail":@"未选择"}]];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction{
    [self addTimeItems];
    
}

- (void)addTimeItems{

    [self showHudAuto:@"保存中..."];
    WeakSelf(PhoneAppointSetViewController);
    [[THNetWorkManager shareNetWork] addTimeItemsdate:@"2015-12-19" start_time:@"23:00" end_time:@"24:00" minutes:@"20" price:100.00 CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);

            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(PhoneAppointSetViewController);
    static NSString *identifier = @"idertifier";
    PhoneAppointSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PhoneAppointSetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    [cell confingWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
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
    return @"预约设置";
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
