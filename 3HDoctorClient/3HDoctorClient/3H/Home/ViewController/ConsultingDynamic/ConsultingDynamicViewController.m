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
#import "InformationModel.h"
#import "ConsultingDynamicHeadView.h"
#import "MedicalInformationModel.h"

@interface ConsultingDynamicViewController ()

//@property (nonatomic, strong) ConsultingDynamicHeadView *headView;
@property (nonatomic, strong) ConsultingDynamicHeadView *headView;
@property (nonatomic, strong) NSMutableArray * imgArray;
@end

@implementation ConsultingDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imgArray  = [NSMutableArray array];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.tableHeaderView = self.headView;
    [self.headView confingWithModel:nil];
    [self getDetailInfo];
//    [self requestRecommendScrollViewLoopData];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (ConsultingDynamicHeadView *)headView{
    if (!_headView) {
        _headView = [[ConsultingDynamicHeadView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width,150* DeviceSize.width/375)];
    }
    return _headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    ConsultingDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ConsultingDynamicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    InformationModel * model = self.dataArray[indexPath.section];
    [cell confingWithModel:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
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
    InformationModel * model = self.dataArray[indexPath.section];
    DynamicDetailViewController *dynamicDetailVc = [[DynamicDetailViewController alloc] init];
    dynamicDetailVc.id = model.id;
    [self.navigationController pushViewController:dynamicDetailVc animated:YES];
}
- (void)getDetailInfo{
    WeakSelf(ConsultingDynamicViewController);
    [weakSelf showHudWaitingView:WaitPrompt];;
    [[THNetWorkManager shareNetWork]getArtListPage:1 pos:20 andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        [weakSelf.dataArray removeAllObjects];
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                InformationModel * model = [response thParseDataFromDic:dict andModel:[InformationModel class]];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
        } else {
            [weakSelf showHudAuto:response.message];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt];
    }];
}

- (void)requestRecommendScrollViewLoopData{
//    [self.imgArray removeAllObjects];
    WeakSelf(ConsultingDynamicViewController);
    [[THNetWorkManager shareNetWork]getDoctorTopsCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
//        for (NSDictionary *Dic in response.dataDic[@"list"]) {
//            MedicalInformationModel *model = [response thParseDataFromDic:Dic andModel:[MedicalInformationModel class]];
//            [weakSelf.imgArray addObject:model];
//        }

    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        
    }];
}


- (NSString *)title{
    return @"资讯动态";
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
