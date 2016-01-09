//
//  ShopViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopTableViewCell.h"
//商品详情
#import "ShopDetailViewController.h"
#import "GoodsListModel.h"
#import "ADView.h"
#import "ShopPicModel.h"

@interface ShopViewController ()

@property (nonatomic, strong) UIImageView *imgHead;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic,retain) ADView * rscrollView;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.tableHeaderView = self.rscrollView;
    self.tableView.separatorColor = self.view.backgroundColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.isOpenFooterRefresh = YES;
    self.isOpenHeaderRefresh = YES;

    [self getPicInfoNetWork];
    [self getNetWork];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rscrollView startTimer];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.rscrollView stopTimer];
}
- (NSMutableArray *)imgArray{
    if (!_imgArray) {
        _imgArray = [NSMutableArray array];
    }
    return _imgArray;
}
#pragma mark UI

- (UIImageView *)imgHead{
    if (!_imgHead) {
        _imgHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 160)];
        _imgHead.backgroundColor = [UIColor grayColor];
    }
    return _imgHead;
}
- (ADView *)rscrollView{
    if (!_rscrollView) {
        _rscrollView = [[ADView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 160*DeviceSize.width/375) imagesArr:self.imgArray];
        WeakSelf(ShopViewController);
        _rscrollView.ADBlock=^(NSInteger tag){
            if (tag>=1) {
                ShopPicModel * model=weakSelf.imgArray[tag-1];
//                if ([[NSString stringWithFormat:@"%@",model.close]isEqualToString:@"0"]) {
//                    WebViewController * wvc=[[WebViewController alloc]init];
//                    wvc.targetUrl=model.targetUrl;
//                    [weak.navigationController pushViewController:wvc animated:YES];
//                }
            }
        };

    }
    return _rscrollView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GoodsListModel * model = self.dataArray[2*indexPath.section];
    [cell confingWithModel:model indexRow:(2*indexPath.section)];
    if (self.dataArray.count==2*indexPath.section+1) {
        [cell hiddenItem];
    }else{
        [cell noHiddenItem];
        GoodsListModel * model = self.dataArray[2*indexPath.section+1];
        [cell confingWithModel:model indexRow:(2*indexPath.section+1)];
    }
    cell.customViewBlock = ^(NSInteger tag){
        GoodsListModel * model = self.dataArray[2 *indexPath.section +tag];
        ShopDetailViewController *shopDetailVc= [[ShopDetailViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        shopDetailVc.id = model.id;
        [self.navigationController pushViewController:shopDetailVc animated:YES];
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArray.count%2) {
        return self.dataArray.count/2+1;
    }
    return self.dataArray.count/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 197;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ShopViewController);
    [[THNetWorkManager shareNetWork]getGoodsListPage:self.pageNO andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in response.dataDic[@"list"]) {
                GoodsListModel * model = [response thParseDataFromDic:dic andModel:[GoodsListModel class]];
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
- (void)getPicInfoNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ShopViewController);
    [[THNetWorkManager shareNetWork]getGoodsFlashCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            for (NSDictionary * dic in response.dataDic[@"list"]) {
                ShopPicModel * model = [response thParseDataFromDic:dic andModel:[ShopPicModel class]];
                [weakSelf.imgArray addObject:model];
                
            }
            [weakSelf.rscrollView configWithArray:weakSelf.imgArray];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (NSString *)title{
    return @"健康商城";
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
