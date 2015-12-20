//
//  AddressListViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressListCell.h"
#import "AddressListDownCell.h"
#import "AddressListModel.h"
#import "AddressAddViewController.h"

@interface AddressListViewController ()
@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.title = @"收货地址";
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 5) {//self.dataArray.count-1
        static NSString * cellId = @"AddressListCell";
        AddressListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[AddressListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
//        AddressListModel * model  = self.dataArray[indexPath.row    ];
        self.cellHeight = [cell configWithModel:nil];
        return cell;
    }else{
        static NSString * cellId = @"AddressListDownCell";
        AddressListDownCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[AddressListDownCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        return 44;
    }
    return self.cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        AddressAddViewController * AddAddressVc = [[AddressAddViewController alloc]init];
        [self.navigationController pushViewController:AddAddressVc animated:YES];
    }
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(AddressListViewController);
    [[THNetWorkManager shareNetWork]getAddressListCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in response.dataDic[@"list"]) {
                AddressListModel * model = [response thParseDataFromDic:dic andModel:[AddressListModel class]];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
            //  结束头部刷新
            [weakSelf.tableView.header endRefreshing];
            //  结束尾部刷新
            [weakSelf.tableView.footer endRefreshing];
        }else{
            //  结束头部刷新
            [weakSelf.tableView.header endRefreshing];
            //  结束尾部刷新
            [weakSelf.tableView.footer endRefreshing];
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    [self getNetWork];
}
- (void)footerRequestWithData
{
    [self getNetWork];
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
