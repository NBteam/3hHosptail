//
//  ConsultingDynamicViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingDynamicViewController.h"
#import "ConsultingDynamicHeadView.h"
#import "ConsultingDynamicTableViewCell.h"
//医疗资讯
#import "DynamicDetailViewController.h"
#import "ConsultingDynamicListModel.h"
#import "ConsultingDynamicHeadTableViewCell.h"
@interface ConsultingDynamicViewController ()

@property (nonatomic, strong) ConsultingDynamicHeadView *headView;

//头图专用model
@property (nonatomic, strong) ConsultingDynamicListModel *headModel;
@end

@implementation ConsultingDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
  //  self.tableView.tableHeaderView = self.headView;
    
    //  开启头部，尾部刷新
    self.isOpenHeaderRefresh = YES;
    self.isOpenFooterRefresh = YES;
    [self getConsultingDynamicListData];
  //  [self getConsultingDynamicHeadViewData];
    
}

- (void)getConsultingDynamicHeadViewData{
    WeakSelf(ConsultingDynamicViewController);
    [[THNetWorkManager shareNetWork] getHealthTopsCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        if (response.responseCode == 1) {
            ConsultingDynamicListModel * model = [response thParseDataFromDic:response.dataDic[@"list"][0] andModel:[ConsultingDynamicListModel class]];
            weakSelf.headModel = model;
            [weakSelf.headView confingWithModel:model];
            
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        
    }];
}

- (void)getConsultingDynamicListData{
    [self showHudAuto:WaitPrompt];
    WeakSelf(ConsultingDynamicViewController);
    [[THNetWorkManager shareNetWork] getArtListPage:self.pageNO CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"page%li",weakSelf.pageNO);
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                ConsultingDynamicListModel * model = [response thParseDataFromDic:dict andModel:[ConsultingDynamicListModel class]];
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
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (ConsultingDynamicHeadView *)headView{
//    if (!_headView) {
//        _headView = [[ConsultingDynamicHeadView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 150)];
//        
//        // 单击的 Recognizer
//        UITapGestureRecognizer* allLabelSingleRecognizer;
//        allLabelSingleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewSingleTap)];
//        //点击的次数
//        allLabelSingleRecognizer.numberOfTapsRequired = 1; // 单击
//        //点击的手指数
//        allLabelSingleRecognizer.numberOfTouchesRequired = 1;
//        //给view添加一个手势监测；
//        [_headView addGestureRecognizer:allLabelSingleRecognizer];
//    }
//    return _headView;
//}
//
//- (void)headerViewSingleTap{
//    if (self.headModel) {
//        
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"ConsultingDynamicHeadTableViewCell";
        ConsultingDynamicHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ConsultingDynamicHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[indexPath.row]];
        return cell;
    }else{
        static NSString *identifier = @"idertifier";
        ConsultingDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ConsultingDynamicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[indexPath.row]];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }else{
        return 100.0f;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsultingDynamicListModel *model = self.dataArray[indexPath.section];
    DynamicDetailViewController *dynamicDetailVc = [[DynamicDetailViewController alloc] init];
    dynamicDetailVc.ids = model.id;
    [self.navigationController pushViewController:dynamicDetailVc animated:YES];
}

- (NSString *)title{
    return @"健康资讯";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    [self getConsultingDynamicListData];
}


- (void)footerRequestWithData
{
    [self getConsultingDynamicListData];
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
