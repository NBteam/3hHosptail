//
//  BookIsPhoneViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BookIsPhoneViewController.h"
#import "BookManagementTableViewCell.h"
#import "PhoneDetailViewController.h"
#import "BookIsPhoneModel.h"
@interface BookIsPhoneViewController ()

@end

@implementation BookIsPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.height = self.tableView.height -44;
    self.isOpenHeaderRefresh = YES;
    self.isOpenFooterRefresh = YES;
    [self getBookIsPhoneData];
}

- (void)getBookIsPhoneData{
    [self showHudAuto:WaitPrompt];
    WeakSelf(BookIsPhoneViewController);
    [[THNetWorkManager shareNetWork] getMyOrdertelListPage:self.pageNO andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                BookIsPhoneModel * model = [response thParseDataFromDic:dict andModel:[BookIsPhoneModel class]];
                [weakSelf.dataArray addObject:model];
            }
            
            

            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        //  重新加载数据
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        //  重新加载数据
    } ];
       
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    BookManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BookManagementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count != 0) {
        [cell confingWithModel:self.dataArray[indexPath.section]];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(BookIsPhoneViewController);
    BookIsPhoneModel *model = self.dataArray[indexPath.section];
    PhoneDetailViewController *phoneDetailVc = [[PhoneDetailViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    phoneDetailVc.ids = model.id;
    [phoneDetailVc setReloadBlock:^{
        [weakSelf headerRequestWithData];
    }];
    [self.navigationController pushViewController:phoneDetailVc animated:YES];
}

#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    
    [self getBookIsPhoneData];
}
- (void)footerRequestWithData
{
    
    [self getBookIsPhoneData];
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
