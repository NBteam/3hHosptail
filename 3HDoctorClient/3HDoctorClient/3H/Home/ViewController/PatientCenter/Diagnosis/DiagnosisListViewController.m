//
//  DiagnosisListViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "DiagnosisListViewController.h"
#import "DiagnosisListModel.h"
#import "DiagnosisListDetailViewController.h"

@interface DiagnosisListViewController ()

@end

@implementation DiagnosisListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self getDiagosisListData];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getDiagosisListData{
    
    [self.dataArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(DiagnosisListViewController);
    [[THNetWorkManager shareNetWork] getSickListshort:self.diagnosisString CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                DiagnosisListModel * model = [response thParseDataFromDic:dict andModel:[DiagnosisListModel class]];
                [weakSelf.dataArray addObject:model];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithHEX:0x333333];
    DiagnosisListModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.hospitalBlock) {
//        self.hospitalBlock([NSString stringWithFormat:@"%ld",(long)indexPath.row]);
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    DiagnosisListModel *model = self.dataArray[indexPath.row];
    DiagnosisListDetailViewController *diagnosisListDetailVc = [[DiagnosisListDetailViewController alloc] init];
    diagnosisListDetailVc.ids = model.id;
    diagnosisListDetailVc.idx = self.idx;
    diagnosisListDetailVc.mid = self.mid;
    diagnosisListDetailVc.reloadBlock = self.reloadBlock;
    [self.navigationController pushViewController:diagnosisListDetailVc animated:YES];
}

- (NSString *)title{
    return @"诊断名称";
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
