//
//  ArchiveListViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/31.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "ArchiveListViewController.h"
#import "ArchiveListModel.h"
#import "ArchiveDescViewController.h"

@interface ArchiveListViewController ()

@end

@implementation ArchiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的健康档案";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.isOpenFooterRefresh = YES;
    self.isOpenHeaderRefresh = YES;
    [self getNetWork];
    // Do any additional setup after loading the view.
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellName = @"cellId";
    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        UIImageView * imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (45 - 34/2)/2, 19/2, 34/2)];
        imgArrow.image = [UIImage imageNamed:@"arrowImg"];
        [cell.contentView addSubview:imgArrow];
    }
    ArchiveListModel * model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArchiveListModel * model = self.dataArray[indexPath.row];
    ArchiveDescViewController * avc = [[ArchiveDescViewController alloc]initWithTableViewStyle:UITableViewStyleGrouped];
    avc.id = model.id;
    avc.titleStr = model.title;
    [self.navigationController pushViewController:avc animated:YES];
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ArchiveListViewController);
    [[THNetWorkManager shareNetWork]getArchiveListCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            ArchiveListModel * model = [[ArchiveListModel alloc]init];
            model.id = @"2";
            model.title = @"健康档案";
            [weakSelf.dataArray addObject:model];
            [weakSelf.dataArray addObject:model];
//            for (NSDictionary * dic in response.dataDic[@"list"]) {
//                ArchiveListModel * model = [response thParseDataFromDic:dic andModel:[ArchiveListModel class]];
//                [weakSelf.dataArray addObject:model];
//            }
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
