//
//  MedicationTiXingViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 16/2/22.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "MedicationTiXingViewController.h"
#import "MedicationGuideTableViewCell.h"

@interface MedicationTiXingViewController ()

@end

@implementation MedicationTiXingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.separatorColor = self.view.backgroundColor;
    [self getNetWork];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UI

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MedicationGuideTableViewCell";
    MedicationGuideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MedicationGuideTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MessageListModel * model = self.dataArray[indexPath.section];
    [cell confingWithModel:model];
    cell.backgroundColor = self.view.backgroundColor;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 225;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}
- (void)getNetWork{
    [self.dataArray removeAllObjects];
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(MedicationTiXingViewController);
    [[THNetWorkManager shareNetWork] getMyDrugandIds:self.ids CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {

            for (NSDictionary * dic in response.dataDic[@"list"]) {
                MessageListModel * model = [response thParseDataFromDic:dic andModel:[MessageListModel class]];
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

- (NSString *)title{
    return @"用药提醒详情";
}



@end
