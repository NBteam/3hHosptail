//
//  ArchiveDescViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/31.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "ArchiveDescViewController.h"
#import "ArchiveDescCell.h"
#import "ArchiveDetailViewController.h"

@interface ArchiveDescViewController ()
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSDictionary * dict;
@end

@implementation ArchiveDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dict = [NSDictionary dictionary];
    self.title = [NSString stringWithFormat:@"%@的健康档案",self.titleStr];
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
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellName = @"cellId";
    ArchiveDescCell * cell  = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[ArchiveDescCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellHeight = [cell cinfigWithModel:self.dict index:indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ArchiveDescViewController);
    [[THNetWorkManager shareNetWork]getArchiveDescId:self.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            weakSelf.dict = response.dataDic;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArchiveDetailViewController *  avc = [[ArchiveDetailViewController alloc]initWithTableViewStyle:UITableViewStyleGrouped];
    if (indexPath.section == 0) {
        avc.title = @"3H健康管理专家建议及指南";
        avc.detailStr = self.dict[@"zhinan"];
    }else if (indexPath.section == 1){
        avc.title = @"癌症早期筛查风险评估系统";
        avc.detailStr = self.dict[@"xitong"];
    }else if (indexPath.section == 2){
        avc.title = @"PET—CT检查报告";
        avc.detailStr = self.dict[@"jiancha"];
    }else if (indexPath.section == 3){
        avc.title = @"无痛胃镜检查报告";
        avc.detailStr = self.dict[@"baogao"];
    }else if (indexPath.section == 4){
        avc.title = @"常规查体报告";
        avc.detailStr = self.dict[@"changgui"];
    }
    avc.index = indexPath.section;
    [self.navigationController pushViewController:avc animated:YES];
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
