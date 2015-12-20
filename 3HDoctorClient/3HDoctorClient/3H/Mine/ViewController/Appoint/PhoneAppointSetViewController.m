//
//  PhoneAppointSetViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PhoneAppointSetViewController.h"
#import "PhoneAppointSetTableViewCell.h"
#import "TimeView.h"
#import "PhoneAppointTimesViewController.h"
#import "PhoneAppointSetPriceViewController.h"
@interface PhoneAppointSetViewController ()

@property (nonatomic, copy) NSString *ksTime;
@property (nonatomic, copy) NSString *jsTime;
@property (nonatomic, copy) NSString *scTime;
@property (nonatomic, assign) CGFloat priceFloat;
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
    if ([self.dataArray[0][@"detail"] isEqualToString:@"未选择"]) {
        [self showHudAuto:@"请选择开始时间" andDuration:@"2"];
    }else if ([self.dataArray[1][@"detail"] isEqualToString:@"未选择"]){
        [self showHudAuto:@"请选择结束时间" andDuration:@"2"];
    }else if ([self.dataArray[2][@"detail"] isEqualToString:@"未选择"]){
        [self showHudAuto:@"请选择时长" andDuration:@"2"];
    }else if ([self.dataArray[3][@"detail"] isEqualToString:@"未选择"]){
        [self showHudAuto:@"请选择收费金额" andDuration:@"2"];
    }else{
       [self addTimeItems:self.dataArray[0][@"detail"] jsTime:self.dataArray[1][@"detail"] scTime:self.dataArray[2][@"detail"] Price:[self.dataArray[3][@"detail"] floatValue]];
    }
    
    
    
}

- (void)addTimeItems:(NSString *)ksTime jsTime:(NSString *)jsTime scTime:(NSString *)scTime Price:(CGFloat)price{

    [self showHudAuto:@"保存中..."];
    WeakSelf(PhoneAppointSetViewController);
    [[THNetWorkManager shareNetWork] addTimeItemsdate:self.dateString start_time:ksTime end_time:jsTime minutes:scTime price:price CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            if (weakSelf.reloadBlock) {
                weakSelf.reloadBlock();
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(PhoneAppointSetViewController);
    if (indexPath.row == 0) {
        PhoneAppointTimesViewController *phoneAppointSetTimeVc= [[PhoneAppointTimesViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        phoneAppointSetTimeVc.index = 0;
        [phoneAppointSetTimeVc setTimeVcBlock:^(NSString *time) {
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":@"开始时间",@"detail":time}];

            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:phoneAppointSetTimeVc animated:YES];
    }else if(indexPath.row == 1){
        PhoneAppointTimesViewController *phoneAppointSetTimeVc= [[PhoneAppointTimesViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        phoneAppointSetTimeVc.index = 0;
        [phoneAppointSetTimeVc setTimeVcBlock:^(NSString *time) {
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":@"结束时间",@"detail":time}];

            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:phoneAppointSetTimeVc animated:YES];
    }else if(indexPath.row ==2){
        PhoneAppointTimesViewController *phoneAppointSetTimeVc= [[PhoneAppointTimesViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        
        phoneAppointSetTimeVc.index = 1;
        [phoneAppointSetTimeVc setTimeVcBlock:^(NSString *time) {
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":@"时长",@"detail":time}];
            [weakSelf.tableView reloadData];
        }];
        
        [self.navigationController pushViewController:phoneAppointSetTimeVc animated:YES];
    }else{
        PhoneAppointSetPriceViewController *phoneAppointSetPriceVc = [[PhoneAppointSetPriceViewController alloc] init];
        [phoneAppointSetPriceVc setNameBlock:^(NSString *name) {
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":@"收费",@"detail":name}];
            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:phoneAppointSetPriceVc animated:YES];
    }
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
