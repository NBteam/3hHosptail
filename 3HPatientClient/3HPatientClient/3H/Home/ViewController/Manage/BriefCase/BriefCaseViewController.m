//
//  BriefCaseViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BriefCaseViewController.h"
#import "BriefCaseHeadTableViewCell.h"
#import "BriefCaseTableViewCell.h"
@interface BriefCaseViewController ()

@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation BriefCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];

    [self getBriefCaseData];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getBriefCaseData{
    [self.dataArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(BriefCaseViewController);
    [[THNetWorkManager shareNetWork] getMySickHistoryCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
//            for (NSDictionary * dict in response.dataDic[@"list"]) {
//                InformationModel * model = [response thParseDataFromDic:dict andModel:[InformationModel class]];
//                [weakSelf.dataArray addObject:model];
//            }
            
            [self.dataArray addObject:response.dataDic[@"guomin"]];
            [self.dataArray addObject:response.dataDic[@"blood_type"]];
            [self.dataArray addObject:response.dataDic[@"desc"]];
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
}

#pragma mark -UI

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        static NSString *identifier = @"BriefCaseTableViewCell";
        BriefCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[BriefCaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellHeight = [cell confingWithModel:self.dataArray[indexPath.section]];
        return cell;
    }else{
        static NSString *identifier = @"BriefCaseHeadTableViewCell";
        BriefCaseHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[BriefCaseHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:indexPath.section Title:self.dataArray[indexPath.section]];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return self.cellHeight;
    }else{
        return 45;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (NSString *)title{
    return @"简要病史";
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
