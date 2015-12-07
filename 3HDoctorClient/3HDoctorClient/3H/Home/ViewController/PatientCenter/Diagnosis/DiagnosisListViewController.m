//
//  DiagnosisListViewController.m
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "DiagnosisListViewController.h"
#import "DiagnosisListModel.h"

@interface DiagnosisListViewController ()

@end

@implementation DiagnosisListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self getNetWork];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
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
//    DiagnosisListModel * model = self.dataArray[indexPath.row];
//    cell.textLabel.text = model.diag_name;
    return cell;
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    DepartmentModel * model = self.dataArray[indexPath.row];
    //    if (self.choiceBlock) {
    //        self.choiceBlock(model.id,model.name,model.pid);
    //    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSString *)title{
    return @"医院";
}

- (void)getNetWork{
    WeakSelf(DiagnosisListViewController);
    [[THNetWorkManager shareNetWork]getPatientDiagnosisListMid:@"" andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        [weakSelf.dataArray removeAllObjects];
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                DiagnosisListModel * model = [response thParseDataFromDic:dict andModel:[DiagnosisListModel class]];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
        } else {
            [weakSelf showHudAuto:response.message];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt];
    }];
    [weakSelf showHudWaitingView:WaitPrompt];
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
