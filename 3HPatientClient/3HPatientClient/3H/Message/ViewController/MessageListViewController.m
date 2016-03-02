//
//  MessageListViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 16/3/2.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageListTableViewCell.h"
#import "MessageModels.h"
@interface MessageListViewController ()

@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)loadData{
    
    
    [self showHudAuto:WaitPrompt];
    WeakSelf(MessageListViewController);
    
    [[THNetWorkManager shareNetWork] getMsgList:self.typeString andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                MessageListsModel * model = [response thParseDataFromDic:dict andModel:[MessageListsModel class]];
                [weakSelf.dataArray addObject:model];
            }
            
            
            if (weakSelf.dataArray.count == 0) {
                [weakSelf showHudAuto:[NSString stringWithFormat:@"无%@",weakSelf.titleString] andDuration:@"2"];
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
    MessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessageListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithDict:self.dataArray[indexPath.section] imgString:self.imgString];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    MessageListModel *model = self.dataArray[indexPath.section];
    //    MessageListDetailViewController *messageListDetailVc = [[MessageListDetailViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    //    messageListDetailVc.titleString = self.titleString;
    //    messageListDetailVc.imgString = self.imgString;
    //    messageListDetailVc.ids = model.id;
    //    [self.navigationController pushViewController:messageListDetailVc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title{
    return self.titleString;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
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
