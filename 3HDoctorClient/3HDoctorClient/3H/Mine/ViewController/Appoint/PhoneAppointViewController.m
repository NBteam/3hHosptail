//
//  Phone AppointViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PhoneAppointViewController.h"
#import "PhoneAppointTableViewCell.h"
//预约获取
#import "PhoneAppointSetViewController.h"
//预约设置
#import "PhoneAppointSetViewController.h"
//预约详情
#import "PhoneAppointTDetailViewController.h"
#import "PhoneAppointModel.h"

@interface PhoneAppointViewController ()

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) NSString *month;



@end

@implementation PhoneAppointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.month = @"";
    
    [self phoneAppointData:self.month];
}

- (void)phoneAppointData:(NSString *)data{
    [self.dataArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(PhoneAppointViewController);
    [[THNetWorkManager shareNetWork] getOrderTelMonthListdate_m:data CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            [weakSelf.dataArray removeAllObjects];
            NSLog(@"查看%@",response.dataDic);
//            for (NSDictionary * dict in response.dataDic[@"list"]) {
//                
//            }
            PhoneAppointModel * model = [response thParseDataFromDic:response.dataDic andModel:[PhoneAppointModel class]];
            [weakSelf.dataArray addObject:model];
            
            [weakSelf.tableView reloadData];
            
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
    WeakSelf(PhoneAppointViewController);
    static NSString *identifier = @"idertifier";
    PhoneAppointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PhoneAppointTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    [cell setPhoneAppointBlock:^{
//        [weakSelf.tableView reloadData];
//    }];
    self.cellHeight = [cell confingWithModel:self.dataArray];
    
    [cell.calendarView setCalendarBlock:^(NSString *month) {
        weakSelf.month = month;
        [weakSelf phoneAppointData:month];
    }];
    [cell.calendarView setCalendarBtnBlock:^(NSString *date, NSString *tel) {
        
        // == 0 设置 ===1  详情
        if ([tel isEqualToString:@"0"]) {
            PhoneAppointSetViewController *phoneAppointSetVc = [[PhoneAppointSetViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            phoneAppointSetVc.dateString = date;
            [phoneAppointSetVc setReloadBlock:^{

                [weakSelf phoneAppointData:weakSelf.month];
            }];
            [weakSelf.navigationController pushViewController:phoneAppointSetVc animated:YES];
        }else{
            WeakSelf(PhoneAppointViewController);
            PhoneAppointTDetailViewController *phoneAppointTDetailVc = [[PhoneAppointTDetailViewController alloc] init];
            [phoneAppointTDetailVc setReloadInfo:^{
                [weakSelf phoneAppointData:weakSelf.month];
            }];
            phoneAppointTDetailVc.dateString = date;
            [weakSelf.navigationController pushViewController:phoneAppointTDetailVc animated:YES];
            
        }
        
    }];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        return 0;
    }else{
        return 1;
    }
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
