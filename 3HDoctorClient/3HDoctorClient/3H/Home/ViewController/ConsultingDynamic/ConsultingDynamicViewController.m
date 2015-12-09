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
#import "RecommendScrollViewLoop.h"
#import "MedicalInformationModel.h"

@interface ConsultingDynamicViewController ()

//@property (nonatomic, strong) ConsultingDynamicHeadView *headView;
@property (nonatomic, strong) RecommendScrollViewLoop *headView;
@property (nonatomic, strong) NSMutableArray * imgArray;
@property (nonatomic, strong) UIView *viewBlack;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UIImageView *imgLogo;
@property (nonatomic, strong) UILabel *labTime;
@end

@implementation ConsultingDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imgArray  = [NSMutableArray array];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.headView addSubview:self.viewBlack];
    [self.headView addSubview:self.labTitle];
    [self.headView addSubview:self.labTime];
    [self.headView addSubview:self.imgLogo];
    self.tableView.tableHeaderView = self.headView;
    [self confingWithModel:nil];
    [self getDetailInfo];
//    [self requestRecommendScrollViewLoopData];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (RecommendScrollViewLoop *)headView{
    if (!_headView) {
        _headView = [[RecommendScrollViewLoop alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width,150* DeviceSize.width/375) animationDuration:3];
        _headView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.1];
    }
    return _headView;
}
- (UIView *)viewBlack{
    if (!_viewBlack) {
        _viewBlack = [[UIView alloc] initWithFrame:CGRectMake(0, self.headView.height - 35, DeviceSize.width, 35)];
        _viewBlack.backgroundColor = [UIColor blackColor];
        _viewBlack.alpha = 0.5;
    }
    return _viewBlack;
}
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.headView.height - 35 +10, DeviceSize.width -20, 15)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = [UIColor colorWithHEX:0xffffff];
    }
    return _labTitle;
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 11, 10, 10)];
        _imgLogo.image = [UIImage imageNamed:@"首页-资讯动态_时间"];
        
    }
    return _imgLogo;
}

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 0, 12)];
        _labTime.textColor = [UIColor colorWithHEX:0x999999];
        _labTime.font = [UIFont systemFontOfSize:12];
    }
    return _labTime;
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
        for (NSDictionary *Dic in response.dataDic[@"list"]) {
            MedicalInformationModel *model = [response thParseDataFromDic:Dic andModel:[MedicalInformationModel class]];
            [weakSelf.imgArray addObject:model];
        }
        NSMutableArray *viewsArray = [@[] mutableCopy];
        for (int i = 0; i < self.imgArray.count; ++i) {
            MedicalInformationModel *model = self.imgArray[i];
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 +DeviceSize.width *i, DeviceSize.width, DeviceSize.width*150/375)];
            [img sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"loading_pic_big"]];
            [viewsArray addObject:img];
        }
        weakSelf.headView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return viewsArray[pageIndex];
        };
        weakSelf.headView.totalPagesCount = ^NSInteger(void){
            return weakSelf.imgArray.count;
        };
        weakSelf.headView.TapActionBlock = ^(NSInteger pageIndex){
            NSLog(@"点击了第%li个",pageIndex);
            MedicalInformationModel *model = weakSelf.imgArray[pageIndex];
        };
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        
    }];
}
- (void)confingWithModel:(NSDictionary *)dic{
    self.labTitle.text = @"千山晚报电子版-鞍山新闻平台";
    self.labTime.text = @"时间";
    CGSize size = [self.labTime.text sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(0, 12)];
    self.labTime.left = DeviceSize.width -size.width -10;
    self.labTime.width = size.width;
    self.imgLogo.left = self.labTime.left -5 -10;
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
