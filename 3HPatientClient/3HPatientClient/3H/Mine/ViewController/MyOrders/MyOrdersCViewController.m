//
//  MyOrdersCViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/27.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "MyOrdersCViewController.h"
#import "MyOrdersTableViewCell.h"
#import "OrderModel.h"
#import "OrderListNewModel.h"
#import "AppDelegate.h"
#import "ShopDetailViewController.h"

@interface MyOrdersCViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) UIAlertView * alertView;
@property (nonatomic, strong) NSIndexPath * indexPath;
@end

@implementation MyOrdersCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.height = self.tableView.height - 44;
    self.isOpenFooterRefresh = YES;
    self.isOpenHeaderRefresh = YES;
    [self getNetWork];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PersonalHeadTableViewCell";
    MyOrdersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyOrdersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderListNewModel * model = self.dataArray[indexPath.section];
    WeakSelf(MyOrdersCViewController);
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    [cell setConfirmBlock:^(NSInteger index) {
        OrderListNewModel * model1 = weakSelf.dataArray[indexPath.section];
        weakSelf.indexPath = indexPath;
        if (index == 0 ){
            NSString * price = [NSString stringWithFormat:@"%.2f",[model1.ilist[0][@"price"] doubleValue]* [model1.ilist[0][@"qty"] doubleValue]];
//            weakSelf.priceStr = price;
            [app sendPay_demoName:model1.ilist[0][@"goods_name"] price:price desc:@"desc" order_sn:model1.order_sn];
        }else if (index == 1 ){
            ShopDetailViewController * ShopDetailVc = [[ShopDetailViewController alloc]initWithTableViewStyle:UITableViewStyleGrouped];
            ShopDetailVc.id = model1.ilist[0][@"goods_id"];
            [weakSelf.navigationController pushViewController:ShopDetailVc animated:YES];
        }else if (index == 2 || index == 3){
            [weakSelf.alertView show];
        }
    }];
    [cell confingWithModel:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 205;
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
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(MyOrdersCViewController);
    [[THNetWorkManager shareNetWork]getOrderListPage:self.pageNO kw:@"" type:@"UN_RECEIVE" andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in response.dataDic[@"list"]) {
                OrderListNewModel * model = [response thParseDataFromDic:dic andModel:[OrderListNewModel class]];
//                for (NSDictionary * infoDict in model.ilist) {
//                    OrderModel * oModel = [response thParseDataFromDic:infoDict andModel:[OrderModel class]];
//                    [weakSelf.dataArray addObject:oModel];
//                }
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
- (void)orderReceiveNetWorkId:(NSString *)ids{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(MyOrdersCViewController);
    [[THNetWorkManager shareNetWork]orderReceiveOrder_id:ids andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            [weakSelf getNetWork];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];

}
- (UIAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确认收货" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    }
    return _alertView;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        OrderListNewModel * model1 = self.dataArray[self.indexPath.section];
        [self orderReceiveNetWorkId:model1.id];
    }
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
